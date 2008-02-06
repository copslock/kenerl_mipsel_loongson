Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2008 08:59:53 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:47756 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20025449AbYBFI7o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Feb 2008 08:59:44 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 5B49732CE4; Wed,  6 Feb 2008 09:56:10 +0100 (CET)
Date:	Wed, 6 Feb 2008 09:56:10 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080206085610.GA20751@paradigm.rfc822.org>
References: <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org> <20080205122211.GA24136@networkno.de> <47A928BF.5000302@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <47A928BF.5000302@gentoo.org>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200802060854@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2008 at 10:25:51PM -0500, Kumba wrote:
> >Kumba wrote:
> >
> >glibc for mips has currently no such mechanism. Note that this change
> >breaks MIPS I CPUs, so it is not generally applicable.
>=20
> I'll have to ask one of our devs who knows autoconf really well.  I figur=
e=20
> that's probably a good place to catch something like this.  Have configur=
e=20
> check /proc/cpuinfo and look for "R10000", and if it finds it, mod CFLAGS=
=20
> to pass -DR10k_LLSC_WAR, and #ifdef on that in atomic.h.
>=20
> Sound plausible?

No - the very same GLIBC does not work on mips1 machines and vice versa.
Might by okay for gentoo but debian needs a run everywhere glibc which
means some ld.so tricks like with the libc6-i686 to load a different
glibc from my understanding.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHqXYqUaz2rXW+gJcRAu/rAKCzxlBQ4JiAzXd6DnSTB0sZ7VyGrgCg50Qj
zV6jpJliUjUF02HrPVQzjRY=
=r7c6
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
