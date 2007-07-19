Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 16:29:13 +0100 (BST)
Received: from lug-owl.de ([195.71.106.12]:24278 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S20022528AbXGSP3L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2007 16:29:11 +0100
Received: by lug-owl.de (Postfix, from userid 1001)
	id B6D22F006D; Thu, 19 Jul 2007 17:28:40 +0200 (CEST)
Date:	Thu, 19 Jul 2007 17:28:40 +0200
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix known HW bug with MIPS core on NXP/Philips PNX8550
Message-ID: <20070719152840.GH22998@lug-owl.de>
Mail-Followup-To: Daniel Laird <daniel.j.laird@nxp.com>,
	linux-mips@linux-mips.org
References: <469F822D.9040209@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline
In-Reply-To: <469F822D.9040209@nxp.com>
X-Operating-System: Linux mail 2.6.18-4-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-19 16:24:29 +0100, Daniel Laird <daniel.j.laird@nxp.com> wr=
ote:
> Update Patch
>=20
> Fix known bug with MIPS core when using TLB on NXP/Philips PNX8550

Both versions are whitespace damaged...

> Index: linux-2.6.22.1/arch/mips/mm/tlb-r4k.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22.1/arch/mips/mm/tlb-r4k.c    (revision 8)
> +++ linux-2.6.22.1/arch/mips/mm/tlb-r4k.c    (working copy)
> @@ -456,7 +456,11 @@
>      */
>     probe_tlb(config);
>     write_c0_pagemask(PM_DEFAULT_MASK);
> +#ifdef CONFIG_SOC_PNX8550
> +    write_c0_wired(11);
> +#else
>     write_c0_wired(0);
> +#endif
>     write_c0_framemask(0);
>     temp_tlb_entry =3D current_cpu_data.tlbsize - 1;

Magic constants?

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                           Wenn ich wach bin, tr=C3=A4ume ic=
h.
  the second  :

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGn4MoHb1edYOZ4bsRAjSrAJ901RE+JhaWAz4f7ZOKFexlmjA+kwCfXkC2
Fw9Bitj2ASeW8EEwP3GDgxI=
=26If
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--
