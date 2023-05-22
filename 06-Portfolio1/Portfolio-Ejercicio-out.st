!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account deposit anotherAccount anotherDeposit anotherPortfolio yetAnotherPortfolio evenStillAnotherPortfolio evenYetStillAnotherPortfolio regrettablyAnotherPortfolio yetAnotherAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:16:54'!
test01NewPortfolioHasZeroBalanceAndNoTransactions

	self setup.
	
	self assert: portfolio balance equals: 0.
	self assert: portfolio transactions equals: Set new.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:17:10'!
test02NewPortfolioDoesNotRegisterAnyTransaction

	self setup.
	
	self deny: (portfolio hasRegistered: (Deposit for: 100)).! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:17:39'!
test03PortfolioWithOneAccountHasSameBalanceAndTransactionsAsAccount

	self setup.
	
	Deposit register: 100 on: account.
	portfolio addAccount: account.
	
	self assert: portfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:21:25'!
test04PortfolioWithOneAccountRegistersItsTransactions

	self setup.
	
	portfolio addAccount: account.
	deposit := Deposit for: 100.
	account register: deposit.
	
	self assert: portfolio transactions equals: (Set with: deposit).
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:17:50'!
test05PortfolioRegistersAccountsTransactions

	self setup.
	
	portfolio addAccount: account.
	portfolio addAccount: anotherAccount.
	deposit := Deposit for: 100.
	anotherDeposit := Deposit for: 300.
	account register: deposit.
	anotherAccount register: anotherDeposit.
	
	self assert: portfolio transactions equals: (Set with: deposit with: anotherDeposit).
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: anotherDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:18:01'!
test06PortfolioCantDirectlyContainSameAccountTwice

	self setup.
	
	portfolio addAccount: account.
	
	self should: [ portfolio addAccount: account. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorAccountAlreadyInPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:18:09'!
test07PortfolioCanContainAnotherPortfolio

	self setup.
	
	deposit  := Deposit for: 100.
	anotherDeposit  := Deposit for: 300.
	portfolio addPortfolio: anotherPortfolio.
	portfolio addAccount: account.
	anotherPortfolio addAccount: anotherAccount.
	account register: deposit.
	anotherAccount register: anotherDeposit.
	
	self assert: portfolio balance equals: 400.
	self assert: portfolio transactions equals: (Set with: deposit with: anotherDeposit ).
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: anotherDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:18:20'!
test08PortfolioCanContainMultiplePortfolios

	self setup.
	
	deposit := Deposit for: 100.
	anotherDeposit  := Deposit for: 300.
	portfolio addPortfolio: anotherPortfolio.
	portfolio addPortfolio: yetAnotherPortfolio.
	anotherPortfolio addAccount: account.
	yetAnotherPortfolio addAccount: anotherAccount.
	account register: deposit.
	anotherAccount register: anotherDeposit.
	
	self assert: portfolio balance equals: 400.
	self assert: portfolio transactions equals: (Set with: deposit with: anotherDeposit).
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: anotherDeposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:18:36'!
test09PortfolioCantContainItself

	self setup.
	
	self should: [ portfolio addPortfolio: portfolio. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorPortfolioCantContainItself ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:18:50'!
test10PortfolioCantDirectlyContainSamePortfolioTwice

	self setup.
	
	portfolio addPortfolio: anotherPortfolio.
	
	self should: [ portfolio addPortfolio: anotherPortfolio. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorPortfolioAlreadyInPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:18:58'!
test11AccountCantBeRepeatedDownstream

	self setup.
	
	portfolio addPortfolio: anotherPortfolio.
	anotherPortfolio addAccount: account.
	
	self should: [ portfolio addAccount: account. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorAccountAlreadyInPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:19:05'!
test12AccountCantBeRepeatedUpstream

	self setup.
	
	portfolio addPortfolio: anotherPortfolio.
	portfolio addAccount: account.
	
	self should: [ anotherPortfolio addAccount: account. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorAccountInParentPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:19:10'!
test13PortfolioCantBeRepeatedDownstream

	self setup.
	
	portfolio addPortfolio: anotherPortfolio.
	anotherPortfolio addPortfolio: yetAnotherPortfolio.
	
	self should: [ portfolio addPortfolio: yetAnotherPortfolio. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorPortfolioAlreadyInPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:19:17'!
test14PortfolioCantBeRepeatedUpstream

	self setup.
	
	portfolio addPortfolio: anotherPortfolio.
	anotherPortfolio addPortfolio: yetAnotherPortfolio.
	
	self should: [ yetAnotherPortfolio addPortfolio: portfolio. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorPortfolioInParentPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:19:44'!
test15AccountsInPortfolioCantBeRepeatedDownstream

	self setup.
	
	portfolio addAccount: account.
	anotherPortfolio addAccount: account.
	anotherPortfolio addAccount: anotherAccount.
	
	self should: [ portfolio addPortfolio: anotherPortfolio. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorAccountAlreadyInPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:19:51'!
test16AccountsInPortfolioCantBeRepeatedUpstream

	self setup.
	
	portfolio addPortfolio: anotherPortfolio.
	portfolio addAccount: account.
	yetAnotherPortfolio addAccount: account.
	yetAnotherPortfolio addAccount: anotherAccount.
	
	self should: [ anotherPortfolio addPortfolio: yetAnotherPortfolio. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorAccountInParentPortfolio ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TK 5/21/2023 23:20:09'!
test17PortfolioComplexMergeFailsUpstream

	self setup.
	
	portfolio addAccount: account.
	anotherPortfolio addAccount: anotherAccount.
	yetAnotherPortfolio addAccount: yetAnotherAccount.
	
	evenStillAnotherPortfolio addPortfolio: evenYetStillAnotherPortfolio.
	evenYetStillAnotherPortfolio addPortfolio: regrettablyAnotherPortfolio.
	
	regrettablyAnotherPortfolio addAccount: account.
	
	self should: [ portfolio addPortfolio: evenStillAnotherPortfolio. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |			self assert: anError messageText = Portfolio ErrorAccountAlreadyInPortfolio ]! !


!PortfolioTest methodsFor: 'setup' stamp: 'TK 5/21/2023 23:16:45'!
setup

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	yetAnotherPortfolio := Portfolio new.
	evenStillAnotherPortfolio := Portfolio new.
	evenYetStillAnotherPortfolio := Portfolio new.
	regrettablyAnotherPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	yetAnotherAccount := ReceptiveAccount new.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'balance' stamp: 'TK 5/21/2023 23:14:02'!
balance
	
	^value.! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'TK 5/21/2023 23:14:17'!
balance

	^value negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'balance' stamp: 'TK 5/21/2023 20:35:17'!
balance

	self subclassResponsibility.! !


!FinancialAsset methodsFor: 'transactions' stamp: 'TK 5/21/2023 20:34:59'!
transactions

	self subclassResponsibility.! !


!FinancialAsset methodsFor: 'testing' stamp: 'TK 5/21/2023 20:36:08'!
hasRegistered: aTransaction

	self subclassResponsibility.! !


!FinancialAsset methodsFor: 'access' stamp: 'TK 5/21/2023 20:43:40'!
accounts

	self subclassResponsibility.! !

!FinancialAsset methodsFor: 'access' stamp: 'TK 5/21/2023 21:35:18'!
portfolios

	self subclassResponsibility.! !



!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'access' stamp: 'TK 5/21/2023 20:46:06'!
accounts
	
	^financialAssets inject: OrderedCollection new addingAll: [ :finanlcialAsset | finanlcialAsset accounts ].! !

!Portfolio methodsFor: 'access' stamp: 'TK 5/21/2023 22:25:27'!
parents

	^self isRoot
		ifTrue: [OrderedCollection new]
		ifFalse: [parents inject: OrderedCollection new addingAll: [ :aParent | aParent parents ] ].! !

!Portfolio methodsFor: 'access' stamp: 'TK 5/21/2023 21:37:11'!
portfolios
	
	^financialAssets inject: (OrderedCollection with: self) addingAll: [ :finanlcialAsset | finanlcialAsset portfolios ].! !

!Portfolio methodsFor: 'access' stamp: 'TK 5/21/2023 22:52:13'!
rootAccounts

	^ (self roots) inject: OrderedCollection new addingAll: [ :root | root accounts ]! !

!Portfolio methodsFor: 'access' stamp: 'TK 5/21/2023 22:51:33'!
rootPortfolios

	^ (self roots) inject: OrderedCollection new addingAll: [ :root | root portfolios ]! !

!Portfolio methodsFor: 'access' stamp: 'TK 5/21/2023 22:24:31'!
roots

	^self isRoot
		ifTrue: [OrderedCollection with: self]
		ifFalse: [parents inject: OrderedCollection new addingAll: [ :aParent | aParent roots ] ].! !


!Portfolio methodsFor: 'initialization' stamp: 'TK 5/21/2023 21:15:09'!
initialize

	parents := OrderedCollection new.
	financialAssets := OrderedCollection new.! !


!Portfolio methodsFor: 'financialAssets' stamp: 'TK 5/21/2023 22:59:10'!
addAccount: anAccount 
	
	(self accounts includes: anAccount) 	
		ifTrue: [ self error: self class ErrorAccountAlreadyInPortfolio. ].
	(self rootAccounts includes: anAccount) 	
		ifTrue: [ self error: self class ErrorAccountInParentPortfolio . ].
		
	financialAssets add: anAccount.
	! !

!Portfolio methodsFor: 'financialAssets' stamp: 'TK 5/21/2023 22:56:40'!
addPortfolio: aPortfolio 
	
	(self canAdd: aPortfolio)
		ifTrue: [	financialAssets add: aPortfolio. aPortfolio addParent: self.]
	! !


!Portfolio methodsFor: 'transactions' stamp: 'TK 5/21/2023 18:41:00'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction.! !

!Portfolio methodsFor: 'transactions' stamp: 'TK 5/21/2023 20:51:15'!
transactions
	
	^financialAssets inject: Set new addingAll: [ :each | each transactions asSet. ].! !


!Portfolio methodsFor: 'balance' stamp: 'TK 5/21/2023 20:45:37'!
balance
	
	^financialAssets sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'relations' stamp: 'TK 5/21/2023 21:14:56'!
addParent: aPortfolio

	parents add: aPortfolio.! !


!Portfolio methodsFor: 'testing' stamp: 'TK 5/21/2023 22:37:33'!
doesNotIncludePortfolio: aPortfolio

	^self portfolios includes: aPortfolio! !

!Portfolio methodsFor: 'testing' stamp: 'TK 5/21/2023 22:22:36'!
isRoot

	^parents isEmpty.! !

!Portfolio methodsFor: 'testing' stamp: 'TK 5/21/2023 23:09:12'!
sharesAccounts: aPortfolio

	^(self accounts intersection: aPortfolio accounts) isEmpty not! !


!Portfolio methodsFor: 'validating' stamp: 'TK 5/21/2023 23:10:00'!
canAdd: aPortfolio

	self = aPortfolio 
		ifTrue: [ self error: self class ErrorPortfolioCantContainItself.].
	(self portfolios includes: aPortfolio) 
		ifTrue: [self error: self class ErrorPortfolioAlreadyInPortfolio.].
	(self rootPortfolios includes: aPortfolio) 
		ifTrue:[self error: self class ErrorPortfolioInParentPortfolio.].
	(self sharesAccounts: aPortfolio)
		ifTrue: [self error: self class ErrorAccountAlreadyInPortfolio.].
	(self rootAccounts intersection: aPortfolio accounts) isEmpty 
		ifFalse: [self error: self class ErrorAccountInParentPortfolio.].
	
	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'TK 5/21/2023 19:07:34'!
ErrorAccountAlreadyInPortfolio

	^'Cannot add account as its already part of this portfolio.'.! !

!Portfolio class methodsFor: 'error' stamp: 'TK 5/21/2023 21:27:24'!
ErrorAccountInParentPortfolio

	^'Cannot add account as its already part of a parent of this portfolio.'.! !

!Portfolio class methodsFor: 'error' stamp: 'TK 5/21/2023 20:16:16'!
ErrorPortfolioAlreadyInPortfolio

	^'Cannot add portfolio as its already part of this portfolio.'.! !

!Portfolio class methodsFor: 'error' stamp: 'TK 5/21/2023 21:26:47'!
ErrorPortfolioCantContainItself

	^'Cannot add a portfolio to itself.'.! !

!Portfolio class methodsFor: 'error' stamp: 'TK 5/21/2023 21:43:47'!
ErrorPortfolioInParentPortfolio

	^'Cannot add portfolio as its already part of a parent of this portfolio.'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TK 5/21/2023 20:34:31'!
transactions 

	^transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'TK 5/21/2023 23:14:52'!
balance
	
	^transactions sum: [ :aTransaction | aTransaction balance ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'access' stamp: 'TK 5/21/2023 20:44:37'!
accounts

	^OrderedCollection with: self.! !

!ReceptiveAccount methodsFor: 'access' stamp: 'TK 5/21/2023 21:00:05'!
parents

	^parents.! !

!ReceptiveAccount methodsFor: 'access' stamp: 'TK 5/21/2023 21:36:06'!
portfolios

	^OrderedCollection new.! !
