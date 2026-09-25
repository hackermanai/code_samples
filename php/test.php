<?php

//
//
/*a*/
/*
a
*/

"a"
"a\"b"
'a'
'a\'b'

"hello $name"
"hello {$name}"
"hello {$user->name}"
"hello {$users[$index]['name']}"

#
# comment

#[Test]
#[Route('/users')]
#[Route('/users', methods: ['GET', 'POST'])]
#[ORM\Entity]
#[ORM\Column(type: 'string', nullable: true)]

:
::
=>
->
?->
.

@
@@

$
$a
$_a
$this
$user
$user->name
$user?->name
$user->getName()
$user?->getName()
User::class
Status::Active
self::TABLE
parent::foo()

0
0.
0..1
0xFF
0b1010
0o755
1.0e-3
1_000
123

foo
foo()
foo(
foo::bar
foo::bar()
foo->bar
foo->bar()
foo?->bar
foo?->bar()

true
false
null

TRUE
FALSE
NULL

+
-
*
**
/
%
=
==
===
!=
!==
<
>
<=
>=
<=>
&&
||
!
&
|
^
~
??
??=
?
?:
++
--
+=
-=
*=
/=
%=
.=

$name = 'Koi';
$count = 10;
$enabled = true;
$nothing = null;

$array = [1, 2, 3];

$config = [
    'name' => 'Koi',
    'enabled' => true,
    'limit' => 100,
];

const APP_NAME = 'Koi Editor';

function add(int $a, int $b): int {
    return $a + $b;
}

function &reference(): mixed {
    static $value = null;
    return $value;
}

function (
    int $a,
    int $b,
) {
    return $a + $b;
}

$closure = function (int $a, int $b): int {
    return $a + $b;
};

$arrow = fn (int $a, int $b): int => $a + $b;

interface Repository {
    public function find(int $id): ?array;
}

trait LogsQueries {
    protected function log(string $query): void {
        echo $query;
    }
}

enum Status: string {
    case Active = 'active';
    case Disabled = 'disabled';
}

class Box {
    public function __construct(
        private readonly mixed $value,
    ) {}

    public function getValue(): mixed {
        return $this->value;
    }
}

final class UserRepository extends Box implements Repository {
    use LogsQueries;

    public function find(int $id): ?array {
        return null;
    }
}

namespace App\Services;

use App\Models\User;
use App\Repositories\Repository;

if ($count < 10) {
    echo "small";
}
else {
    echo "large";
}

foreach ($array as $index => $value) {
    echo "{$index}: {$value}\n";
}

for ($i = 0; $i < 3; $i++) {
    echo $i;
}

while ($enabled) {
    break;
}

try {
    throw new RuntimeException("x");
}
catch (RuntimeException $exception) {
    echo $exception->getMessage();
}
finally {
    echo "done";
}

$result = match ($status) {
    Status::Active => 'enabled',
    Status::Disabled => 'disabled',
    default => 'unknown',
};

$query = <<<SQL
SELECT
    id,
    name,
    email
FROM users
WHERE id = :id;
ORDER BY name;
SQL;

$html = <<<HTML
<div class="user">
    <h1>{$user->name}</h1>
    <p>{$user->email}</p>
</div>
HTML;

$text = <<<'TEXT'
This is literal text.

$user
$user->name
foo()
class Foo {}
"string"
'string'
123;
TEXT;

$script = <<<JS
const user = {
    name: "Koi",
    active: true,
};

if (user.active) {
    console.log(user.name);
}
JS;

#[RepositoryType('database')]
class AttributedRepository {
    #[Inject]
    public function __construct(
        private Repository $repository,
    ) {}

    #[Route(
        '/users/{id}',
        methods: ['GET', 'POST'],
    )]
    public function find(int $id): ?User {
        return $this->repository->find($id);
    }
}


// Incomplete / malformed syntax below.

"

'

"abc\

'abc\

/*

/**
 *

#[

#[Route(

#[Route('/users'

#[Route(
    '/users',
    methods: ['GET', 'POST'],

<<<

<<<SQL

<<<'TEXT'

$query = <<<SQL
SELECT *
FROM users;

$text = <<<'TEXT'
hello
world

$

$foo->

$foo?->

Foo::

Foo::bar(

foo(

foo(

function

function foo

function foo(

function &

function &foo(

class

class Foo

class Foo extends

class Foo implements

interface

interface Foo extends

trait

enum

enum Status:

namespace

namespace App\

use

use App\

new

new Foo(

if (

if ($foo

if ($foo) {

foreach (

foreach ($items as

foreach ($items as $item) {

match (

match ($status) {

try {

catch (

catch (RuntimeException

[
[
[
[1, 2,
[
    'a' => 1,
    'b' => [

{
{
{

(
(
(

?>

