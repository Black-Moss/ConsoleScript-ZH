using BepInEx;
using BepInEx.Logging;
using HarmonyLib;

namespace BlackMossTemplate
{
    [BepInPlugin("blackmoss.template", "BlackMossTemplate", "114514.1919.810")]
    public class Plugin : BaseUnityPlugin
    {
        internal static new ManualLogSource Logger;
        private readonly Harmony _harmony = new("blackmoss.template");
        public static Plugin Instance { get; private set; } = null!;

        public void Awake()
        {
            Logger = base.Logger;
            Instance = this;

            _harmony.PatchAll();
            Logger.LogInfo("Here's Black Moss!");
        }
    }
}