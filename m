Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA20207; Wed, 30 Apr 1997 02:34:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA17777 for linux-list; Wed, 30 Apr 1997 02:33:32 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA17772 for <linux@engr.sgi.com>; Wed, 30 Apr 1997 02:33:29 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id CAA12454
	for <linux@engr.sgi.com>; Wed, 30 Apr 1997 02:29:45 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id LAA24193 for <linux@engr.sgi.com>; Wed, 30 Apr 1997 11:25:19 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199704300925.LAA24193@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id LAA03623; Wed, 30 Apr 1997 11:25:16 +0200
Subject: Linux 2.1.36
To: linux@cthulhu.engr.sgi.com
Date: Wed, 30 Apr 1997 11:25:15 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi all,

I've uploaded Linux/MIPS 2.1.36 to ftp.fnet.fr and kernel.panic.julia.de.
The file will appear at FNet later today when one of the admins has
moved it online.

The number of changes compared to my last real release 2.1.14 is too
large to be enumerated and people still having patches against this
release will probably have their fun with them ...

This release integrates all of Linus' kernel patches and most of the
MIPS specific patches I still had on hold.

Because I don't have a Indy for testing this release is completly
untested on SGI machines.

  Ralf

93141ebd8f8188b1e1ed1e02cd68948a  linux-2.1.36.tar.gz

-----BEGIN PGP SIGNATURE-----
Version: 2.6.2

iQCVAgUBM2cP90ckbl6vezDBAQEvzgQAio00le2/AamTFr3jQHl0NaLgKYy9seq6
tELgbMz4/xPE5KVFOOmeOs+lZGp5JXfOv9exXWr4PEcu0ZJkd/3uxdBdFR1QUba6
+lKiExtyUZtOw+WvTBIlgm2cGXGqMSHrEjSaTlkqzPtzveiYxGV+yW7mO0qn4c2f
p8cgPKtzVEE=
=zEju
-----END PGP SIGNATURE-----
