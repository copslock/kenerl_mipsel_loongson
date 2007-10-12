Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 19:19:50 +0100 (BST)
Received: from tool.snarl.nl ([82.95.241.19]:40456 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20031237AbXJLSTm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2007 19:19:42 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 52B225E1E7;
	Fri, 12 Oct 2007 20:19:36 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0ahjVYcNGKpB; Fri, 12 Oct 2007 20:19:35 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id D10355E1E6; Fri, 12 Oct 2007 20:19:35 +0200 (CEST)
Date:	Fri, 12 Oct 2007 20:19:35 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	kaka <share.kt@gmail.com>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips@linux-mips.org
Subject: Re: Unknown symbol register_framebuffer
Message-ID: <20071012181935.GD23856@dusktilldawn.nl>
References: <eea8a9c90710120551x66311e20pfd639edb9daf68fc@mail.gmail.com> <Pine.LNX.4.64.0710121513560.7335@anakin> <eea8a9c90710120756j7fb633fdjfc9704c447133a05@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <eea8a9c90710120756j7fb633fdjfc9704c447133a05@mail.gmail.com>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kaka,

On Fri, Oct 12, 2007 at 08:26:26PM +0530, kaka wrote:
> On 10/12/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > As mentioned before, please talk to the supplier of your module about
> > these references to `printf', `malloc', and `free'.
> >=20
> COuld you plz let us know how to link the kernel symbol so that the KLM
> brcmstfb.ko can find the symbols?

The mentioned routines are not part of the kernel. They are part
of you C-library. Please do understand that the Linux kernel does
(and can) not use any external library. It's a huge beast on it's
own. Hence it's not possible to link the kernel to these library
routines.

Look into kernel source for clues on how to replace those
routines. :)=20


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHD7q3bxf9XXlB0eERAqjyAKCv0+6x0oy5KpQ3HmKfSuhODlP3JACgleQT
D934lpbuHHGV1El1oPcRAXg=
=dpSA
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
