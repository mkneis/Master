# -*- coding: utf-8 -*-
"""
Created on Tue Jan 11 18:53:21 2022

@author: mknei
"""
try:
    from mrjob.job import MRJob

    def rango_edad(c):
        if c == "DESCONOCIDA":
            return (-1,-1)
        elif c == "MAYOR DE 74 AÑOS":
            return (75, 100)
        else:
            rango_descompuesto = c.split()
            return (int(rango_descompuesto[1]), int(rango_descompuesto[3]))
    
    def lesividad_muertos(datos):
        datos = str(datos)
        if datos == "04":
            return 1
        else:
            return 0

    def suma_lista_de_tuplas(lista):    
        lista = list(lista)
        tuplaA=[]
        tuplaB=[]
        for i in lista:
            tuplaA.append(i[0])
        for i in lista:
            tuplaB.append(i[1])
        a = sum(tuplaA)
        b = sum(tuplaB)
        resultado = (a, b)
        return resultado

    class MRTotalAccEdad(MRJob):
        def mapper(self, _, line):      
            line_arr = line.split(";")
            if line_arr[10] != "RANGO DE EDAD":
                rango = list(rango_edad(line_arr[10]))
                lesividad = lesividad_muertos(line_arr[12])
                yield rango, (1, lesividad)
        
        
        def reducer (self, key, values):
            suma_tuplas = suma_lista_de_tuplas(values)
            if key != [-1,-1]:
                yield key, suma_tuplas
        
    if __name__ == '__main__':
        MRTotalAccEdad.run()
    
except:
    instrucciones = open('mapreduce_instrucciones_de_uso.txt', 'r', encoding = "utf-8")
    print(instrucciones.read())
    instrucciones.close()