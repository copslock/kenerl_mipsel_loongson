Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA01935; Mon, 2 Jun 1997 00:53:01 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA06412 for linux-list; Mon, 2 Jun 1997 00:52:48 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA06406 for <linux@engr.sgi.com>; Mon, 2 Jun 1997 00:52:44 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id AAA14321
	for <linux@engr.sgi.com>; Mon, 2 Jun 1997 00:52:28 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id JAA12680; Mon, 2 Jun 1997 09:47:55 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706020747.JAA12680@informatik.uni-koblenz.de>
Received: by zaphod (SMI-8.6/KO-2.0)
	id JAA08937; Mon, 2 Jun 1997 09:47:54 +0200
Subject: New GCC patches uploaded
Date: Mon, 2 Jun 1997 09:47:54 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Apparently-To: <linux@cthulhu.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi all,

I've uploaded a new GCC patch gcc-2.7.2-4.diff.gz to kernel.panic.julia.de
and ftp.fnet.fr.  The patches fixes bug that the big endian targets had
different predefined preprocessor symbols.  It also reduces the a little
bit excessive alignments that were used for trampolines.  There is no
real need to upgrade to this version if you're already running GCC 2.7.2-3
and can ignore some warnings.

  Ralf

77e6b058dae70d4d1cc6d970bbc30afa  gcc-2.7.2-4.gz

-----BEGIN PGP SIGNATURE-----
Version: 2.6.2

iQCVAgUBM5J6pkckbl6vezDBAQF2dgQAqT7Z+y/X5pDgLqy+AvkFXS4rsNwSoGFI
dvdN1SwZMJsNctH4FYZYY02OSwzlpmlvbKr6hbrFEKapL6NvaQfkxrONQAk+9or0
vegnDwvqmqHbd/mxiQbdpVpIc7FCdYfwihUWMtVjP2yQZ7woVYbdXd/g+c4L0uuW
9/Bbu/Jcwz8=
=3h+R
-----END PGP SIGNATURE-----
