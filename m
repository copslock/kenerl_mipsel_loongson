Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 03:53:42 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:60168 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1123907AbSI0Bxl>;
	Fri, 27 Sep 2002 03:53:41 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E9D01843; Fri, 27 Sep 2002 03:53:34 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 82BCE3717F; Fri, 27 Sep 2002 03:52:54 +0200 (CEST)
Date: Fri, 27 Sep 2002 03:52:54 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Mike Nugent <mips@illuminatus.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020927015254.GA23473@paradigm.rfc822.org>
References: <3D92B80A.3080802@linuxcare.com> <20020926171033.GA13337@paradigm.rfc822.org> <1033086212.13264.26.camel@templar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1033086212.13264.26.camel@templar>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 05:23:32PM -0700, Mike Nugent wrote:
>=20
> I'd be interested in working on this, but I'm not 100% sure that I know
> enough about my indigo2 yet.  I'll start by seeing what I can do with
> arcboot.
>=20

Grab SILO or PALO - Both have enough ISO9660 support to load a file
from an ISO image - Then look at the existing ARCBOOT code and make some
kind of minimalistic "filesystem detection" of the devices media.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9k7n2Uaz2rXW+gJcRAqcmAKCkWmEp+AuAwWec0Gb1AcU0NeUAVgCgl61P
7shVPlTSOnR9d/wK0EW/vRE=
=Nw5y
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
