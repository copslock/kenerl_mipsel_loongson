Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 23:18:46 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:18707 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1122961AbSI0VSq>;
	Fri, 27 Sep 2002 23:18:46 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 53130873; Fri, 27 Sep 2002 23:18:40 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EE51E3717F; Fri, 27 Sep 2002 23:17:59 +0200 (CEST)
Date: Fri, 27 Sep 2002 23:17:59 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Alex deVries <adevries@linuxcare.com>
Cc: linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020927211759.GC7706@paradigm.rfc822.org>
References: <3D92B80A.3080802@linuxcare.com> <20020927160000.GB622@paradigm.rfc822.org> <20020927160643.GA6960@paradigm.rfc822.org> <3D94C8BF.5090902@linuxcare.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <3D94C8BF.5090902@linuxcare.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2002 at 05:08:15PM -0400, Alex deVries wrote:
> I have a cdrom connected to my Indy which has been configured to 512.  I=
=20
> think this hw is good, but will double check when I find an IRIX CD.=20
> When I boot, it complains "invalid partition".
>=20
> I wrote the ISO you posted on an i386 box with cdrecord.  I suspect my=20
> problem I didn't use set the blocksize to 512; exactly how did you burn=
=20
> this CD?

cdrecord with xcdroast - But burning does not care about block sizes it
seems.

Can you try to dump the volume header with "decodevh" from

http://amaya.mediaways.net/homes/flo/software/decodevh.tgz

Compile and decode with

devodevh /dev/scd0

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9lMsHUaz2rXW+gJcRAk7ZAJ4mTb0zMVs0ldgzjsS9bFywjoIW2gCfa2eq
t3xg/bM7d5PBJRAqq6m9yVc=
=iuu9
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
