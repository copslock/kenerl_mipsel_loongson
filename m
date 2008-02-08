Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 17:27:15 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:17639 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S28576208AbYBHR1I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Feb 2008 17:27:08 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 7061632CF4; Fri,  8 Feb 2008 18:23:16 +0100 (CET)
Date:	Fri, 8 Feb 2008 18:23:16 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kumba <kumba@gentoo.org>, Thiemo Seufer <ths@networkno.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080208172316.GD25893@paradigm.rfc822.org>
References: <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org> <20080205122211.GA24136@networkno.de> <47A928BF.5000302@gentoo.org> <20080206085610.GA20751@paradigm.rfc822.org> <20080206142217.GA7633@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20080206142217.GA7633@linux-mips.org>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200802081730@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2008 at 02:22:17PM +0000, Ralf Baechle wrote:
> On Wed, Feb 06, 2008 at 09:56:10AM +0100, Florian Lohoff wrote:
>=20
> > No - the very same GLIBC does not work on mips1 machines and vice versa.
> > Might by okay for gentoo but debian needs a run everywhere glibc which
> > means some ld.so tricks like with the libc6-i686 to load a different
> > glibc from my understanding.
>=20
> There is the long standing plan to generate a shared library on on the
> fly during kernel initialization and move atomic operations and performan=
ce
> relevant functions like memcpy to it.  Thiemo's latest work on tlbex.c
> got us a tiny step closer to that.

You mean a single page in every processes address space or some
/proc/sys/kernel/libatomic.so which would be a really cool hack?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHrJAEUaz2rXW+gJcRAoTHAJ9kQ5dpzZpez3JuJzpKSAsIMAkxzgCgjkIT
OQjiDPZ3TdHMkPWeEcLs4ns=
=LNNM
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
