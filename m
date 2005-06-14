Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2005 19:26:14 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:33289 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225617AbVFNSZ5>; Tue, 14 Jun 2005 19:25:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CF991F59DA
	for <linux-mips@linux-mips.org>; Tue, 14 Jun 2005 20:25:50 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22814-08 for <linux-mips@linux-mips.org>;
 Tue, 14 Jun 2005 20:25:50 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9E77FF59D8
	for <linux-mips@linux-mips.org>; Tue, 14 Jun 2005 20:25:50 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5EIPtVc032249
	for <linux-mips@linux-mips.org>; Tue, 14 Jun 2005 20:25:55 +0200
Date:	Tue, 14 Jun 2005 19:26:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [announce] GCC 4.0.0 packages available
Message-ID: <Pine.LNX.4.61L.0506141922040.28607@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/939/Tue Jun 14 16:29:23 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 I have updated my RPM package archive to include sources and binaries of 
the 4.0.0 release of GCC.  The following compilers are available:

1. A mipsel-linux cross-compiler hosted on i386-linux.

2. A mips64el-linux cross-compiler hosted on i386-linux.

3. A native mipsel-linux compiler.

4. A native mips64el-linux compiler.

5. There may be others, but I will not tell you. ;-)

 All compilers include all frontends, that is for Ada, C, C++, Fortran, 
Java and Objective-C.  Note the mips64el-linux toolchains include local 
changes that make them produce (n)64 binaries by default and libraries are 
only (n)64.  The native mips64el-linux environment is still limited, but 
usable.

 As a part of the transition to newer GCC glibc has been also updated to a 
more recent version, which is now 2.3.5.  Unfortunately this version has 
binary incompatibilities with 2.2.x, which for mipsel-linux affects rpm, 
coreutils and tar, making their old binaries unusable.  Also all static 
libraries need to be rebuilt.

 Packages are available at the usual location, i.e.: 
"ftp://ftp3.ds.pg.gda.pl/people/macro/".

  Maciej
