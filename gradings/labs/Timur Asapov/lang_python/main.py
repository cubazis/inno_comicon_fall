from parcer import Parcer

parcer = Parcer('in.txt')
parcer.statements()
out_file = open('out.txt', 'w')
out_file.write(parcer.parser_result)
out_file.close()