Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2002 19:11:18 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:1298 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1123905AbSIZRLR>;
	Thu, 26 Sep 2002 19:11:17 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 572C5843; Thu, 26 Sep 2002 19:11:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 23A9D3717F; Thu, 26 Sep 2002 19:10:33 +0200 (CEST)
Date: Thu, 26 Sep 2002 19:10:33 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Alex deVries <adevries@linuxcare.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020926171033.GA13337@paradigm.rfc822.org>
References: <3D92B80A.3080802@linuxcare.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <3D92B80A.3080802@linuxcare.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 03:32:26AM -0400, Alex deVries wrote:
> I'm curious about the possibility of making a Linux installer for the=20
> Indy that boots from CD; is there any description of the format of=20
> bootable IRIX CDs out there?  What does the firmware expect?

The firmware loads an ecoff file from a volume header - The volume
header is a special partition with a "minimalistic" filesystem
in it - This can be modified by "dvhtool".=20

I succeeded in booting an indy by creating a fake "volume header"
on the ISO filesystem CD. (ISO Specifies the first 8k of an image
to be for the bootloader and partitioning etc). Then i created
directory entrys for the kernels on the iso in the pseudo
volume header. As the ISO filesystems needs all files to be
contigues (same for the volume header) the machine was able
to boot from the cd although booting the ecoff kernel image
including the ramdisk directly. Having a bootloader would
be much nicer.

> I know that sash is involved somehow...

"sash" is proprietary IRIX. The IRIX CDs are EFS BTW.

If you plan to work on this - Feel free to come around in
Oldenburg this weekend - We will have a Kernel Hacker meeting
in the University Oldenburg. I'll bring a Burner and CD-RW's=20
with me to test this.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9kz+JUaz2rXW+gJcRAkXxAJ4vsPIdarEZp/TI7piUGcPdxZy5TQCcC/yf
P7lJoos9PlbsMwMxFrzNpIQ=
=PE4N
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
