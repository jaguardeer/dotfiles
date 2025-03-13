function prompt { "$($PSStyle.Dim)$env:COMPUTERNAME$($PSStyle.Reset) $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "; }
