Received:  by oss.sgi.com id <S42217AbQIVN0X>;
	Fri, 22 Sep 2000 06:26:23 -0700
Received: from [131.188.77.254] ([131.188.77.254]:20484 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S42204AbQIVN0Q>;
	Fri, 22 Sep 2000 06:26:16 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869536AbQIVN0E>;
        Fri, 22 Sep 2000 15:26:04 +0200
Date:   Fri, 22 Sep 2000 15:26:04 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-origin@oss.sgi.com
Subject: libc upgrade
Message-ID: <20000922152604.A2627@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I've uploaded the hopefully last glibc 2.0.6 release to oss.sgi.com.  The
rpm package filenames are:

  glibc-2.0.6-6lm.src.rpm,
  glibc-2.0.6-6lm.mips.rpm,
  glibc-devel-2.0.6-6lm.mips.rpm,
  glibc-profile-2.0.6-6lm.mips.rpm,
  glibc-debug-2.0.6-6lm.mips.rpm

This release fix a number of bug that have been hanging in the dynamic
linker basically forever and is urgently recommended to install.

Once more rpm in it's stupidity being a static linked program breaks.  I
therefore also provide new rpm binaries:

  rpm-3.0-6.0lm.mips.rpm
  rpm-devel-3.0-6.0lm.mips.rpm

No new source package for rpm since this is just a recompile of the
package.  Not that also other software which has been statically linked
against libdl needs to be rebuilt against this library release.

IMPORTANT: you must install these new rpm binaries before you upgrade
glibc!

  Ralf
