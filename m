Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 10:48:15 +0100 (BST)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:46721 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8225268AbVGVJr7>;
	Fri, 22 Jul 2005 10:47:59 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id CDEBB198DAB; Fri, 22 Jul 2005 11:50:00 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2F62D138014; Fri, 22 Jul 2005 11:49:52 +0200 (CEST)
Date:	Fri, 22 Jul 2005 11:49:52 +0200
From:	Florian Lohoff <flo@rfc822.org>
To:	Dirk Vornheder <dirk.vornheder@piper-home.de>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: need help to install linux on RM200
Message-ID: <20050722094952.GA8660@paradigm.rfc822.org>
References: <200507212202.57569.dirk.vornheder@piper-home.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <200507212202.57569.dirk.vornheder@piper-home.de>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200507221129@listme.rfc822.org
User-Agent: Mutt/1.5.9i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2005 at 10:02:57PM +0200, Dirk Vornheder wrote:
> Hi !
>=20
> How can i install linux on a RM200 ?

Short: No

Long: What kind of RM200 do you have and what kind of Firmware (Sinix or
WindowsNT) ?

There is support for the RM200C/D which are PCI variants in the tree.
Support is for the little endian WindowsNT firmware. I am currently
beating my RM200-225 (EISA) a little and it boots until trying to mount
the filesystem already (Thus it does not succeed due to missing drivers).=
=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC4MFAUaz2rXW+gJcRAmPqAJ9kru6w1R1cH47Os7qEB1Eo47BN1ACfZH0R
JXo+IiLX5BFb6z9L1MfmWKA=
=H1Yk
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
