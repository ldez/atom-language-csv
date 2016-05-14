describe 'CSV file grammars should tokenize when', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-csv'

    runs ->
      grammar = atom.grammars.grammarForScopeName 'text.csv'

  it 'contains unquoted cells', ->
    {tokens} = grammar.tokenizeLine 'Date,Pupil,Grade'
    expect(tokens).toHaveLength 5
    i = 0
    expect(tokens[i++]).toEqual value: 'Date', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: 'Pupil', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: 'Grade', scopes: ['text.csv', 'string.cell.csv']
    expect(i).toBe 5

  it 'contains double-quoted cells', ->
    {tokens} = grammar.tokenizeLine '"Date","Pupil","Grade"'
    expect(tokens).toHaveLength 12
    i = 0
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.begin.csv']
    expect(tokens[i++]).toEqual value: 'Date', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.ending.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.begin.csv']
    expect(tokens[i++]).toEqual value: 'Pupil', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.ending.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.begin.csv']
    expect(tokens[i++]).toEqual value: 'Grade', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.ending.csv']
    expect(tokens[i++]).toEqual value: '', scopes: ['text.csv', 'string.cell.csv']
    expect(i).toBe 12

  it 'contains double-quoted cells and escaped double-quote', ->
    {tokens} = grammar.tokenizeLine '"15 April","Muniz, Alvin ""Hank""","A"'
    expect(tokens).toHaveLength 15
    i = 0
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.begin.csv']
    expect(tokens[i++]).toEqual value: '15 April', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.ending.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.begin.csv']
    expect(tokens[i++]).toEqual value: 'Muniz, Alvin ', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: '""', scopes: ['text.csv', 'string.cell.csv', 'constant.character.escape.csv']
    expect(tokens[i++]).toEqual value: 'Hank', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: '""', scopes: ['text.csv', 'string.cell.csv', 'constant.character.escape.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.ending.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.begin.csv']
    expect(tokens[i++]).toEqual value: 'A', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: '"', scopes: ['text.csv', 'string.cell.csv', 'variable.ending.csv']
    expect(tokens[i++]).toEqual value: '', scopes: ['text.csv', 'string.cell.csv']
    expect(i).toBe 15

  it 'contains numeric cells', ->
    {tokens} = grammar.tokenizeLine '42,foobar,6'
    expect(tokens).toHaveLength 6
    i = 0
    expect(tokens[i++]).toEqual value: '42', scopes: ['text.csv', 'constant.numeric.cell.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: 'foobar', scopes: ['text.csv', 'string.cell.csv']
    expect(tokens[i++]).toEqual value: ',', scopes: ['text.csv', 'constant.character.separator.csv']
    expect(tokens[i++]).toEqual value: '6', scopes: ['text.csv', 'constant.numeric.cell.csv']
    expect(tokens[i++]).toEqual value: '', scopes: ['text.csv', 'string.cell.csv']
    expect(i).toBe 6
