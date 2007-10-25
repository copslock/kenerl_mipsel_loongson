Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 10:14:13 +0100 (BST)
Received: from lug-owl.de ([195.71.106.12]:473 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S20022350AbXJYJOE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2007 10:14:04 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id 37F96F003A; Thu, 25 Oct 2007 11:14:04 +0200 (CEST)
Date:	Thu, 25 Oct 2007 11:14:04 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-fbdev-users@lists.sourceforge.net
Cc:	directfb-users@directfb.org, directfb-dev@directfb.org,
	linux-mips@linux-mips.org, uclinux-dev@uclinux.org
Subject: Re: [Linux-fbdev-users] Updated:Error opening framebuffer device/Unknown symbol
Message-ID: <20071025091404.GH16774@lug-owl.de>
Mail-Followup-To: linux-fbdev-users@lists.sourceforge.net,
	directfb-users@directfb.org, directfb-dev@directfb.org,
	linux-mips@linux-mips.org, uclinux-dev@uclinux.org
References: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S0QU+l03nqHlODqK"
Content-Disposition: inline
In-Reply-To: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
X-Operating-System: Linux mail 2.6.18-5-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--S0QU+l03nqHlODqK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-10-25 14:25:40 +0530, kaka <share.kt@gmail.com> wrote:
>=20
> Thanks for the overhelming responses.
> I was able to remove the problem of Unknown symbols by linking the proper
> libraries. Now the problem got reduced to the following messages.
>=20
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol free
> insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No such
> file or directory
> #

You cannot use printf(), malloc() and free() in your driver. This is
kernel code, not userland. Kernel has similar functions (printk(),
various memory-allocating functions and kfree()), but keep in mind
that they may behave a bit differently.

> for the above problem i had tried to link "libgcc.a " but those symbols a=
re
> also undefined in it also.

This may not be correct for all cases. libgcc.a is compiled for the
target the compiler is targeted to. In unfortunate cases, there may be
opcodes used in libgcc that are not available in your CPU...

> RECAP:
> While running  the cross compiled directFB example on MIPS chip,*
> We tried to install the framebuffer driver(command given above) after
> creating the node fb0.

You'd post your driver's sources. That way, we'd suggest improvements
to correctly adapt it to Linux's APIs.

> APPROACH:
> Actually the code of frambuffer driver consists of usual kernel framebuff=
er
> code and properitiary graphics lib code.
> The properitiary graphics lib code is using malloc,print and free from <
> stdlib.h> and that is why those symbols are coming undefined.

stdlib.h functionality is not per se available. You either need to
implement the missing parts, or rework the stuff to use the proper
kernel interfaces (which is what I recommend.)

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:           Ich hatte in letzter Zeit ein bi=C3=9Fchen viel Rea=
litycheck.
the second  :               Langsam m=C3=B6chte ich mal wieder weitertr=C3=
=A4umen k=C3=B6nnen.
                             -- Maximilian Wilhelm (18. Mai 2006, #lug-owl.=
de)

--S0QU+l03nqHlODqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHIF5bHb1edYOZ4bsRAmMJAJ0TA1rFEXF3BPOKvTYrvCx4gTgpJgCdFVe9
yYlkidzQ5IjAPkJ2KVXD4eM=
=1Sct
-----END PGP SIGNATURE-----

--S0QU+l03nqHlODqK--
