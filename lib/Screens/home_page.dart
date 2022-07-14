import 'package:flutter/material.dart';
import 'package:github_search_users/Functions/change_theme.dart';
import 'package:github_search_users/Functions/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search Github Users"),
          actions: [
            IconButton(
              onPressed: Provider.of<ChangeTheme>(context, listen: false)
                  .toggleThemeMode,
              icon: Provider.of<ChangeTheme>(context).themeMode
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: MediaQuery.of(context).size.height * .175),
            ListTile(
              title: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Search Github User by username",
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  await Provider.of<ServicesApi>(context, listen: false)
                      .getUser(_controller.text);
                  setState(() {});
                },
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30.0),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: Provider.of<ServicesApi>(context)
                                .getAuser !=
                            null
                        ? NetworkImage(Provider.of<ServicesApi>(context)
                            .getAuser!
                            .avatar_url!)
                        : const NetworkImage(
                            'https://pngimg.com/uploads/github/github_PNG90.png'),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Name:'),
                      const SizedBox(width: 5.0),
                      Provider.of<ServicesApi>(context).getAuser != null
                          ? Text(Provider.of<ServicesApi>(context)
                                  .getAuser!
                                  .name ??
                              Provider.of<ServicesApi>(context)
                                  .getAuser!
                                  .login!)
                          : const Text("The OctoCat"),
                    ],
                  ),
                  Provider.of<ServicesApi>(context).getAuser != null
                      ? Text(
                          '@${Provider.of<ServicesApi>(context).getAuser!.login!}')
                      : const Text("@octocat"),
                  Provider.of<ServicesApi>(context).getAuser != null
                      ? Text(Provider.of<ServicesApi>(context).getAuser!.bio ??
                          "This user has no bio")
                      : const Text("This user has no bio"),
                  Provider.of<ServicesApi>(context).getAuser != null
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("joined at:"),
                            const SizedBox(width: 5.0),
                            Text(Provider.of<ServicesApi>(context)
                                .getAuser!
                                .created_at!
                                .split('T')
                                .first),
                          ],
                        )
                      : Container(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 35.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text("repos"),
                            const SizedBox(height: 5.0),
                            Provider.of<ServicesApi>(context).getAuser != null
                                ? Text(Provider.of<ServicesApi>(context)
                                    .getAuser!
                                    .public_repos
                                    .toString())
                                : const Text("0"),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("fowllowers"),
                            const SizedBox(height: 5.0),
                            Provider.of<ServicesApi>(context).getAuser != null
                                ? Text(Provider.of<ServicesApi>(context)
                                    .getAuser!
                                    .followers
                                    .toString())
                                : const Text("0"),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("following"),
                            const SizedBox(height: 5.0),
                            Provider.of<ServicesApi>(context).getAuser != null
                                ? Text(Provider.of<ServicesApi>(context)
                                    .getAuser!
                                    .following
                                    .toString())
                                : const Text("0"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Provider.of<ServicesApi>(context).getAuser != null
                      ? TextButton(
                          onPressed: () async {
                            final Uri _url = Uri.parse(
                                Provider.of<ServicesApi>(context, listen: false)
                                    .getAuser!
                                    .html_url!);
                            if (!await launchUrl(_url)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Couldn't lauch this url")));
                            }
                          },
                          child: Text(
                              "go to @${Provider.of<ServicesApi>(context).getAuser!.login} github page"),
                        )
                      : Container(),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
