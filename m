Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB2tj829394
	for linux-mips-outgoing; Mon, 10 Dec 2001 18:55:45 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB2tZo29381
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 18:55:35 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A4EF27DD; Tue, 11 Dec 2001 02:55:24 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DB46048FF; Tue, 11 Dec 2001 02:53:41 +0100 (CET)
Date: Tue, 11 Dec 2001 02:53:41 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Cc: klaus@mgnet.de, agx@sigxcpu.org
Subject: Re: [PATCH] sgiwd93.c fix for multiple disks
Message-ID: <20011211015341.GA27203@paradigm.rfc822.org>
References: <20011210200757.GA25722@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20011210200757.GA25722@paradigm.rfc822.org>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2001 at 09:07:57PM +0100, Florian Lohoff wrote:
> Hi,
> the attached patch fixes part of the DMA problems we see with multiple
> disks and the sgiwd93.c with DISCONNECTs. Klaus patch formerly just
> disabled all DMA replacing it with PIO which is a major performance hit.
>=20
> This patch simply deletes all the HPC Scatter/Gather stuff thus we will
> see a couple more interrupts due to all segments beeing transferred
> individually. The transfer itself still happens with the HPC DMA thus
> the performance impact will not be that large. I am running a test right
> now but it seems the error is gone.

Ok - I am running the attached script right now which copies a kernel
source tree from one disk to another disk in a loop. I ran this on the a
133Mhz R4600 Indy with 2 SCSI Disks on the same SCSI bus.  Without the
patch not a single cycle in this script made it through as on page in
the binarys would be corrupted. Also a whole bunch of files of the source
tree would be broken, mangled truncated - Whatever might happen. Nothing
of this now happened while running the test for the last 5 hours. The
machine is still up and running and kind of responsive.

I am unsure if we should put this into CVS as it brings us correctness
for the price of some performance penalty.


#!/bin/sh

TMP=3D`tempfile`
MD5OUT=3D`tempfile`
LOG=3D/home/flo/break/log

SRC=3D/home/flo/break/
DST=3D/mnt/break/

[ ! -d $DST ] && mkdir $DST
[ ! -d $DST ] && exit 1

while [ 1 ]; do
=09
	[ -d $DST/linux.bak ] && rm -rf $DST/linux.bak
	[ -d $DST/linux ] && mv $DST/linux $DST/linux.bak

	[ -d $DST/linux.bak.md5sum ] && rm -f $DST/linux.bak.md5sum
	[ -f $DST/linux.md5sum ] && mv $DST/linux.md5sum $DST/linux.bak.md5sum
=09
	rm -f $TMP $MD5OUT

	printf "Starting copy %s - " "`date +\"%y-%m-%d %H:%M:%S\"`" >$TMP
	(cd $SRC ; tar -cf - linux* ) | ( cd /$DST ; tar -xf - ; sync )
	printf "Finished %s\n" "`date +\"%y-%m-%d %H:%M:%S\"`" >>$TMP


	printf "Checking md5sum %s - " "`date +\"%y-%m-%d %H:%M:%S\"`" >>$TMP

	md5sum -cv $DST/linux.md5sum >$MD5OUT 2>&1=20

	totlines=3D`wc -l $MD5OUT | awk '{ print $1 }'`
	failedlines=3D`grep -v OK $MD5OUT | wc -l | awk '{ print $1 }'`

	printf "Finished %s\n" "`date +\"%y-%m-%d %H:%M:%S\"`" >>$TMP
	printf "%d files failed out of %d\n" $failedlines $totlines >>$TMP
	grep -v OK $MD5OUT >>$TMP

	cat $TMP >>$LOG
done



Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FWclUaz2rXW+gJcRAkszAKCBKwTrO1JI3oYc8l3GAxDiGSc2NwCggsiY
xHc2QLalsPRUkfbZbsMfPAs=
=EYfW
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
