Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2003 15:18:26 +0000 (GMT)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:19716 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225233AbTAPPS0>;
	Thu, 16 Jan 2003 15:18:26 +0000
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CD1AE25DF9; Thu, 16 Jan 2003 16:18:21 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id F3AFBB2AB; Thu, 16 Jan 2003 16:18:07 +0100 (CET)
Date: Thu, 16 Jan 2003 16:18:07 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Chetan B L <chetanb@ishoni.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Performance measuring in MIPS R3000
Message-ID: <20030116151807.GI5410@paradigm.rfc822.org>
References: <7CFD7CA8510CD6118F950002A519EA3003FB04E6@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Content-Disposition: inline
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3003FB04E6@leonoid.in.ishoni.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2003 at 12:01:52PM +0530, Chetan B L wrote:
> Hi,
>       I want to measure the time taken by any kernel function.=20
> Is  there anything like rdtsc indtruction in MIPS ?
> I saw timepeg patch for measuring the same for Pentium , is there anything
> similar to it for MIPS ?

Depending on the CPU - IIRC most R4k variants have something like this
and its sometimes used for generating Timer-Interrupts.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+Js0vUaz2rXW+gJcRAsH8AJ9Jw16U/vfPSHOA3yC+lYmk+pB2+gCgtKLo
UnktJyhOGikbHxW5VCDfpxU=
=iF5C
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
