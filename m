Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 06:17:56 +0100 (BST)
Received: from cantor.suse.de ([IPv6:::ffff:195.135.220.2]:10944 "EHLO
	Cantor.suse.de") by linux-mips.org with ESMTP id <S8224858AbUJRFRq>;
	Mon, 18 Oct 2004 06:17:46 +0100
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id B0A66DB6A0B;
	Mon, 18 Oct 2004 07:17:28 +0200 (CEST)
Received: from aj by arthur.inka.de with local (Exim 4.42)
	id 1CJPte-0001GW-Ds; Mon, 18 Oct 2004 07:17:26 +0200
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: linux-mips@linux-mips.org, libc-alpha@sources.redhat.com,
	Dominic Sweetman <dom@mips.com>,
	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [patch] glibc 2.3: Memory clobber missing from syscalls
References: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com>
From: Andreas Jaeger <aj@suse.de>
Date: Mon, 18 Oct 2004 07:17:24 +0200
In-Reply-To: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com> (Maciej
	W. Rozycki's message of "Fri, 15 Oct 2004 13:47:59 +0100 (BST)")
Message-ID: <m31xfwmwpn.fsf@gromit.moeb>
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
	Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-Path: <aj@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aj@suse.de
Precedence: bulk
X-list: linux-mips

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Maciej W. Rozycki" <macro@mips.com> writes:

> Hi,
>
>  It seems nobody at the libc-alpha list is intersted in this fix, so I'm=
=20
> sending it here, so that people do not struggle against weird failures,=20
> while a fix is already done.  The fix is needed for the current version o=
f=20
> glibc.

Sorry, it took me longer to react than normal - but there is interest,
just not always time to do anything properly.

I've committed your patch after adjusting the copyright years also.

Thanks,
Andreas
=2D-=20
 Andreas Jaeger, aj@suse.de, http://www.suse.de/~aj
  SUSE Linux AG, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
   GPG fingerprint =3D 93A3 365E CE47 B889 DF7F  FED1 389A 563C C272 A126

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBc1HmOJpWPMJyoSYRAn9YAKCPU2YU9N0QTse2H+gTF5NaDhlUDACffLTR
jE2lQf8VDj6XBDiBeyUhMmo=
=re3E
-----END PGP SIGNATURE-----
--=-=-=--
