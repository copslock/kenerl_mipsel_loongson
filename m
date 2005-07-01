Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 16:29:48 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:62736 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226159AbVGAP3b>; Fri, 1 Jul 2005 16:29:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 07967F598F; Fri,  1 Jul 2005 17:29:19 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14038-09; Fri,  1 Jul 2005 17:29:18 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BE05CF598D; Fri,  1 Jul 2005 17:29:18 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j61FTMYd008310;
	Fri, 1 Jul 2005 17:29:22 +0200
Date:	Fri, 1 Jul 2005 16:29:30 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	"'Daniel Jacobowitz'" <dan@debian.org>,
	"'Stephen P. Becker'" <geoman@gentoo.org>,
	macro@blysk.ds.pg.gda.pl,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: Seg fault when compiled with -mabi=64 and -lpthread
In-Reply-To: <20050701150938Z8226157-3678+821@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507011622380.30138@blysk.ds.pg.gda.pl>
References: <20050701150938Z8226157-3678+821@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/963/Fri Jul  1 15:27:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Bryan Althouse wrote:

> Looks like I should upgrade glibc, and possibly gcc.  When you say that I
> should try CVS HEAD of glibc, I'm not sure what you mean.  I have looked in
> the linux-mips.org CVS and the closest thing I can find is libc, and it
> looks really old.  I have also found a glibc CVS at
> :pserver:anoncvs@sources.redhat.com:/cvs/glibc.  If I get libc from here is
> this the "CVS HEAD"?  

 Yes, just pull the tree without any tags.

> Should I get GCC from the generic GCC site, or should get it from the
> linux-mips CVS?  

 The latest GCC 3.4.x should probably be OK, but if you want 4.x, then 
just get the latest release from (your closest mirror of) ftp.gnu.org -- 
if you don't rush, that may be 4.0.1.

> I apologize for the simple questions.  I have not built a tool chain before.
> I've been using the one supplied by PMC-Sierra.  Will I need to patch any of
> these sources for MIPs?

 It depends on whether you trigger any bugs.

  Maciej
