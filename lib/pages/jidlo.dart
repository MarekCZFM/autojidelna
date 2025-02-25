import 'package:autojidelna/every_import.dart';

class JidloDetail extends StatelessWidget {
  const JidloDetail({
    super.key,
    required this.datumJidla,
    required this.indexJidlaVeDni,
    required this.indexDne,
    required this.refreshButtons,
    required this.jidelnicekListener,
    required this.softRefresh,
  });
  final DateTime datumJidla;
  final Future<void> Function() softRefresh;
  final int indexDne;
  final Function(BuildContext context) refreshButtons;
  final ValueNotifier<Jidelnicek> jidelnicekListener;

  /// index jídla v jídelníčku dne (0 - první jídlo dne datumJidla)
  final int indexJidlaVeDni;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loggedInCanteen.getLunchesForDay(datumJidla),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          Jidlo jidlo = snapshot.data!.jidla[indexJidlaVeDni];
          String alergeny = '';
          for (Alergen alergen in jidlo.alergeny) {
            alergeny += '${alergen.nazev}, ';
          }
          alergeny = alergeny.substring(0, alergeny.length - 2);
          if (jidlo.kategorizovano == null) {
            return Column(
              children: [
                Text(jidlo.nazev),
                const Divider(),
                Text(alergeny),
                const Text(
                    'používáte záložní rozhraní, které je pouze v nouzi. Pokud tento text vidíte prosím kontaktujte vývojáře - github v "O Aplikaci" - díky!')
              ],
            );
          }
          JidloKategorizovano jidloString = jidlo.kategorizovano!;
          List<Widget> jidloWidgets = [];
          //Soup
          if (jidloString.polevka != null && jidloString.polevka!.trim() != '') {
            jidloWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Polévka',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        jidloString.polevka!,
                        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            );
            jidloWidgets.add(const Divider());
          }
          //Main Dish
          if (jidloString.hlavniJidlo != null && jidloString.hlavniJidlo!.trim() != '') {
            jidloWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Hlavní chod',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        jidloString.hlavniJidlo!,
                        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            );
            jidloWidgets.add(const Divider());
          }
          //Drinks
          if (jidloString.piti != null && jidloString.piti!.trim() != '') {
            jidloWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Pití',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        jidloString.piti!,
                        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            );
            jidloWidgets.add(const Divider());
          }
          //Side dish
          if (jidloString.salatovyBar != null && jidloString.salatovyBar!.trim() != '') {
            jidloWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Přílohy',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        jidloString.salatovyBar!,
                        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            );
            jidloWidgets.add(const Divider());
          }
          //ostatni
          if (jidloString.ostatni != null && jidloString.ostatni!.trim() != '') {
            jidloWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Ostatní',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        jidloString.ostatni!,
                        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            );
            jidloWidgets.add(const Divider());
          }
          //Alergies
          if (alergeny.trim() != '') {
            jidloWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Alergeny',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        alergeny,
                        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            );
            jidloWidgets.add(const Divider());
          }
          jidloWidgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: ObjednatJidloTlacitko(
                softRefresh: softRefresh,
                refreshButtons: refreshButtons,
                indexJidlaVeDni: indexJidlaVeDni,
                indexDne: indexDne,
                jidelnicekListener: jidelnicekListener,
              ),
            ),
          );
          return Scaffold(
            appBar: AppBar(
              title: Text(jidlo.varianta),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: jidloWidgets,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
