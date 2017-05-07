#!/usr/bin/env ruby
require_relative 'pdf'

File.open(ARGV[0], "w") do |file|
    file.write("@relation #{ARGV[1]}\n\n")
    file.write("@attribute dia {Lunes,Martes,Miércoles,Jueves,Viernes,Sábado,Domingo}\n")
    file.write("@attribute mes {Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre}\n")
    file.write("@attribute hora numeric\n")
    file.write("@attribute tipo {Laboral,Festivo,Víspera}\n")
    file.write("@attribute lluvia {si, no}\n")
    file.write("@attribute cantidad {leve,moderado,alto,muy_alto}\n")
    ARGV.shift(2)
    file.write("\n@data\n\n#{analyze_pdf(ARGV).join("\n")}")
end
