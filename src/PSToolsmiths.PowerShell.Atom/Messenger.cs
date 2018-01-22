using Microsoft.PowerShell.EditorServices;
using Microsoft.PowerShell.EditorServices.Extensions;
using Microsoft.PowerShell.EditorServices.Protocol.MessageProtocol;
using Microsoft.PowerShell.EditorServices.Utility;

namespace PSToolsmiths.PowerShell.Atom
{
    internal class Messenger
    {
        public PowerShellContext PowerShellContext { get; }

        public IMessageSender MessageSender { get; }

        public IMessageHandlers MessageHandlers { get; }

        private Messenger(EditorObject editorObject)
        {
            Validate.IsNotNull(nameof(editorObject), editorObject);

            PowerShellContext = (PowerShellContext)editorObject.Components.Get(typeof(PowerShellContext));
            MessageSender = (IMessageSender)editorObject.Components.Get(typeof(IMessageSender));
            MessageHandlers = (IMessageHandlers)editorObject.Components.Get(typeof(IMessageHandlers));
        }

        public static Messenger Create(EditorObject editorObject) {
            return new Messenger(editorObject);
        }
    }
}
