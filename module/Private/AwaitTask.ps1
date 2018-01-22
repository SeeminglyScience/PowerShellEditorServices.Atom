function AwaitTask {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [ValidateNotNull()]
        [System.Threading.Tasks.Task] $Task,

        [ValidateNotNull()]
        [System.Threading.CancellationToken] $CancellationToken
    )
    process {
        if ($null -eq $Task) {
            return
        }

        # Wait for the task to complete without blocking the thread.
        while (-not $Task.AsyncWaitHandle.WaitOne(100)) {
            if ($null -ne $CancellationToken) {
                $CancellationToken.ThrowIfCancellationRequested()
            }
        }

        # Await the task how the await keyword does to unwrap exceptions if they occurred.
        return $Task.GetAwaiter().GetResult()
    }
}
