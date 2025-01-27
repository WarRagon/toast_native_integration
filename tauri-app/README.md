tauri-app
```
pnpm tauri plugin new --android example
```
tauri-app/tauri-plugin-example
```
pnpm install

pnpm run build
```
tauri-app/src-tauri/Carog.toml
```
[dependencies]
tauri-plugin-example = { path = "../tauri-plugin-example/" }
```
tauri-app/package.json
```
"dependencies": {
    "tauri-plugin-example-api": "file:./tauri-plugin-example"
}
```
tauri-app/src-tauri/src/lib.rs
```
tauri::Builder::default()
    .plugin(tauri_plugin_example::init())
```
tauri-app/src-tauri/capabilities/default.json
```
"permissions": [
    "example:default"
]
```
tauri-app
```
pnpm install

pnpm tauri android dev
```
tauri-app/tauri-plugin-example/android/src/main/java/ExamplePlugin.kt
```
import android.widget.Toast

@InvokeArg
class ToastArgs {
  var value: String? = null
}

@TauriPlugin
class ExamplePlugin(private val activity: Activity) : Plugin(activity) {
  @Command
  fun toast(invoke: Invoke) {
    val args = invoke.parseArgs(PingArgs::class.java)

    Toast.makeText(activity, args.value, Toast.LENGTH_SHORT).show()
  }
}
```
tauri-app/tauri-plugin-example/src/models.rs
```
#[derive(Debug, Deserialize, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ToastRequest {
  pub value: String,
}
```
tauri-app/tauri-plugin-example/src/commands.rs
```
#[command]
pub(crate) async fn toast<R: Runtime>(
    app: AppHandle<R>,
    payload: ToastRequest,
) -> Result<()> {
    app.example().toast(payload)
}
```
tauri-app/tauri-plugin-example/src/mobile.rs
```
impl<R: Runtime> Example<R> {
  pub fn toast(&self, payload: ToastRequest) -> crate::Result<()> {
    self.0
        .run_mobile_plugin("toast", payload)
        .map_err(Into::into)
  }
}
```
tauri-app/tauri-plugin-example/guest-js/index.ts
```
export async function toast(value: string): Promise<void> {
  await invoke<{ value?: string }>("plugin:example|toast", {
      payload: {
          value,
      },
  }).then((r) => (r.value ? r.value : null));
}
```
tauri-app/tauri-plugin-example/build.rs
```
const COMMANDS: &[&str] = &["ping"];
->
const COMMANDS: &[&str] = &["ping", "toast"];
```
tauri-app/tauri-plugin-example/permissions/default.toml
```
permissions = ["allow-ping", "allow-toast"]
->
permissions = ["allow-ping", "allow-toast"]
```
tauri-app/tauri-plugin-example
```
pnpm build
```
tauri-app
```
pnpm remove tauri-plugin-example-api
```
tauri-app/package.json
```
"dependencies": {
    "tauri-plugin-example-api": "file:./tauri-plugin-example"
}
```
tauri-app
```
pnpm install
```




