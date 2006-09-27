Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 16:11:44 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2565 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038755AbWI0PLl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 16:11:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3CAF7F5D2D;
	Wed, 27 Sep 2006 17:11:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y1GS64Ns3RrS; Wed, 27 Sep 2006 17:11:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6F8F2F5F24;
	Wed, 27 Sep 2006 17:11:07 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k8RFBUCg023478;
	Wed, 27 Sep 2006 17:11:31 +0200
Date:	Wed, 27 Sep 2006 16:11:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	manoje@broadcom.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, mark.e.mason@broadcom.com
Subject: Re: [MIPS] SB1: Build fix: delete initialization of flush_icache_page
 pointer.
In-Reply-To: <20060927.235804.95064004.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0609271609480.7657@blysk.ds.pg.gda.pl>
References: <20060926.183946.49857108.nemoto@toshiba-tops.co.jp>
 <710F16C36810444CA2F5821E5EAB7F230A0E45@NT-SJCA-0752.brcm.ad.broadcom.com>
 <20060927.235804.95064004.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1947/Wed Sep 27 02:46:56 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 27 Sep 2006, Atsushi Nemoto wrote:

> BTW, what you tried is something like this ?
> 
> include/asm-mips/cacheflush.h:
> static inline void flush_icache_page(struct vm_area_struct *vma,
> 	struct page *page)
> {
> 	__flush_icache_page(vma, page);
> }
> 
> If this caused panic, what is the message?

 I have:

#define flush_icache_page __flush_icache_page

there for the time being while working on something else and it works just 
fine with my SWARM and 2.6.18-20060920.

  Maciej
