Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA99434 for <linux-archive@neteng.engr.sgi.com>; Sun, 23 Nov 1997 17:16:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA06151 for linux-list; Sun, 23 Nov 1997 17:15:33 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA06125 for <linux@engr.sgi.com>; Sun, 23 Nov 1997 17:15:19 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA24229
	for <linux@engr.sgi.com>; Sun, 23 Nov 1997 17:15:16 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ralf@pmport-26.uni-koblenz.de [141.26.249.26])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA25346
	for <linux@engr.sgi.com>; Mon, 24 Nov 1997 02:15:13 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id CAA10144;
	Mon, 24 Nov 1997 02:12:09 +0100
Message-ID: <19971124021209.16856@lappi.waldorf-gmbh.de>
Date: Mon, 24 Nov 1997 02:12:09 +0100
From: ralf@uni-koblenz.de
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Announce: New development tools uploaded
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi all,

I've uploaded new patches for the development tools to ftp.linux.sgi.com
and ftp.fnet.fr.

  - binutils-2.8.1-1
    This is the first Linux/MIPS version of the tools based on binutils
    2.8.1.  The upgrade is mandatory if you want to be able to correctly
    build shared libraries.  The old binutils 2.7 based linker had the
    bug that it would link the entire static libc into a shared library
    image when the library was linked against libc (-lc) resulting in a
    unuseable, huge shared library image and a large number of warnings.
  - gcc-2.7.2-7.diff.gz
    This release fixes a minor bug in the specs file.  Older GCC versions
    were linking useless object files into all shared libraries resulting
    in slightly larger object files.

  Ralf

f55e50c1583a9551004fb28efbc71f82  binutils-2.8.1-1.diff.gz
e70231058065d5be40e668b5cb601bb6  gcc-2.7.2-7.diff.gz

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i
Charset: latin1

iQCVAwUBNHjUFUckbl6vezDBAQFDjAP7BqaR0RGPnh1AmRSA04/gX4utubgcZYP6
auyx1hoK3yCax72P64J7WD8z/41Nshyi5ehBu9yk4JUKwBaTTErF8NbcY+zTR5v0
lhb0o8DkUR0WA0NxD/YGVdHqBgz9eKJlDUSkTanBItitVBbbhaUGREjmJsFedt0K
0YtqmfD0WeY=
=gBCX
-----END PGP SIGNATURE-----
