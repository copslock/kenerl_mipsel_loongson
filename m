Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 18:01:16 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:49936 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1122961AbSI0QBP>;
	Fri, 27 Sep 2002 18:01:15 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 10F22805; Fri, 27 Sep 2002 18:01:08 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3A4593717F; Fri, 27 Sep 2002 18:00:00 +0200 (CEST)
Date: Fri, 27 Sep 2002 18:00:00 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Alex deVries <adevries@linuxcare.com>
Cc: linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020927160000.GB622@paradigm.rfc822.org>
References: <3D92B80A.3080802@linuxcare.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <3D92B80A.3080802@linuxcare.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 03:32:26AM -0400, Alex deVries wrote:
> I'm curious about the possibility of making a Linux installer for the=20
> Indy that boots from CD; is there any description of the format of=20
> bootable IRIX CDs out there?  What does the firmware expect?
>=20
> I know that sash is involved somehow...

Ok - i reworked the procedure a bit whil beeing in Oldenburg.

flo@split:~/projects/boot$ mkisofs -J -R -V testboot -o iso
tftpboot-r4k-ip22.img
Total translation table size: 0
Total rockridge attributes bytes: 262
Total directory bytes: 0
Path table size(bytes): 10
Max brk space used 6644
2208 extents written (4 Mb)
flo@split:~/projects/boot$ isoinfo -l -R -i iso

Directory listing of /
dr-xr-xr-x   2 1750 1750             2048 Sep 27 2002 [    28]  .
?---------   0 1750 1750             2048 Sep 27 2002 [    28]  ..
-rwxr-xr-x   1 1750 1750          4414116 Sep 12 2002 [    31] tftpboot-r4k=
-ip22.img
flo@split:~/projects/boot$ echo $[ 31 * 4 ]
124
flo@split:~/projects/boot$ genisovh-0.1/genisovh iso sashARCS:124,4414116 i=
p22:124,4414116

The last command adds a "volume header" in the first 512 byte into the
iso file. This volume header spans the whole iso filesystem and lists 2
files at identical positions which is the ECOFF tftpboot-r4k-ip22.img.
The name sashARCS is coded in the Indys prom for the installer when
using your mouse and "Install System Software" and "Local cdrom".

Now one needs to write a wrapper for the Indy bootfloppys aka debian-cd
to produce bootable cds.

I put up the stuff:

http://www.silicon-verl.de/home/flo/software/ip22test.iso
http://www.silicon-verl.de/home/flo/software/genisovh-0.1.tgz

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9lIB/Uaz2rXW+gJcRAnNkAJ4zOvuP8eE2GGRCmGpzvbAtjxj54wCbBY+8
se/imWqY7jgWl+vCfI8OXkc=
=K1vg
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
