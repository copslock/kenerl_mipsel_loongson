Received:  by oss.sgi.com id <S553850AbRA2Pfa>;
	Mon, 29 Jan 2001 07:35:30 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:25237 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553834AbRA2PfD>;
	Mon, 29 Jan 2001 07:35:03 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA24005;
	Mon, 29 Jan 2001 16:23:37 +0100 (MET)
Date:   Mon, 29 Jan 2001 16:23:36 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Mike McDonald <mikemac@mikemac.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs 
In-Reply-To: <200101281745.JAA25600@saturn.mikemac.com>
Message-ID: <Pine.GSO.3.96.1010129160803.20889B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 28 Jan 2001, Mike McDonald wrote:

>   I want to do just the opposite. I want to start with the minimum set
> of installed binaries and build a complete binary distribution from
> its sources. (That means finding the root of the dependency graph and
> starting there, assuming there actually is one. It isn't necessarily a
> single rpm. People like to make circular dependancies!)

 If you have another working Linux system, you may see what I have at
ftp://ftp.ds2.pg.gda.pl/pub/macro/.  I built my mipsel-linux (not complete
yet, e.g. no perl nor X11) system from scratch, i.e. having no MIPS
binaries at all using my i386-linux build system.  All RPM packages have
spec files with explicit "BuildRequires"  dependencies -- you may find
from these what else is needed to build a particular package.

 Only for binutils, gcc and glibc you would need: autoconf, automake,
bash, binutils, bzip2, diffutils, fileutils, findutils, flex, gawk, gcc,
gettext, glibc, grep, gzip, m4, make, patch, perl, rpm, sed, sh-utils,
texinfo, textutils.  You may need additional software to compile some of
these. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
