Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 22:23:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27248 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993904AbdGCUX3x70ET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 22:23:29 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C7BFE41F8E08;
        Mon,  3 Jul 2017 22:33:41 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 03 Jul 2017 22:33:41 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 03 Jul 2017 22:33:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 795E18184FC61;
        Mon,  3 Jul 2017 21:23:19 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 3 Jul
 2017 21:23:24 +0100
Date:   Mon, 3 Jul 2017 21:23:23 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] MIPS16e2: Report ASE presence in /proc/cpuinfo
Message-ID: <20170703202323.GM31455@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
 <alpine.DEB.2.00.1705230230220.2590@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6CiRFyVmOOJ3DkBX"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1705230230220.2590@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--6CiRFyVmOOJ3DkBX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 01:39:23PM +0100, Maciej W. Rozycki wrote:
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
>  Submitted third in the series so that the presence of "mips16e2" in=20
> /proc/cpuinfo not only indicates the hardware feature, but our correct=20
> unaligned emulation as well.

This should be mentioned in the commit description (not the 3rd in the
series bit, the "it indicates both the hw feature and unaligned
emulation" bit).

Otherwise
Reivewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
>  There's a `checkpatch.pl' error reported for the unusual formatting,=20
> however it is consistent with surrounding code and I do not think we=20
> want to make this statement an oddball.
>=20
>   Maciej
>=20
> linux-mips16e2-ase-report.diff
> Index: linux-sfr-test/arch/mips/kernel/proc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/kernel/proc.c	2017-05-22 22:42:16.00000=
0000 +0100
> +++ linux-sfr-test/arch/mips/kernel/proc.c	2017-05-22 22:56:31.000000000 =
+0100
> @@ -109,6 +109,7 @@ static int show_cpuinfo(struct seq_file=20
> =20
>  	seq_printf(m, "ASEs implemented\t:");
>  	if (cpu_has_mips16)	seq_printf(m, "%s", " mips16");
> +	if (cpu_has_mips16e2)	seq_printf(m, "%s", " mips16e2");
>  	if (cpu_has_mdmx)	seq_printf(m, "%s", " mdmx");
>  	if (cpu_has_mips3d)	seq_printf(m, "%s", " mips3d");
>  	if (cpu_has_smartmips)	seq_printf(m, "%s", " smartmips");

--6CiRFyVmOOJ3DkBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllap7oACgkQbAtpk944
dnqw7A//Xmhyj7h74zVGO6uSbXvaooiSdwTCXjeJzvnYlVw5bZ9NfFUqk4WEQKSn
RPm9HAwOF1slQjoZVj+yXeoB+QaEkn9nGH92Cx/AExyK/FlzTCOgNkHju/pEDrhm
OyB6ynP9bILjX88LQiSdP81cKnZq0GddQEosHt7g61pbb3ye0LbOmsFNiCgHC+1c
kQc8Alm0GzDjj21hjDPOwoVApOuktEYlYQusO9qRFbqgx835w14nFj9p8vj0rmgf
KVmU+hoVB17KGRwbqzML5CcgUbVFaIbkP7wqBT9vqyVtI3nOkPlos5Vy74nVcdly
+QfjREkuxC6vRdv1d1LUaf0DBKhltIO0u9FfWKo/B6+RPyPBLPi/b+X5MBbpYpjP
oeOqhX0qLNg3T5MzOqN8I3Z5Jms88RA5nvK/qjdKNXsFUQ7ZbwnMxzAHY9x/nAxL
13DdzlsMXG0UyPeTeESwRy7ZBpc9dpUR/ErfqDdd8rqtzF0ANzGE5TWLt6DTNpSK
9vARAr+E8dKBdgNkkyJ2d8gNfs4EvducAiU+Z/LfHLjl2cNNQoEy+M0ZC781VoUu
cuL0SzmOhVrb1eCKBQC6oMd8C9ofHSh+zlFd2LYEqxe3KcN77sMiyId/bbOHdsB1
f1inP8hhe8gUxLXDZvD0gQd/RporWe2KZ+J8z8RALFPBJOGQhiY=
=0zqD
-----END PGP SIGNATURE-----

--6CiRFyVmOOJ3DkBX--
