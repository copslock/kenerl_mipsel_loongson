Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Apr 2004 16:54:14 +0100 (BST)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:25618 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8226077AbUDLPyM>;
	Mon, 12 Apr 2004 16:54:12 +0100
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3745F25E8C; Mon, 12 Apr 2004 17:54:11 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 672AA24417F; Mon, 12 Apr 2004 17:54:06 +0200 (CEST)
Date: Mon, 12 Apr 2004 17:54:06 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Massimo Cetra <mcetra@navynet.it>
Cc: linux-mips@linux-mips.org
Subject: Re: Raq2 & 2.6.4 : Strange output fro msomewhere
Message-ID: <20040412155406.GC2482@paradigm.rfc822.org>
References: <000301c42053$2ae67fe0$e60a0a0a@guendalin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0FWGRsEUTYx4i2U9"
Content-Disposition: inline
In-Reply-To: <000301c42053$2ae67fe0$e60a0a0a@guendalin>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--0FWGRsEUTYx4i2U9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2004 at 06:58:20AM +0100, Massimo Cetra wrote:
> -cobalt:/proc# uptime
> Unknown HZ value! (79) Assume 100.
>  06:54:27 up 14 min,  2 users,  load average: 1.77, 1.37, 0.69

IIRC this is a hint to upgrade your procps :)

2.6 from the Documentation/Changes requires at least 3.2.0

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--0FWGRsEUTYx4i2U9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAerueUaz2rXW+gJcRAoccAKCjuSejxKuWA64u9HyaetprYKHeGACgluTj
Vk+R8evUhTfdPBXFH6z9NIo=
=jY7r
-----END PGP SIGNATURE-----

--0FWGRsEUTYx4i2U9--
