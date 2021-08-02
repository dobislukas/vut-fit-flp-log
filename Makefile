#spanning-trees
#xdobis01
#Lukas Dobis
#FLP 2021

flp20-log:
	@swipl -q --goal=main --stand_alone=true -o flp20-log -c flp20-log.pl

run:
	@./flp20-log < test/test01.in

tests:
	@./flp20-log < test/test01.in > test/test01.out
	@./flp20-log < test/test01_reorder.in > test/test01_reorder.out
	@./flp20-log < test/test02.in > test/test02.out
	@./flp20-log < test/test03.in > test/test03.out
	@./flp20-log < test/test04.in > test/test04.out
	@./flp20-log < test/test05.in > test/test05.out
	@./flp20-log < test/test06.in > test/test06.out

clean:
	@rm -f ./test/*.out
	
reset:
	@rm -f flp20-log ./test/*.out
