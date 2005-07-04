Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2005 13:05:05 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:30725 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226149AbVGDMEt>; Mon, 4 Jul 2005 13:04:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1E520F5969; Mon,  4 Jul 2005 14:04:55 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30207-06; Mon,  4 Jul 2005 14:04:55 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E3BA3E1CAF; Mon,  4 Jul 2005 14:04:54 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j64C4vH7025098;
	Mon, 4 Jul 2005 14:04:58 +0200
Date:	Mon, 4 Jul 2005 13:05:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: top and SMP
In-Reply-To: <Pine.LNX.4.62.0507022238060.19703@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61L.0507041254430.32001@blysk.ds.pg.gda.pl>
References: <20050701172641Z8226172-3678+842@linux-mips.org>
 <Pine.LNX.4.62.0507022238060.19703@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/965/Sun Jul  3 21:23:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 2 Jul 2005, Geert Uytterhoeven wrote:

> > Looks like I am running procps version 2.0.7.  The latest is 3.2.5, so I am
> > a bit out of date.  I would like to upgrade, but I am having trouble cross
> > compiling the latest.  I get this error:
> > 	Proc/libproc-3.2.5.so: undefined reference to '__ctype_b'
> 
> Is the version of glibc your cross-toolchain links against the same as the
> version of glibc on the target?
> 
> Last time I saw that one was when trying to run `old' (i.e. dynamically linked
> against an older glibc) binaries on a system with a new glibc.

 This is strange -- while there are such problems with static libraries 
(archives) consisting of objects built using headers of glibc 2.2.x when 
used for linking against static glibc 2.3.x, there should be none with 
shared objects.  That '__ctype_b' reference should get resolved using a 
versioned symbol that is still available for run-time linking from shared 
libc.  Perhaps that libproc has been built incorrectly, without a 
reference to libc?  Or there is a problem with binutils...

 Anyway, rebuilding libproc should fix the problem -- make sure `gcc' is 
used for creating shared libproc rather than `ld' (I hope its Makefiles do 
not use any wild shared library hackery).

  Maciej
