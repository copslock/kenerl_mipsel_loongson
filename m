Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA79055 for <linux-archive@neteng.engr.sgi.com>; Thu, 17 Jun 1999 14:12:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA57144
	for linux-list;
	Thu, 17 Jun 1999 14:11:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA02278
	for <linux@engr.sgi.com>;
	Thu, 17 Jun 1999 14:11:35 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01708
	for <linux@engr.sgi.com>; Thu, 17 Jun 1999 14:11:33 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (arkanoid.uni-koblenz.de [141.26.64.74])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA25515
	for <linux@engr.sgi.com>; Thu, 17 Jun 1999 23:11:31 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA01683;
	Thu, 17 Jun 1999 23:11:24 +0200
Date: Thu, 17 Jun 1999 23:11:24 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, linux-announce@sws1.ctd.ornl.gov
Subject: New patches for Linux/MIPS native and crosscompilers
Message-ID: <19990617231124.A1634@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi,

I've uploaded new patches to build native and cross binutils and compilers
for mips-linux and mipsel-linux targets for Linux/MIPS on ftp.linux.sgi.com
into

  /pub/linux/src/binutils/binutils-2.8.1-2.diff.gz
  /pub/linux/src/egcs/egcs-1.0.3a-1.diff.gz

Please report problems with these patches to ralf@uni-koblenz.de.

The MD5 checksums are:

f24f176e3c1bd49fef746e42d5d8a7b9  binutils/binutils-2.8.1-2.diff.gz
5162b9b35ff0c6d4886e00d992170929  egcs/egcs-1.0.3a-1.diff.gz

  Ralf

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i
Charset: latin1

iQCVAwUBN2lkTUckbl6vezDBAQHVPwP/Wf9B+YXHMw+rxeuUefqsOS6LKFhasE5G
PFU8cF9aca4zzyhL514Qi7pFUqhHOEtwKYSy2gOf0gGoD/V9YJAL0jLhZhVCJtzu
yIB2/36UwoB2xcuh4+mIb3NBSN7vtvWd1TvjFCnuw5l1SYxOdYZyXQUsTo20zSnE
1bQOSbRbIvA=
=Mj48
-----END PGP SIGNATURE-----
