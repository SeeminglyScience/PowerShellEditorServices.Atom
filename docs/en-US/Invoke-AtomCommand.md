---
external help file: PowerShellEditorServices.Atom-help.xml
Module Name: PowerShellEditorServices.Atom
online version: https://github.com/SeeminglyScience/PowerShellEditorServices.Atom/blob/master/en-US/Invoke-AtomCommand.md
schema: 2.0.0
---

# Invoke-AtomCommand

## SYNOPSIS

Invoke an Atom command.

## SYNTAX

```powershell
Invoke-AtomCommand [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION

The Invoke-AtomCommand function will invoke a command from Atom's command registry.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```powershell
Invoke-AtomCommand 'window:toggle-full-screen'
```

Sends the command "window:toggle-full-screen" to Atom.

## PARAMETERS

### -Name

The name of the command to invoke.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

You can pipe command names to invoke to this function.

## OUTPUTS

### None

This function does not return output to the pipeline.

## NOTES

## RELATED LINKS
