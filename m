Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA2947545 for <linux-archive@neteng.engr.sgi.com>; Sat, 4 Apr 1998 01:52:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id BAA7600861
	for linux-list;
	Sat, 4 Apr 1998 01:50:39 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA7698627
	for <linux@engr.sgi.com>;
	Sat, 4 Apr 1998 01:50:36 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id BAA14106
	for <linux@engr.sgi.com>; Sat, 4 Apr 1998 01:50:35 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-02.uni-koblenz.de [141.26.249.2])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id LAA25887
	for <linux@engr.sgi.com>; Sat, 4 Apr 1998 11:50:25 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id LAA01207;
	Sat, 4 Apr 1998 11:49:24 +0200
Message-ID: <19980404114921.56402@uni-koblenz.de>
Date: Sat, 4 Apr 1998 11:49:21 +0200
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Cc: gid@cobaltmicro.com
Subject: New GCC release
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

Hi all,

after Gideon tracked down the bug that was crashing everything linked
against libg++ and probably some things more, here yet another release
of GCC.  Thanks Gideon!

There is no need to upgrade crosscompiler installations as the bug does not
affect the kernel.  The patch gcc-2.7.2-8.diff.gz is the same as contained
in the srpm package.  Though obsoleted by this release I'm replacing
gcc-2.7.2-7.diff.gz; the file previously published under this name was
a different gcc patch.

You can find the srpm packages on ftp.linux.sgi.com in
/pub/redhat/redhat-5.0/SRPMS/; the binary packages are in
/pub/redhat/redhat-5.0/mips rsp. /pub/redhat/redhat-5.0/mipsel.

  Ralf

29cd4f3d539de880bff861b3167afa96  gcc-2.7.2-3.mips.rpm
51648edfe0e2ef0bbe91265bcd5639cc  gcc-2.7.2-3.mipsel.rpm
edafdc92e392bb781d9174fb796daf35  gcc-2.7.2-3.src.rpm
1376b1c47c04e7d3ac3c642731d82149  gcc-2.7.2-7.diff.gz
68dcaff6da906d6a17afdf4ab1acc6ec  gcc-2.7.2-7.diff.gz.asc
fa672f5ef5ade6b2b1cca09f56d9112b  gcc-2.7.2-8.diff.gz
7167b2718cda5e5ce10839a6c22e801b  gcc-2.7.2-8.diff.gz.asc
6d173f4c9c8d7206acf1f941b3ce2aaf  gcc-c++-2.7.2-3.mips.rpm
4fdc76e56a1e5d9ca4c1d99ab5cca7d5  gcc-c++-2.7.2-3.mipsel.rpm
a7472ff686dbb3a723a412e61ec519c5  gcc-objc-2.7.2-3.mips.rpm
a07614ea41bebe66282d3967865f12ef  gcc-objc-2.7.2-3.mipsel.rpm

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3i
Charset: latin1

iQCVAwUBNSYCBUckbl6vezDBAQH3bwP+NuCI3wEIh+vVD7yD8iF0a3WTmf3ibqJ0
W8q4UOYCRWS6njJqFMSOODliapkSF/Cch4vRwzCtSzdleuIfbUmA5faIL34xuSvA
zS+WsPNyNuz37LF6JPGI1q3NmK1FScbU0SdFPC4ieZkaIyq0JMItXBTIFPkrgxGf
6gf4yQqSBNs=
=GEtc
-----END PGP SIGNATURE-----
