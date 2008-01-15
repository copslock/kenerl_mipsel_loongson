Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 11:28:41 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:16607 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20036571AbYAOL2d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 11:28:33 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 634E732DF5; Tue, 15 Jan 2008 12:27:19 +0100 (CET)
Date:	Tue, 15 Jan 2008 12:27:19 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080115112719.GB7920@paradigm.rfc822.org>
References: <20080115112420.GA7347@alpha.franken.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20080115112420.GA7347@alpha.franken.de>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200801150849@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2008 at 12:24:20PM +0100, Thomas Bogendoerfer wrote:
> Hi,
>=20
> we are facing a strange problem with lenny/sid chroots on IP28. The
> machine locks up after issuing a few ls/ps commands in a chroot
> bash. This only happens with a lenny/sid chroot, but not with etch.
> The major difference is probably the updare to glibc2.7. Since
> IP28 isn't really a nice R10k machine, it would be good, if someone
> with a working IP27/IP30 could try a lenny/sid chroot and tell us,
> if it's working/not working.

Simple testcase for me is:

/chroots/chroot-sid/lib/ld.so.1 --library-path /chroots/chroot-sid/lib /bin=
/bash

than the machine locks up hard ... This is with

Linux ip28 2.6.24-rc7-g0f154c48-dirty #38 Fri Jan 11 17:03:25 CET 2008 mips=
64 GNU/Linux

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjJiXUaz2rXW+gJcRAswRAKC5mF4/WLaAk+MUTgbKv5ebsvqEGwCfURJU
dAR11g9zDe92vV2HEUXDyOE=
=MtU5
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
