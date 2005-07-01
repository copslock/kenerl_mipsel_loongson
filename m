Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 10:34:21 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:58891 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226135AbVGAJeE>; Fri, 1 Jul 2005 10:34:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3B932E1C8A; Fri,  1 Jul 2005 11:33:52 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07710-09; Fri,  1 Jul 2005 11:33:52 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EAA6CE1C78; Fri,  1 Jul 2005 11:33:51 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j619Xs2X011019;
	Fri, 1 Jul 2005 11:33:54 +0200
Date:	Fri, 1 Jul 2005 10:33:58 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: RFH:  What are the semantics of writeb() and friends?
In-Reply-To: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
Message-ID: <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/962/Fri Jul  1 07:19:05 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Jun 2005, David Daney wrote:

> My new question is:  What are the semantics of writeb(), writel() et 
> al.?  I would assume that the effects of these must be in the same order 
> that they were issued, and that any hardware write back queue cannot 
> combine or merge them in any way.  Is that correct?

 No it's not.  You need to insert appropriate barriers, one of: wmb(), 
mb() or rmb().  In rare cases you may need to use iob(), which is 
currently non-portable (which reminds me I should really push it 
upstream).

 For historical reasons only outb(), inl(), outl(), inl(), etc. are meant 
to imply an mb() beforehand and afterwards (IOW, their resulting cycles 
always appear externally in the programmed order).  You may still need 
iob(), though.

> A second question I have is:  What is the difference in the semantics of 
> wbflush() and wmb()?  For my CPU they both evaluate to the same thing 
> (the 'sync' instruction).  So for my own sake I could use either, but 
> depending on the situation I assume that one would be used over the 
> other.

 wbflush() is an old name for iob() -- it will probably vanish one day as 
the name is somewhat inadequate for non-MIPS systems.  They are meant as a 
read/write barrier combined with write completion from the host's point of 
view (i.e. external writes cycles are actually issued by CPU and its 
system controller; they may still be posted e.g. in an I/O bus bridge and 
require another bridge-specific operation to proceed further).  wmb() is 
just a write barrier -- it assures later writes won't be combined with or 
reordered before earlier ones.

 Depending on your needs iob() may be too strong resulting in unnecessary 
performance penalty or wmb() may be to weak resulting in cycles appearing 
in the wrong order or being delayed for too long.  If your CPU happens to 
use "sync" for both, then it probably has an overkill implementation for 
this instruction resulting in performance loss in some places.

  Maciej
