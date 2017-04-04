class Dato
    def initialize(dia, mes, hora, tipo, cantidad)
        @tipo = tipo
        @mes = mes
        @cantidad = cantidad
        @dia = dia
        @hora = hora
    end
    
    def to_s
        "#{@dia},#{@mes},#{@hora},#{@tipo},#{@cantidad}" 
    end
end