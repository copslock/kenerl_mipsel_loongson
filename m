Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 15:11:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:26630 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226148AbVGAOKv>; Fri, 1 Jul 2005 15:10:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7A8C0F5999; Fri,  1 Jul 2005 16:10:38 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05091-10; Fri,  1 Jul 2005 16:10:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 29565F598E; Fri,  1 Jul 2005 16:10:38 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j61EA0n6004138;
	Fri, 1 Jul 2005 16:10:00 +0200
Date:	Fri, 1 Jul 2005 15:10:08 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"Stephen P. Becker" <geoman@gentoo.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
In-Reply-To: <20050701133910.GA24716@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0507011450180.30138@blysk.ds.pg.gda.pl>
References: <20050630173409Z8226102-3678+735@linux-mips.org>
 <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org>
 <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org>
 <Pine.LNX.4.61L.0507010940280.30138@blysk.ds.pg.gda.pl>
 <20050701133910.GA24716@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/963/Fri Jul  1 15:27:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Daniel Jacobowitz wrote:

> >  And you may need external patches as glibc is (effectively) not 
> > maintained.
> 
> Shall I just stop trying, then?  I'm getting tired of arguing with you
> about this.

 Certainly not! -- in this case I haven't meant the MIPS port, but glibc 
as a whole -- just have a look at the response to fixes for the Alpha or 
i386!

 And please forgive me for the feeling of me arguing with you -- it wasn't 
my intention.  Frankly I cannot even realize exactly when it happened.

> For the twentieth time: I am doing everything I can to keep glibc HEAD
> building for MIPS.  I do not have the time or energy to deal with
> Roland's restrictive stable branch rules, so I can not help with 2.3.5.

 Building is not everything. ;-)

> But if you encounter a problem on HEAD, let me know, and I will either
> fix it myself or (if you've got a patch) pester people relentlessly
> until it is applied.

 Certainly -- I'm assuming you are ready for a pile of patches then?  
Well, perhaps not that many, but I think I've got around four that should 
go upstream.  I'll have a look if they apply cleanly.  None of them 
addresses a problem with building though.

  Maciej
