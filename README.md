[![All Contributors](https://img.shields.io/badge/all_contributors-13-orange.svg?style=flat-square)](#contributors)

<p align="center">
  <br />
  <img src="./assets/logo-readme.svg" width="600" /> 
  <br />
</p>
<p align="center">
 <a href="#installation">Installation</a> • 
 <a target="_blank" href="https://astrocoders.dev/reform">Official Docs</a> • 
 <a href="#features">Features</a> •
 <a href="#usage">Usage</a> 
</p>
<br/>
<br/>
<hr />
<br/>

## Installation

```
yarn add bs-reform reschema
```

Then add it to bsconfig.json

```
"bs-dependencies": [
 "bs-reform",
 "reschema"
]
```

Then add lenses-ppx

```
yarn add lenses-ppx@4.0.0 -D
```

And update your bsconfig.json with `ppx-flags`

```
"ppx-flags": [
 "lenses-ppx/ppx"
]
```

## Quick guide

<details>
  <summary>Show</summary>
  
```reason
open BsReform;

module StateLenses = [%lenses
  type state = {
    description: string,
    title: string,
    acceptTerms: bool,
  }
];

module PostAddForm = ReForm.Make(StateLenses);


[@react.component]
let make = () => {
  let form: PostAddForm.api =
    PostAddForm.use(
      ~validationStrategy=OnDemand,
      ~schema={
        PostAddForm.Validation.(Schema(
          string(~min=20, ~minError="Title needs to be greater than 20", Title)
          + nonEmpty(Description),
          + true_(~error="You must accept the terms", AcceptTerms)
        |]));
      },
      ~onSubmit=
        ({state}) => {
          Js.log2("title", state.values.description);
          Js.log2("description", state.values.description);
          Js.log2("acceptTerms", state.values.description);
          None;
        },
      ~initialState={title: "", description: "", acceptTerms: false},
      (),
    );

  <form
    onSubmit={event => {
      event->ReactEvent.Synthetic.preventDefault
      reform.submit();
    }}>

    <input
      type_="text"
      placeholder="Title"
      value=form.values.title
      onChange={event => ReactEvent.Form.target(event)##value |> handleChange(Title)}
    />

    {form.getFieldError(Title)->Belt.mapWithDefault(React.null, React.string)}

    <input
      type_="text"
      placeholder="Description"
      value=form.values.description
      onChange={event => ReactEvent.Form.target(event)##value |> handleChange(Title)}
    />

    {form.getFieldError(Description)->Belt.mapWithDefault(React.null, React.string)}

    <input
      type_="checkbox"
      value={string_of_bool(form.values.acceptTerms)}
      onChange={event =>
        ReactEvent.Form.target(event)##checked |> handleChange(AcceptTerms)
      }
    />

    {form.getFieldError(AcceptTerms)->Belt.mapWithDefault(React.null, React.string)}

    <button type_="submit" disabled={form.formState == Submitting}> "Submit"->React.string </button>
  </form>
};
```

</details>

## Installation

```
yarn add bs-reform reschema
```

Then add it to bsconfig.json

```
"bs-dependencies": [
 "bs-reform",
 "reschema"
]
```

Then add lenses-ppx

```
yarn add lenses-ppx -D
```

And update your bsconfig.json with `ppx-flags`

```
"ppx-flags": [
 "lenses-ppx/ppx"
]
```

## Features

- Hook API
- Schema API
- Type safe, `handleChange` properly infers the value of the field it is handling
- Context Provider
- Field component
- Validation strategy, OnDemand and OnChange

## What this is and why

Code that deals with strongly typed forms can quickly become walls of repeated text.
We created ReForm to be both deadly simple and to make forms sound good leveraging ReasonML's powerful typesytem.
Even the schemas we use are nothing more than constructors built-in in the language itself with a small size footprint.

#### Contributing

Requisites:

- jq
- node
- esy

Setup your env with:

```
$ esy
```

Then:

```
yarn install
```

##### Running

Run everything in watch mode and serve the `demo` app with:

```
make serve
```

#### Alternatives

- [Formality](https://github.com/alexfedoseev/re-formality)

#### Publishing

```
lerna version major|patch|minor
```

and then

```
lerna publish
```

#### Support

We usually hang out at https://discord.gg/reasonml or https://reasonml.chat so feel free to ask anything there.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://www.thomasdeconinck.fr"><img src="https://avatars2.githubusercontent.com/u/1548421?v=4" width="100px;" alt=""/><br /><sub><b>Thomas Deconinck</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=DCKT" title="Documentation">📖</a> <a href="https://github.com/Astrocoders/reform/commits?author=DCKT" title="Code">💻</a></td>
    <td align="center"><a href="http://twitter.com/fakenickels"><img src="https://avatars0.githubusercontent.com/u/1283200?v=4" width="100px;" alt=""/><br /><sub><b>Gabriel Rubens</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=fakenickels" title="Code">💻</a> <a href="https://github.com/Astrocoders/reform/issues?q=author%3Afakenickels" title="Bug reports">🐛</a> <a href="#ideas-fakenickels" title="Ideas, Planning, & Feedback">🤔</a> <a href="#content-fakenickels" title="Content">🖋</a> <a href="https://github.com/Astrocoders/reform/commits?author=fakenickels" title="Documentation">📖</a></td>
    <td align="center"><a href="https://twitter.com/lucasbesen"><img src="https://avatars3.githubusercontent.com/u/13984388?v=4" width="100px;" alt=""/><br /><sub><b>Lucas Besen</b></sub></a><br /><a href="#maintenance-lucasbesen" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://github.com/JeffersonCarvalh0"><img src="https://avatars1.githubusercontent.com/u/11946020?v=4" width="100px;" alt=""/><br /><sub><b>Jefferson Carvalho</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=JeffersonCarvalh0" title="Code">💻</a></td>
    <td align="center"><a href="https://gtluizmoratelli.itch.io"><img src="https://avatars2.githubusercontent.com/u/24661951?v=4" width="100px;" alt=""/><br /><sub><b>Luiz Augusto Moratelli</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=LuizMoratelli" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/amythos"><img src="https://avatars0.githubusercontent.com/u/959296?v=4" width="100px;" alt=""/><br /><sub><b>amythos</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=amythos" title="Code">💻</a></td>
    <td align="center"><a href="http://www.lallinuorteva.fi"><img src="https://avatars3.githubusercontent.com/u/7643715?v=4" width="100px;" alt=""/><br /><sub><b>Lalli Nuorteva</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/issues?q=author%3Alalnuo" title="Bug reports">🐛</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://playqup.com"><img src="https://avatars0.githubusercontent.com/u/3103241?v=4" width="100px;" alt=""/><br /><sub><b>Matt</b></sub></a><br /><a href="#maintenance-hew" title="Maintenance">🚧</a></td>
    <td align="center"><a href="https://github.com/kyldvs"><img src="https://avatars1.githubusercontent.com/u/1830497?v=4" width="100px;" alt=""/><br /><sub><b>Kyle Davis</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/pulls?q=is%3Apr+reviewed-by%3Akyldvs" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/ulugbekna"><img src="https://avatars2.githubusercontent.com/u/16353531?v=4" width="100px;" alt=""/><br /><sub><b>Ulugbek Abdullaev</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/issues?q=author%3Aulugbekna" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://khoanguyen.me"><img src="https://avatars2.githubusercontent.com/u/3049054?v=4" width="100px;" alt=""/><br /><sub><b>Khoa Nguyen</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=thangngoc89" title="Code">💻</a></td>
    <td align="center"><a href="http://medson.me"><img src="https://avatars0.githubusercontent.com/u/17956325?v=4" width="100px;" alt=""/><br /><sub><b>Medson Oliveira</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=medson10" title="Code">💻</a> <a href="#ideas-medson10" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://anabastos.me"><img src="https://avatars1.githubusercontent.com/u/10088900?v=4" width="100px;" alt=""/><br /><sub><b>Ana Luiza Portello Bastos</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=anabastos" title="Documentation">📖</a></td>
    <td align="center"><a href="https://freddy03h.github.io"><img src="https://avatars1.githubusercontent.com/u/1412159?v=4" width="100px;" alt=""/><br /><sub><b>Freddy Harris</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/issues?q=author%3AFreddy03h" title="Bug reports">🐛</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/arthurbarroso"><img src="https://avatars3.githubusercontent.com/u/48794198?v=4" width="100px;" alt=""/><br /><sub><b>arthur</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=arthurbarroso" title="Documentation">📖</a> <a href="https://github.com/Astrocoders/reform/commits?author=arthurbarroso" title="Code">💻</a></td>
    <td align="center"><a href="http://vmarcosp.dribbble.com"><img src="https://avatars0.githubusercontent.com/u/20327229?v=4" width="100px;" alt=""/><br /><sub><b>Marcos Oliveira</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=vmarcosp" title="Documentation">📖</a> <a href="#design-vmarcosp" title="Design">🎨</a></td>
    <td align="center"><a href="http://cel.so"><img src="https://avatars2.githubusercontent.com/u/12688694?v=4" width="100px;" alt=""/><br /><sub><b>Celso Bonutti</b></sub></a><br /><a href="https://github.com/Astrocoders/reform/commits?author=celsobonutti" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
