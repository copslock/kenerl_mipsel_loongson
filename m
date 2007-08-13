Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 22:23:39 +0100 (BST)
Received: from hydra.gt.owl.de ([195.71.99.218]:46550 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20023010AbXHMVXb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2007 22:23:31 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 4E3DA93707; Mon, 13 Aug 2007 23:23:31 +0200 (CEST)
Date:	Mon, 13 Aug 2007 23:23:31 +0200
From:	Florian Lohoff <flo@rfc822.org>
To:	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Cc:	tsbogend@alpha.franken.de
Subject: SNI RM - booting from disk
Message-ID: <20070813212331.GA2108@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
Organization: rfc822 - pure communication
X-SpiderMe: mh-200708132252@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@hydra.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
this is just a short announcement about a rough way to boot the SNI RM
series from disk. As Thomas Bogendoerfer found out the SNI RM needs
an additional "Volume Trailer" to the SGI Volhdr to find its partitions.

Last weekend we wrote a little program to generate a minimal Volume
Trailer and thus allow the Prom to find the partitions and volume
header.

Also we modified arcboot to be able to boot on the SNI machines. This
contains a very crude hack to find the prom_seek entry point which is
not officially exported by the SNI Prom.=20

We successfully bootet an RM200-225, RM200-C40 and an RM400-220.



Here is the tool to write the SNI Volume Trailer. Beware - this writes
to your disk and probably even within your last partition. The Volume
Trailer is on the last cylinder the last 2 tracks so you better shrink
your last partition by one cylinder. To successfully boot/write a
Volume Trailer all partitions need to start on a cylinder boundary.

Currently it is hardcoded to /dev/sda. It trys to find the Disk Geometry
with SCSI Mode Page and READ_CAPACITY calls and parses the SGI Volhdr
into the Volume Trailer.

This should be integrated into fdisk and/or parted which both have
bugs in creating cylinder boundary partitions.

http://silicon-verl.de/home/flo/projects/snirm/software/snitrail.20070813.t=
gz



Here is the modified arcboot. Its not well integrated yet and just a
hack get it to work. Build the arcboot code with SUBARCH=3DSNIRM
and store the resulting ext2load with dvhtool into your volume header.
You should strip the filename as the prom fails to get more than 20
chars in the bootfile variable (remember the dkncr(0,0,X)).

Currently the OSPartition is hardcoded to "dkncr(0,0,1)" as the SNI Prom
lacks the option. Also the OSOption is missing thus the arcboot.conf
label is hardcoded to "linux".

http://silicon-verl.de/home/flo/projects/snirm/software/arcboot-0.3.8.8.sni=
rm.20070813.tgz

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGwMvTUaz2rXW+gJcRArP6AJ9LlXFp5Jq1TiCOenDsYiUReH5DxgCfZDtw
iPkLHK6LMTLOmMf5nEXH7uk=
=wZon
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
