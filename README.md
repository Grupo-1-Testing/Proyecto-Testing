# Proyecto Testing Grupo 1

<a href="https://app.travis-ci.com/Grupo-1-Testing/Proyecto-Testing.svg?branch=main"><img src="https://app.travis-ci.com/Grupo-1-Testing/Proyecto-Testing.svg?branch=main" width=100></a>
<a href="https://sonarcloud.io/dashboard?id=Grupo-1-Testing_Proyecto-Testing"><img src="https://sonarcloud.io/images/project_badges/sonarcloud-white.svg" width=100></a>

## Integrantes
* Vicente Espinosa
* José Manuel Domínguez
* Mario Reinike
* Tamara Bendersky
* Bartolomé Peirano
* Antonia Soto

## Uso de la aplicación

### Prerequisitos
* ruby v. 2.7.1

### Instalación y Ejecución
 1. **Instalación:** ejecutar `bundle install`
 2. **Ejecución:** ejecutar `rake run`
 3. **Testeo:** ejecutar `rake test:all`
 4. **Linter**: ejecutar `rubocop` o `rake lint`


## Supuestos
 1. Asumimos que el jugador no puede descubir una celda "Flagged"
 2. Se siguió la separación de la lógica con la vista pero, hay 2 excepciones de casos bordes (posición inválida y poner flag a una celda descubierta) donde imprimimos el error para guiar al usuario en la lógica. (Esto no afecta a los tests).


## Notas
 1. Entre el jueves y viernes tuvimos unos problemas con Travis con un instalador de Ruby que logramos solucionar el sábado cambiando la versión Ruby, esto dejó un espacio donde no se ejecutaban los tests.
