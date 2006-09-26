Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 16:58:40 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:4818 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20037632AbWIZP6i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 16:58:38 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id D5D985DF7F;
	Tue, 26 Sep 2006 17:58:32 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ce+5B-DEzYAD; Tue, 26 Sep 2006 17:58:32 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 7E4955DF06; Tue, 26 Sep 2006 17:58:32 +0200 (CEST)
Date:	Tue, 26 Sep 2006 17:58:32 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	s c <steve.carren@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: How is the au1000_gpio char driver used?
Message-ID: <20060926155832.GC17027@dusktilldawn.nl>
References: <2e134a330609260839l5ab33123p4e712a8fe4e0b60b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <2e134a330609260839l5ab33123p4e712a8fe4e0b60b@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Tue, Sep 26, 2006 at 11:39:41AM -0400, s c wrote:
> I would like to use the au1000_gpio char driver to blink some status
> lights. Specifically, I would like to control the hex leds on the
> dbau1500 development board. Preferably via shell script.

http://free-electrons.com/pub/mirror/devmem2.c is your friend.

On a DBAu1100 for instance I have a nice example:

	$ while true; do
	> 	for i in 7 B D E D B; do
	>			./devmem2 0x0E000018 w 0x00000${i}03
	>			sleep 0.01
	>		done
	> done > /dev/null
	$

Remember the days of the Night Rider? You will see LED D5, D6, D7
and D8 flash in a nice manner.

In the same way you must be able to alter the hex leds.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFGU4obxf9XXlB0eERAmuVAKDJg7JF64imrVZ/4rXM/wvJZlOcDgCgs6U+
okwhQPxCVTl0KvPwhCjREXY=
=7UN1
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
