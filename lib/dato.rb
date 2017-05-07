class Dato
    def initialize(dia, mes, hora, tipo, cantidad, lluvia)
        @tipo = tipo
        @mes = mes
        @dia = dia
        @hora = hora
        @lluvia = lluvia
        
        if (cantidad.to_i <= 3000)
            @cantidad = "leve"
        elsif (cantidad.to_i <= 5000)
            @cantidad = "moderado"
        elsif (cantidad.to_i <= 8000)
            @cantidad = "alto"
        else
            @cantidad = "muy_alto"
        end
    end

    def to_s
        "#{@dia},#{@mes},#{@hora},#{@tipo},#{@lluvia},#{@cantidad}"
    end
end
