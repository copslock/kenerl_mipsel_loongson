Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 16:54:37 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:34528 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8226162AbVGAPyQ>; Fri, 1 Jul 2005 16:54:16 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.50 #1 (Debian))
	id 1DoMu9-0007J0-62; Fri, 01 Jul 2005 09:54:09 -0500
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
In-Reply-To: <20050701150938Z8226157-3678+821@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Date:	Fri, 1 Jul 2005 09:54:09 -0500 (CDT)
CC:	"'Daniel Jacobowitz'" <dan@debian.org>,
	"'Stephen P. Becker'" <geoman@gentoo.org>,
	macro@blysk.ds.pg.gda.pl,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1DoMu9-0007J0-62@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> Looks like I should upgrade glibc, and possibly gcc.  When you say that I
> should try CVS HEAD of glibc, I'm not sure what you mean.  I have looked in
> the linux-mips.org CVS and the closest thing I can find is libc, and it
> looks really old.  I have also found a glibc CVS at
> :pserver:anoncvs@sources.redhat.com:/cvs/glibc.  If I get libc from here is
> this the "CVS HEAD"?  
> 
> Should I get GCC from the generic GCC site, or should get it from the
> linux-mips CVS?  
> 
> I apologize for the simple questions.  I have not built a tool chain before.
> I've been using the one supplied by PMC-Sierra.  Will I need to patch any of
> these sources for MIPs?
> 
Also, stay away from the HEAD of GCC CVS. GCC-4.1.0 compilers cannot
build Linux kernels.

-Steve
