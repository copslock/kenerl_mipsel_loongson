Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2005 21:15:15 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:48394 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225216AbVB1VO6>; Mon, 28 Feb 2005 21:14:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3F907F5A29
	for <linux-mips@linux-mips.org>; Mon, 28 Feb 2005 22:14:51 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12618-09 for <linux-mips@linux-mips.org>;
 Mon, 28 Feb 2005 22:14:51 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DEF43E1C77
	for <linux-mips@linux-mips.org>; Mon, 28 Feb 2005 22:14:50 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1SLEq8U005674
	for <linux-mips@linux-mips.org>; Mon, 28 Feb 2005 22:14:53 +0100
Date:	Mon, 28 Feb 2005 21:15:02 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [announce] Cross GCC 4.0.0 packages available
Message-ID: <Pine.LNX.4.61L.0502282104110.16004@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 I've updated my RPM package archive to include sources and binaries of 
GCC 4.0.0 hosted on i386-linux for the mipsel-linux and the mips64el-linux 
targets.  The mipsel-linux complier includes all frontends, that is for 
Ada, C, C++, Fortran, Java and Objective-C.  The mips64el-linux compiler 
includes only the C frontend.  No native packages yet.  Note the 
mips64el-linux toolchain includes local changes that make it produce (n)64 
binaries by default.

 Packages are available at the usual location, i.e.: 
"ftp://ftp3.ds.pg.gda.pl/people/macro/".

  Maciej
