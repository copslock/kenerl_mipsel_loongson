Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2005 17:54:52 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:49168 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226041AbVF2Qyh>; Wed, 29 Jun 2005 17:54:37 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 77750E1CB9; Wed, 29 Jun 2005 18:54:11 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04077-10; Wed, 29 Jun 2005 18:54:11 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 22155E1CB3; Wed, 29 Jun 2005 18:54:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5TGsFxE020364;
	Wed, 29 Jun 2005 18:54:15 +0200
Date:	Wed, 29 Jun 2005 17:54:25 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Markus Dahms <mad@automagically.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6 on IP22 (Indy)
In-Reply-To: <20050628170425.GA5189@gaspode.automagically.de>
Message-ID: <Pine.LNX.4.61L.0506291747550.31188@blysk.ds.pg.gda.pl>
References: <20050627100757.GA27679@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271401280.15406@blysk.ds.pg.gda.pl>
 <20050627141842.GA28236@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506271632380.23903@blysk.ds.pg.gda.pl>
 <20050628062107.GA8665@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506280918380.13758@blysk.ds.pg.gda.pl>
 <20050628102013.GA10442@gaspode.automagically.de>
 <Pine.LNX.4.61L.0506281204190.13758@blysk.ds.pg.gda.pl>
 <20050628170425.GA5189@gaspode.automagically.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/960/Wed Jun 29 06:31:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello Markus,

> I think I found the trick. Just following the hint that the R4600
> is similar to the R5000 I added CPU_R4600 to build_tlb_probe_entry().

 Well, they are not meant to be errata-compatible. ;-)  I haven't been 
able to locate any reference for tlbp being problematic on the R4600, in 
particular not in the chip errata document, and the old handlers used to 
have a nop before that instruction unconditionally (perhaps just in case 
;-) ), so the problem was covered.  If it fixes the problem for you, then 
it should probably be applied, too.  Not sure about the R4700 -- it fixed 
a few problems that were there in the R4600 as a side effect, so perhaps 
we should wait for some report first.

  Maciej
