Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2003 11:22:07 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:5030
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225418AbTLJLWG>; Wed, 10 Dec 2003 11:22:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 4C30B2BC3C
	for <linux-mips@linux-mips.org>; Wed, 10 Dec 2003 12:21:57 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 29564-06
 for <linux-mips@linux-mips.org>; Wed, 10 Dec 2003 12:21:35 +0100 (CET)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id A50ED2BC39
	for <linux-mips@linux-mips.org>; Wed, 10 Dec 2003 12:21:35 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 9F22345EB; Wed, 10 Dec 2003 12:21:34 +0100 (CET)
Date: Wed, 10 Dec 2003 12:21:34 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
Message-ID: <20031210112134.GB2190@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <3FD5FE41.8040909@bitbox.co.uk> <ML-3.4.1071007431.886.canavan@morannon.nonet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <ML-3.4.1071007431.886.canavan@morannon.nonet>
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2003 at 11:03:51PM +0100, Rainer Canavan wrote:
> > The kernel boots okay from the HD, but I get strange segmentation fault=
s=20
> > and other errors whilst running Debian's "dpkg" to install packages. If=
=20
> > I repeat the installation from scratch I get exactly the same errors in=
=20
> > exactly the same places :-(
>=20
> I just tried updating, removing and installing a package without=20
> any problems.
Are there any differences in the CPUs of your nasraq and Peter's Qube2?
Cheers,
 -- Guido

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1wG+n88szT8+ZCYRAjcyAJ9MTig2hOYBEoTbd03YJxAL/7brVgCfcsGO
RJ/pLIjjkk9OqgaS07fOtVc=
=Zl+G
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
