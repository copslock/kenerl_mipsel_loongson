Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 00:08:12 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:45264
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225264AbUEaXII>; Tue, 1 Jun 2004 00:08:08 +0100
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 4E3772BC47; Tue,  1 Jun 2004 01:08:06 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18006-20; Tue, 1 Jun 2004 01:08:02 +0200 (CEST)
Received: from bogon.sigxcpu.org (200-203-027-014.paemt7003.dsl.brasiltelecom.net.br [200.203.27.14])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 060062BC46; Tue,  1 Jun 2004 01:08:01 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 5A369404E; Mon, 31 May 2004 20:05:24 -0300 (BRT)
Date: Mon, 31 May 2004 20:05:24 -0300
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Cc: debian-toolchain@lists.debian.org
Subject: TLS register
Message-ID: <20040531230524.GB2785@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org, debian-toolchain@lists.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at honk.physik.uni-konstanz.de
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
Now that gcc 3.4 has incompatible ABI changes (on o32 mostly affecting
mipsel) I've been discussing with Thiemo if I'd be the right point to
take this ABI change as a possibility to additionally reserve a TLS
register.=20
He suggested $24 (t8) another discussed possibility would be $27 (k1)
which is already abused by the PS/2 folks for ll/sc emulation.
Another possibility would be to reserve such a register only in the
n32/n64 ABIs and let o32 stay without __thread and TLS forever.
Any feedback welcome.
 -- Guido

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAu7o0n88szT8+ZCYRAvgSAJ42KtGG2qSVpv7fa+JRgHSkl+9f8wCfVyNa
FsR4j3cbTB8k4VXQ/W4gwdE=
=p2ry
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
