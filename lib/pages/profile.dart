import 'package:autojidelna/main.dart';

import './../every_import.dart';

/*zde se budou nacházet nastavení a možnost zakoupit pro a vidět statistiky profilu Icanteen. Zároveň zde bude systém pro měnění účtů */
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.setHomeWidget});
  final Function(Widget widget) setHomeWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        actions: [
          _appBarLogoutButton(context),
        ],
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Icon, username, credit
                  _userMainInfo(context),
                  //Jméno a příjmení
                  _userPersonalinfo(context),
                  // Platební údaje
                  _userBillingInfo(context),
                  //Autojídelna
                  _autojidelna(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _appBarLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () async {
          Navigator.of(context).pop();
          await loggedInCanteen.logout();
          await Future.delayed(const Duration(milliseconds: 300));
          setHomeWidget(LoggingInWidget(setHomeWidget: setHomeWidget));
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  Container _userMainInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.account_circle, size: 80),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loggedInCanteen.uzivatel!.uzivatelskeJmeno!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Kredit: ${loggedInCanteen.uzivatel!.kredit.toInt()} kč',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _userPersonalinfo(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Osobní Údaje'),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.jmeno != null || loggedInCanteen.uzivatel!.prijmeni != null) {
                      return Text(
                        'Jméno: ${loggedInCanteen.uzivatel!.jmeno ?? ''} ${loggedInCanteen.uzivatel!.prijmeni}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.kategorie != null) {
                      return Text(
                        'Kategorie: ${loggedInCanteen.uzivatel!.kategorie!}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _userBillingInfo(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Platební Údaje'),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.ucetProPlatby != null && loggedInCanteen.uzivatel!.ucetProPlatby != '') {
                      return Text(
                        'Číslo účtu: ${loggedInCanteen.uzivatel!.ucetProPlatby}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.specSymbol != null && loggedInCanteen.uzivatel!.specSymbol != '') {
                      return Text(
                        'Specifický Symbol: ${loggedInCanteen.uzivatel!.specSymbol}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      //return nothing
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.varSymbol != null && loggedInCanteen.uzivatel!.varSymbol != '') {
                      return Text(
                        'Variabilní Symbol: ${loggedInCanteen.uzivatel!.varSymbol}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _autojidelna(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Autojídelna'),
          ),
          const Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FutureBuilder(
              future: loggedInCanteen.readData('statistika:objednavka'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    'Objednávky s autojídelnou: chyba při načítání dat',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                  );
                } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Text(
                    'Objednávky s autojídelnou: ${snapshot.data}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                  );
                } else {
                  return Text(
                    'Objednávky s autojídelnou: 0',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                  );
                }
              },
            ),
          ),
          // const Text('Počet automatických objenávek: 0'),
          // const Text('Počet objednávek chycených burza Catcherem: 0'),
          // const Padding(
          //   padding: EdgeInsets.only(top: 5.0),
          //   child: Text('Pro verze: není dostupná'),
          // ),
          //const Divider(),
          // ElevatedButton(onPressed: () {}, child: const Text('Zakoupit Pro')),
        ],
      ),
    );
  }
}
