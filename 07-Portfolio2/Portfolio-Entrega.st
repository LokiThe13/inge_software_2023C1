!classDefinition: #AccountReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
AccountReportTest subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'TK 5/31/2023 04:08:51'!
test01EmptyAccountProducesEmptyAccountSummary

	| account summary |
	
	account := ReceptiveAccount new.
	summary := AccountSummary for: account.
	
	self assert: summary report equals: (OrderedCollection with: 'Balance: 0.').! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TK 5/31/2023 04:08:42'!
test02DepositTransactionIsReflectedInAccountSummary

	| account summary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	summary := AccountSummary for: account.
	
	self assert: summary report equals: (OrderedCollection with: 'Deposit for 100.' with: 'Balance: 100.').! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TK 5/31/2023 04:08:36'!
test03WithdrawTransactionIsReflectedInAccountSummary

	| account summary |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	summary := AccountSummary for: account.
	
	self assert: summary report equals: (OrderedCollection with: 'Withdrawal for 100.' with: 'Balance: -100.').! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TK 5/31/2023 01:13:16'!
test04MultipleTransactionsAreReflectedInAccountSummary

	| A B summary |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	Deposit register: 500 on: A.
	Withdraw register: 50 on: A.
	Transfer register: 150 from: A to: B.
	summary := AccountSummary for: A.
	
	self assert: summary report equals: 
	(OrderedCollection 
		with: 'Deposit for 500.'
		with: 'Withdrawal for 50.' 
		with: 'Transfer withdrawal for 150.' 
		with: 'Balance: 300.').! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TK 5/31/2023 05:16:23'!
test05MultipleTransactionsAreReflectedInPortfolioAccountSummary

	| P A B summary |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	P := Portfolio with: A with: B.
	Deposit register: 500 on: A.
	Withdraw register: 50 on: A.
	Transfer register: 150 from: A to: B.
	
	summary := AccountSummary for: P.
	
	self assert: summary report equals: 
	(OrderedCollection 
		with: 'Deposit for 500.'
		with: 'Withdrawal for 50.' 
		with: 'Transfer withdrawal for 150.'
		with: 'Transfer deposit for 150.' 
		with: 'Balance: 450.').! !


!classDefinition: #AccountTreeTest category: 'Portfolio-Solucion'!
AccountReportTest subclass: #AccountTreeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTreeTest methodsFor: 'tests' stamp: 'TK 5/31/2023 07:25:50'!
test01EmptyPortfolioProducesEmptyTree

	| portfolio tree |
	
	portfolio := Portfolio named: 'empty portfolio'.
	tree := AccountTree for: portfolio.
	
	self assert: tree report equals: (OrderedCollection with: 'empty portfolio').! !

!AccountTreeTest methodsFor: 'tests' stamp: 'TK 5/31/2023 07:25:50'!
test02AccountPortfolioProducesLineTree

	| portfolio account tree |
	
	account := ReceptiveAccount named: 'Alice Account'.
	portfolio := Portfolio named: 'Alice Portfolio' with: account.
	tree := AccountTree for: portfolio.
	
	self assert: tree report equals: (OrderedCollection with: 'Alice Portfolio' with: '    Alice Account' ).! !

!AccountTreeTest methodsFor: 'tests' stamp: 'TK 5/31/2023 07:25:50'!
test03NestedPortfolioProducesStaircaseTree

	| P Q R account tree |
	
	account := ReceptiveAccount named: 'Alice Account'.
	R := Portfolio named: 'Alice Portfolio' with: account.
	Q := Portfolio named: 'Smiths Portfolio' with: R.
	P := Portfolio named: 'Joint Investment Funds Portfolio' with: Q.
	tree := AccountTree for: P.
	
	self assert: tree report equals: (OrderedCollection 
		with: 'Joint Investment Funds Portfolio'
		with: '    Smiths Portfolio'
		with: '        Alice Portfolio'
		with: '            Alice Account' ).! !

!AccountTreeTest methodsFor: 'tests' stamp: 'TK 5/31/2023 07:25:50'!
test04SiblingPortfoliosProducesComplexTree

	| A B C D E F G H P Q R S T U V tree result |
	
	A := ReceptiveAccount named: 'Alice Smith Account'.
	B := ReceptiveAccount named: 'Bob Smith Account'.
	C := ReceptiveAccount named: 'Corey Stone Account'.
	D := ReceptiveAccount named: 'Diana Stone Account'.
	E := ReceptiveAccount named: 'Everstone Account'.
	F := ReceptiveAccount named: 'Ferrari Account'.
	G := ReceptiveAccount named: 'GHO Account'.
	H := ReceptiveAccount named: 'H&N Account'.
	V := Portfolio named: 'Smiths Portfolio' with: A with: B.
	U := Portfolio named: 'Stones Portfolio' with: C with: D.
	T := Portfolio named: 'Neighbours Portfolio' with: V with: U.
	S := Portfolio named: 'Companies Portfolio' with: E with: F.
	R := Portfolio named: 'NGO Portfolio' with: G with: H.
	Q := Portfolio named: 'USA Portfolio' with: S with: T.
	P := Portfolio named: 'Global Portfolio'.
	P add: Q; add: R.
	tree := AccountTree for: P.
	
	result := OrderedCollection new.
	result
		add: 'Global Portfolio';
		add: '    USA Portfolio';
		add: '        Companies Portfolio';
		add: '            Everstone Account';
		add: '            Ferrari Account';
		add: '        Neighbours Portfolio';
		add: '            Smiths Portfolio';
		add: '                Alice Smith Account';
		add: '                Bob Smith Account';
		add: '            Stones Portfolio';
		add: '                Corey Stone Account';
		add: '                Diana Stone Account';
		add: '    NGO Portfolio';
		add: '        GHO Account';
		add: '        H&N Account'	.
	
	self assert: tree report equals: result.! !

!AccountTreeTest methodsFor: 'tests' stamp: 'TK 5/31/2023 07:25:50'!
test05ReceptiveAccountCannotProducePortfolioTree

	| account tree |
	
	account := ReceptiveAccount named: 'Alices Totally Legit Portfolio'.
	
	self
		should: [ tree := AccountTree for: account ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: PortfolioReport errorCanOnlyOperateOnPortfolio equals: anError messageText.
			self assert: tree equals: nil. ]! !


!classDefinition: #TransactionTreeTest category: 'Portfolio-Solucion'!
AccountReportTest subclass: #TransactionTreeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionTreeTest methodsFor: 'tests' stamp: 'TK 5/31/2023 08:05:21'!
test01SiblingAccountsProducesComplexTree

	| A B C D E F G H P Q R S T U V tree result |
	
	A := ReceptiveAccount named: 'Alice Smith Account'.
	B := ReceptiveAccount named: 'Bob Smith Account'.
	C := ReceptiveAccount named: 'Corey Stone Account'.
	D := ReceptiveAccount named: 'Diana Stone Account'.
	E := ReceptiveAccount named: 'Everstone Account'.
	F := ReceptiveAccount named: 'Ferrari Account'.
	G := ReceptiveAccount named: 'GHO Account'.
	H := ReceptiveAccount named: 'H&N Account'.
	
	Deposit register: 300 on: A.
	Deposit register: 500 on: B.
	Deposit register: 100 on: C.
	Deposit register: 200 on: D.
	Deposit register: 30000000 on: E.
	Deposit register: 10000000 on: F.
	Deposit register: 5000000 on: G.
	Deposit register: 700000 on: H.
	
	Withdraw register: 50 on: A.
	Withdraw register: 100 on: D.	
	Withdraw register: 10000 on: G.	
	
	Transfer register: 100 from: B to: C.
	Transfer register: 50000 from: F to: E.
	Transfer register: 10000 from: G to: H.
	
	V := Portfolio named: 'Smiths Portfolio' with: A with: B.
	U := Portfolio named: 'Stones Portfolio' with: C with: D.
	T := Portfolio named: 'Neighbours Portfolio' with: V with: U.
	S := Portfolio named: 'Companies Portfolio' with: E with: F.
	R := Portfolio named: 'NGO Portfolio' with: G with: H.
	Q := Portfolio named: 'USA Portfolio' with: S with: T.
	P := Portfolio named: 'Global Portfolio'.
	P add: Q; add: R.
	tree := TransactionTree for: P.
	
	result := OrderedCollection new.
	result
		add: 'Global Portfolio';
		add: '    USA Portfolio';
		add: '        Companies Portfolio';
		add: '            Everstone Account';
		add: '                Deposit for 30000000.';
		add: '                Transfer deposit for 50000.';
		add: '                Balance: 30050000.';
		add: '            Ferrari Account';
		add: '                Deposit for 10000000.';
		add: '                Transfer withdrawal for 50000.';
		add: '                Balance: 9950000.';
		add: '        Neighbours Portfolio';
		add: '            Smiths Portfolio';
		add: '                Alice Smith Account';
		add: '                    Deposit for 300.';
		add: '                    Withdrawal for 50.';
		add: '                    Balance: 250.';
		add: '                Bob Smith Account';
		add: '                    Deposit for 500.';
		add: '                    Transfer withdrawal for 100.';
		add: '                    Balance: 400.';
		add: '            Stones Portfolio';
		add: '                Corey Stone Account';
		add: '                    Deposit for 100.';
		add: '                    Transfer deposit for 100.';
		add: '                    Balance: 200.';
		add: '                Diana Stone Account';
		add: '                    Deposit for 200.';
		add: '                    Withdrawal for 100.';
		add: '                    Balance: 100.';
		add: '    NGO Portfolio';
		add: '        GHO Account';
		add: '            Deposit for 5000000.';
		add: '            Withdrawal for 10000.';
		add: '            Transfer withdrawal for 10000.';
		add: '            Balance: 4980000.';
		add: '        H&N Account'	;
		add: '            Deposit for 700000.';
		add: '            Transfer deposit for 10000.';
		add: '            Balance: 710000.'.
	
	self assert: tree report equals: result.! !

!TransactionTreeTest methodsFor: 'tests' stamp: 'TK 5/31/2023 22:52:37'!
test02ReceptiveAccountCannotProduceTransactionTree

	| account tree |
	
	account := ReceptiveAccount named: 'Alices Totally Legit Portfolio'.
	
	self
		should: [ tree := TransactionTree for: account ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: PortfolioReport errorCanOnlyOperateOnPortfolio equals: anError messageText.
			self assert: tree equals: nil. ]! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
AccountReportTest subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'TK 5/31/2023 04:07:47'!
test01EmptyAccountHasZeroTransferNet

	| account transferNet |
	
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.
	
	self assert: transferNet report equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TK 5/31/2023 04:23:19'!
test02DepositTransferIsReflectedInAccountSummary

	| A B transferNet |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	Transfer register: 100 from: A to: B.
	transferNet := TransferNet for: B.
	
	self assert: transferNet report equals: 100.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TK 5/31/2023 04:23:12'!
test03WithdrawTransferIsReflectedInAccountSummary

	| A B transferNet |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	Transfer register: 100 from: A to: B.
	transferNet := TransferNet for: A.
	
	self assert: transferNet report equals: -100.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TK 5/31/2023 04:24:42'!
test04MultipleTransfersAreReflectedInTransferNet

	| A B transferNet |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	Deposit register: 500 on: B.
	Transfer register: 300 from: B to: A.
	Transfer register: 100 from: A to: B.
	Transfer register: 50 from: B to: A.
	transferNet := TransferNet for: A.
	
	self assert: transferNet report equals: 250.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TK 5/31/2023 05:16:11'!
test05MultipleTransfersAreReflectedInPortfolioTransferNet

	| P A B C transferNet |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	C := ReceptiveAccount new.
	P := Portfolio with: B with: C.
	Transfer register: 1500 from: A to: C.
	Transfer register: 1000 from: C to: B.
	Transfer register: 300 from: B to: A.
	transferNet := TransferNet for: P.
	
	self assert: transferNet report equals: 1200.! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'TK 5/30/2023 00:53:51'!
test01TransferDeductsAndGrantsAppropiateFunds

	| A B |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	
	Deposit register: 100 on: A.
	Transfer register: 100 from: A to: B.

	self assert: A balance equals: 0.
	self assert: B balance equals: 100.! !

!TransferTest methodsFor: 'tests' stamp: 'TK 5/30/2023 01:33:19'!
test02TransferCanObtainEndpoints

	| A B transfer |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	
	Deposit register: 100 on: A.
	transfer := Transfer register: 100 from: A to: B.
	
	self assert: (transfer withdraw isKindOf: TransferWithdraw).
	self assert: (transfer deposit isKindOf: TransferDeposit).! !

!TransferTest methodsFor: 'tests' stamp: 'TK 5/30/2023 01:33:19'!
test03EndpointsCanObtainTransfer

	| A B transfer payer receiver |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	
	Deposit register: 100 on: A.
	transfer := Transfer register: 100 from: A to: B.
	payer := transfer withdraw.
	receiver := transfer deposit.
	
	self assert: payer transfer equals: transfer.
	self assert: receiver transfer equals: transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'TK 5/31/2023 00:27:38'!
test04CannotTransferToSameAccount

	| A transfer |
	
	A := ReceptiveAccount new.
	
	Deposit register: 100 on: A.
	self
		should: [transfer := Transfer register: 100 from: A to: A.]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: Transfer errorPayerCannotEqualReceiver equals: anError messageText.
			self assert: transfer equals: nil ]! !

!TransferTest methodsFor: 'tests' stamp: 'TK 5/31/2023 00:28:52'!
test05CannotTransferNonPositiveAmount

	| A B transfer |
	
	A := ReceptiveAccount new.
	B := ReceptiveAccount new.
	
	Deposit register: 100 on: A.
	self
		should: [transfer := Transfer register: 0 from: A to: B.]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: Transfer errorCannotTransferNonPositiveAmount equals: anError messageText.
			self assert: transfer equals: nil ]! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'TK 5/31/2023 06:07:19'!
name

	^ name.! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'TK 5/31/2023 05:52:43'!
recordInto: aReport

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'TK 5/31/2023 05:26:55'!
initializeWithName: aName
	
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'reports' stamp: 'TK 5/31/2023 22:31:56'!
recordAccountsInto: aReport
	
	accounts do: [ :anAccount | anAccount recordInto: aReport ].! !

!Portfolio methodsFor: 'reports' stamp: 'TK 5/31/2023 22:32:13'!
recordInto: aReport
	
	aReport recordPortfolio: self.! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TK 5/31/2023 05:37:14'!
named: aName

	^self basicNew initializeWithName: aName; yourself.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TK 5/31/2023 05:37:20'!
named: aName with: anAccount

	^self basicNew initializeWithName: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TK 5/31/2023 05:25:57'!
named: aName with: anAccount with: anotherAccount

	^self basicNew initializeWithName: aName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TK 5/31/2023 05:24:05'!
new

	^self basicNew initializeWithName: 'unnamed';
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TK 5/31/2023 05:25:37'!
with: anAccount

	^self new
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TK 5/31/2023 05:25:20'!
with: anAccount with: anotherAccount

	^self new
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TK 5/31/2023 05:38:05'!
initializeWithName: aName

	super initialize.
	name := aName.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'TK 5/31/2023 22:31:28'!
recordInto: aReport

	aReport recordReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'TK 5/31/2023 22:31:10'!
recordTransactionsInto: aReport

	transactions do: [ :aTransaction | aTransaction recordInto: aReport. ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'TK 5/31/2023 05:36:38'!
named: aName

	^self basicNew initializeWithName: aName;
		yourself! !

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'TK 5/31/2023 05:36:18'!
new

	^self basicNew initializeWithName: 'unnamed';
		yourself! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'initialization' stamp: 'TK 5/31/2023 05:08:03'!
initializeFor: anAccount

	account := anAccount.! !


!AccountReport methodsFor: 'record' stamp: 'TK 5/31/2023 05:09:22'!
recordDeposit: aDeposit

	self subclassResponsibility.! !

!AccountReport methodsFor: 'record' stamp: 'TK 5/31/2023 22:39:01'!
recordPortfolio: aPortfolio

	aPortfolio recordAccountsInto: self.! !

!AccountReport methodsFor: 'record' stamp: 'TK 5/31/2023 22:39:13'!
recordReceptiveAccount: aReceptiveAccount

	aReceptiveAccount recordTransactionsInto: self.! !

!AccountReport methodsFor: 'record' stamp: 'TK 5/31/2023 05:09:15'!
recordTransferDeposit: aTransferDeposit

	self subclassResponsibility.! !

!AccountReport methodsFor: 'record' stamp: 'TK 5/31/2023 05:09:45'!
recordTransferWithdraw: aTransferWithdraw

	self subclassResponsibility.! !

!AccountReport methodsFor: 'record' stamp: 'TK 5/31/2023 05:09:30'!
recordWithdrawal: aWithdraw

	self subclassResponsibility.! !


!AccountReport methodsFor: 'report' stamp: 'TK 5/31/2023 05:08:35'!
report

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'TK 5/31/2023 05:11:16'!
for: anAccount

	^ self new initializeFor: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'report' stamp: 'TK 5/31/2023 06:36:06'!
report

	summary := OrderedCollection new.
	
	account recordInto: self.
	summary add: 'Balance: ' , account balance asString , '.'.
	
	^ summary.! !


!AccountSummary methodsFor: 'record' stamp: 'TK 5/31/2023 05:04:52'!
recordDeposit: aDeposit

	summary add: 'Deposit for ' , aDeposit value asString , '.'.! !

!AccountSummary methodsFor: 'record' stamp: 'TK 5/31/2023 05:05:28'!
recordTransferDeposit: aTransferDeposit

	summary add: 'Transfer deposit for ' , aTransferDeposit value asString , '.'.! !

!AccountSummary methodsFor: 'record' stamp: 'TK 5/31/2023 05:05:18'!
recordTransferWithdraw: aTransferWithdraw

	summary add: 'Transfer withdrawal for ' , aTransferWithdraw value asString , '.'.! !

!AccountSummary methodsFor: 'record' stamp: 'TK 5/31/2023 05:05:07'!
recordWithdrawal: aWithdraw

	summary add: 'Withdrawal for ' , aWithdraw value asString , '.'.! !


!classDefinition: #PortfolioReport category: 'Portfolio-Solucion'!
AccountReport subclass: #PortfolioReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: 'Portfolio-Solucion'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'error' stamp: 'TK 5/31/2023 07:13:32'!
errorCanOnlyOperateOnPortfolio

	^ 'This report can only be produced from a portfolio.'.! !


!PortfolioReport class methodsFor: 'instance creation' stamp: 'TK 5/31/2023 07:52:48'!
for: aPortfolio

	(aPortfolio isKindOf: Portfolio) ifFalse: [ self error: self errorCanOnlyOperateOnPortfolio. ].
	^ super for: aPortfolio.! !


!classDefinition: #AccountTree category: 'Portfolio-Solucion'!
PortfolioReport subclass: #AccountTree
	instanceVariableNames: 'tree tabSpaces indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTree methodsFor: 'report' stamp: 'TK 6/1/2023 14:17:01'!
report

	tree := OrderedCollection new.
	indentation := 0.
	
	account recordInto: self.
	
	^ tree.! !


!AccountTree methodsFor: 'indent' stamp: 'TK 5/31/2023 06:29:41'!
indent: aString

	^ aString padded: #left to: indentation * tabSpaces + aString size with: $ .! !

!AccountTree methodsFor: 'indent' stamp: 'TK 6/1/2023 14:13:18'!
indented: aBlock
	
	indentation  := indentation + 1.
	aBlock value.
	indentation  := indentation - 1.! !


!AccountTree methodsFor: 'record' stamp: 'TK 5/31/2023 06:22:30'!
recordDeposit: aDeposit! !

!AccountTree methodsFor: 'record' stamp: 'TK 6/1/2023 14:14:35'!
recordPortfolio: aPortfolio

	tree add: (self indent: aPortfolio name).
	self indented: [ 	aPortfolio recordAccountsInto: self. ].
	! !

!AccountTree methodsFor: 'record' stamp: 'TK 5/31/2023 22:42:24'!
recordReceptiveAccount: aReceptiveAccount

	tree add: (self indent: aReceptiveAccount name).
	! !

!AccountTree methodsFor: 'record' stamp: 'TK 5/31/2023 06:22:23'!
recordTransferDeposit: aTransferDeposit! !

!AccountTree methodsFor: 'record' stamp: 'TK 5/31/2023 06:22:18'!
recordTransferWithdraw: aTransferWithdraw! !

!AccountTree methodsFor: 'record' stamp: 'TK 5/31/2023 06:22:10'!
recordWithdrawal: aWithdraw! !


!AccountTree methodsFor: 'initialization' stamp: 'TK 5/31/2023 22:45:27'!
initializeFor: aPortfolio

	super initializeFor: aPortfolio.
	tabSpaces := 4.! !


!classDefinition: #TransactionTree category: 'Portfolio-Solucion'!
AccountTree subclass: #TransactionTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionTree methodsFor: 'record' stamp: 'TK 6/1/2023 14:17:48'!
recordReceptiveAccount: aReceptiveAccount

	super recordReceptiveAccount: aReceptiveAccount.
	self indented: [ (AccountSummary for: aReceptiveAccount) report do:
		[ :aSummarizedTransaction | tree add: (self indent: aSummarizedTransaction) ].
	].! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'report' stamp: 'TK 5/31/2023 06:35:56'!
report

	net := 0.
	
	account recordInto: self.
	
	^ net.! !


!TransferNet methodsFor: 'record' stamp: 'TK 5/31/2023 04:44:02'!
recordDeposit: aDeposit! !

!TransferNet methodsFor: 'record' stamp: 'TK 5/31/2023 04:45:14'!
recordTransferDeposit: aTransferDeposit

	net := aTransferDeposit affectBalance: net.! !

!TransferNet methodsFor: 'record' stamp: 'TK 5/31/2023 04:44:54'!
recordTransferWithdraw: aTransferWithdraw

	net := aTransferWithdraw affectBalance: net.! !

!TransferNet methodsFor: 'record' stamp: 'TK 5/31/2023 04:44:13'!
recordWithdrawal: aWithdraw! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'TK 5/31/2023 05:33:05'!
recordInto: aReport
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'summary' stamp: 'TK 5/31/2023 05:33:13'!
recordInto: aReport

	aReport recordDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'initialization' stamp: 'TK 5/30/2023 01:26:10'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!TransferTransaction methodsFor: 'balance' stamp: 'TK 5/30/2023 01:27:31'!
affectBalance: aBalance

	self subclassResponsibility! !


!TransferTransaction methodsFor: 'value' stamp: 'TK 5/30/2023 01:27:11'!
value

	^ transfer value.! !


!TransferTransaction methodsFor: 'transfer' stamp: 'TK 5/30/2023 01:29:45'!
transfer

	^ transfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: 'transfer'!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'TK 5/30/2023 01:26:28'!
for: aTransfer

	^ self new initializeFor: aTransfer. ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'TK 5/30/2023 01:29:03'!
affectBalance: aBalance

	^aBalance + self value.! !


!TransferDeposit methodsFor: 'report' stamp: 'TK 5/31/2023 05:33:50'!
recordInto: aReport

	aReport recordTransferDeposit: self.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'report' stamp: 'TK 5/31/2023 05:33:56'!
recordInto: aReport

	aReport recordTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'TK 5/30/2023 01:28:57'!
affectBalance: aBalance

	^aBalance - self value.! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'TK 5/31/2023 05:34:01'!
recordInto: aReport

	aReport recordWithdrawal: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value payer receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'access' stamp: 'TK 5/30/2023 01:33:19'!
deposit

	^receiver.! !

!Transfer methodsFor: 'access' stamp: 'TK 5/30/2023 01:33:06'!
withdraw

	^payer.! !


!Transfer methodsFor: 'initialization' stamp: 'TK 5/30/2023 01:32:11'!
initializeFor: aValue

	value := aValue.
	payer :=TransferWithdraw for: self.
	receiver := TransferDeposit for: self.! !


!Transfer methodsFor: 'value' stamp: 'TK 5/30/2023 01:35:30'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error' stamp: 'TK 5/31/2023 00:29:52'!
errorCannotTransferNonPositiveAmount

	^ 'Transfer amount must be positive.'.! !

!Transfer class methodsFor: 'error' stamp: 'TK 5/31/2023 00:26:26'!
errorPayerCannotEqualReceiver

	^ 'Payer and receiver accounts must be different.'.! !


!Transfer class methodsFor: 'instance creation' stamp: 'TK 5/31/2023 00:29:27'!
register: aValue from: aPayerAccount to: aReceiverAccount 

	| transfer |
	
	aValue > 0 ifFalse: [self error: self errorCannotTransferNonPositiveAmount. ].
	aPayerAccount = aReceiverAccount ifTrue: [self error: self errorPayerCannotEqualReceiver. ].
	
	transfer := self new initializeFor: aValue.
	aPayerAccount register: transfer withdraw.
	aReceiverAccount register: transfer deposit.
	
	^ transfer.! !
