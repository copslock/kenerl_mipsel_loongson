Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 16:35:45 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:61393 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20037632AbWIZPfo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 16:35:44 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id EDA495DF7F
	for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 17:35:37 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id q4viVk8GpoX2 for <linux-mips@linux-mips.org>;
	Tue, 26 Sep 2006 17:35:37 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 92FC25DF06; Tue, 26 Sep 2006 17:35:37 +0200 (CEST)
Date:	Tue, 26 Sep 2006 17:35:37 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Subject: readb() and writeb() timings
Message-ID: <20060926153537.GB17027@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

And then it's time to play with my external UART again, which I
try to connect to the AMD Alchemy AU1100 processor. The UART
is connected by means of chip-select two and tree of the static
bus controller.

Of course it still doesn't work, but in playing with it I am
dazed and confused about some strange timings I do not
understand. Hopefully somebody over here is willing and able to
explain things a little bit to me.

I have written a small kernel module that will load and tries to
communicate with the UART. I see chip-select, read-enable,
write-enable and the likes toggle, so I'm really talking to the
UART. But in talking to it I do not understand some things
regarding readb() and writeb().

I do two readb()'s after each other like below:

	#define LSR 0x14
	void __iomem *p;
	p=3Dioremap((phys_t)0xDAE000000LL,0x20);
	readb(p+LSR);
	readb(p+LSR);

The readb()'s translate to the MIPS assembly below:

	lbu     $2,20($16)
	lbu     $2,20($16)

If I than use an oscilloscope to measure the time between the
assertion of the chip-select's I get approx. 250ns. So whatever I
try, I will not get two consecutive readb()'s faster than 250ns
after each other. No worries yet, since my friendly UART does not
want things to happen more fast than it can handle.

Next I do two writeb()'s after each other like below:

	/* I have skipped the ioremap() etc... for brevity. */
	writeb(0xA5,p+SPR);
	writeb(0x5A,p+SPR);

The writeb()'s translate to the MIPS assembly below:

	li      $3,165                  # 0xa5
	sb      $3,28($16)
	li      $3,90                   # 0x5a
	sb      $3,28($16)

Now the time between the assertion of the chip-select's is
approx. 175ns. Still no worries and I can again be happy with the
results.

But here comes the great evil (tm). Now I do a readb() right
after a writeb():

	writeb(0x5A,p+SPR);
	readb(p+LSR);

And this translates like expected to:

	li      $3,90                   # 0x5a
	sb      $3,28($16)
	lbu     $3,20($16)

But now suddenly the CPU really cranks up it's engine and is able
to assert the chip-select again within approx. 4ns. And now I'm
in big trouble, since my friendly UART can't cope in this fast
paced world.

I'm also in big trouble, since I do not understand how this is
possible. How can it be that two consecutive readb()'s or
writeb()'s are at least 175ns apart from each other and a readb()
after a writeb() happens fast like hell? Can anybody explain this
to me?

Might be nice to add that a writeb() after a readb() takes again
a long time; approx. 700ns.

Also I have played a lot with the values in the mem_sttime
register and the long delay's in between do not stem from those
values. For some reason it just takes at least 250ns between two
consecutive readb()'s and 175ns between two writeb()'s. Anybody
got a hint why? And then especially why it does not take that
long between a writeb() and a readb()?


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFGUjIbxf9XXlB0eERAkcMAKDnvas5069X+1/5GIoZLMOvL6SrWACgqN1n
MsFSjOd5CPK8EUhkYOghd6M=
=MolE
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
