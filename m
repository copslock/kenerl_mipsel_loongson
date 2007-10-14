Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 11:49:28 +0100 (BST)
Received: from tool.snarl.nl ([82.95.241.19]:33037 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20027042AbXJNKtU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Oct 2007 11:49:20 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 3403A5DF8D;
	Sun, 14 Oct 2007 12:49:14 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RUNdiejAwT13; Sun, 14 Oct 2007 12:49:13 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id AFFDF5DF2B; Sun, 14 Oct 2007 12:49:13 +0200 (CEST)
Date:	Sun, 14 Oct 2007 12:49:13 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	kaka <share.kt@gmail.com>
Cc:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org
Subject: Re: insmod: unknown symbol error(updated)
Message-ID: <20071014104913.GF7271@dusktilldawn.nl>
References: <eea8a9c90710131101r2a8690f5t80ef21dc756dd50c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <eea8a9c90710131101r2a8690f5t80ef21dc756dd50c@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kaka,

On Sat, Oct 13, 2007 at 11:31:07PM +0530, kaka wrote:
> For that i have we have added supplementary <supp.ko> file to be linked w=
ith
> the main frame buffer driver
> in the makefile to provide the reference for the symbols for the properti=
ary
> graphics code.

If I was you I would look at how other kernel modules export
their to be exported symbols. Try to understand the mechanism by
adding new symbols and use them.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHEfQpbxf9XXlB0eERAhl/AKD5gjYDxZdboaq+sP4vIp5cWVqKoQCg17GP
pb1gQkpMMRaSmiPfG8J8wPk=
=3cYn
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
