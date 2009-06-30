Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 19:16:20 +0200 (CEST)
Received: from smtp.zeugmasystems.com ([70.79.96.174]:9251 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S2097309AbZF3RQM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jun 2009 19:16:12 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Broadcom Swarm support
Date:	Tue, 30 Jun 2009 10:10:47 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501C95B0C@exchange.ZeugmaSystems.local>
In-Reply-To: <20090627154902.GA18139@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Broadcom Swarm support
Thread-Index: Acn3Pu1bxNbhRQ+URyCHewtURsjNxQBoRXuw
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Aurelien Jarno" <aurelien@aurel32.net>,
	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote, on June 27, 2009 8:49 AM
> On Wed, Jun 24, 2009 at 03:18:24PM -0700, Kaz Kylheku wrote:
> 
> > +void __flush_icache_page(struct vm_area_struct *vma, 
> struct page *page)
> > +{
> > +	if (vma->vm_flags & VM_EXEC)
> > +		flush_icache_range((unsigned long) page_address(page),
> > PAGE_SIZE); 
> > +}
> 
> Flush_icache_range takes two arguments, start and end address.  Both
> addresses are the virtual addresses at which the code will 
> run.

Thanks for pointing that out. After wiping some egg of my face,
I'm now testing this change:

 void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
 {
        if (vma->vm_flags & VM_EXEC)
-               flush_icache_range((unsigned long) page_address(page),
PAGE_SIZE);
+               flush_icache_range(vma->vm_start, vma->vm_end);
 }

I see a small performance improvement, suggesting that it's flushing
cache lines more precisely.

But I am now more confused, because it turns out that my kernel still
runs
fine now if I turn the function into a noop!

We must have fixed something since the time I was getting this kernel
running. Or it could be that I'm using a CF from a different
manufacturer.

Still, there is the observation that this flush_icache_page restoration
also gets Aurelien's Swarm up and running.
