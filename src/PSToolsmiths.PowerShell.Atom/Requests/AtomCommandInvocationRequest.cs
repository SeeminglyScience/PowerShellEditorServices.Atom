using Microsoft.PowerShell.EditorServices.Protocol.LanguageServer;
using Microsoft.PowerShell.EditorServices.Protocol.MessageProtocol;

namespace PSToolsmiths.PowerShell.Atom.Requests
{
    public class AtomCommandInvocationRequest
    {
        public static readonly RequestType<string, EditorCommandResponse, object, object> Type =
            RequestType<string, EditorCommandResponse, object, object>.Create("powerShell/atomCommandInvocation");
    }
}
