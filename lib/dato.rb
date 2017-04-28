class Dato
    def initialize(dia, mes, hora, tipo, cantidad, lluvia)
        @tipo = tipo
        @mes = mes
        @cantidad = cantidad
        @dia = dia
        @hora = hora
        @lluvia = lluvia
    end

    def to_s
        "#{@dia},#{@mes},#{@hora},#{@tipo},#{@cantidad},#{@lluvia}"
    end
end
