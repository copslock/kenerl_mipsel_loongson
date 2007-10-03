Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 14:51:25 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:25504 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021528AbXJCNvR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 14:51:17 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DB734400A8;
	Wed,  3 Oct 2007 15:51:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id geuztPUpQRF2; Wed,  3 Oct 2007 15:51:10 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9DF9B400D8;
	Wed,  3 Oct 2007 15:51:10 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l93DpECn029224;
	Wed, 3 Oct 2007 15:51:14 +0200
Date:	Wed, 3 Oct 2007 14:51:10 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <20071003131158.GL16772@networkno.de>
Message-ID: <Pine.LNX.4.64N.0710031418580.6611@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4461/Wed Oct  3 10:50:48 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 3 Oct 2007, Thiemo Seufer wrote:

> Then you have the worst of both approaches: The nicely readable
> disassembly will change under you feet, and you still need relocation
> annotations etc. for CPU-specific fixups. The end-result is likely
> more complicated and opaque than what we have now.

 Well, to be honest what we have now is very good.  One trouble at the 
beginning, just after we switched from the old approach, was limited 
ability to get at what really is generated and therefore tough time to 
determine what was going on if something was wrong.  With these debug 
dumps in place it is gone now too.

 There is one limitation though -- unlike with ready-writted assembly to 
debug this code you typically need to have a specific system that shows a 
problem.  If you do not have one chances are you can miss a condition 
somewhere and therefore the problem.  Once you have the right piece of 
hardware, debugging is easy -- it took me half of a day if not less to 
sort out all the issues with the R3000 TLB handlers that we had once I got 
my hands on a suitable system.

 And as with everything, there is still room for improvement though.  For 
example I have noticed for the 64-bit TLB refill handler the path for 
vmalloc()ed pages may fit entirely in half of the space available.  Which 
means whatever is emitted after "eret" may be shifted to the TLB refill 
space at 0x80000000 saving the branch from the XTLB space at its end.  
That is probably doable with reasonably little effort given that we have 
support for "relocations".

  Maciej
