Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5DNFOnC007836
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 13 Jun 2002 16:15:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5DNFOJ9007835
	for linux-mips-outgoing; Thu, 13 Jun 2002 16:15:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5DNFInC007832
	for <linux-mips@oss.sgi.com>; Thu, 13 Jun 2002 16:15:18 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g5DNHiC13379;
	Fri, 14 Jun 2002 01:17:44 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g5DNHjTF018060;
	Fri, 14 Jun 2002 01:17:45 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.34 #1 (Debian))
	id 17Idqa-00024a-00; Fri, 14 Jun 2002 01:17:44 +0200
Date: Fri, 14 Jun 2002 01:17:44 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@oss.sgi.com
Subject: Re: R10K speculative store on non-coherent systems workaround proposal
In-Reply-To: <1023707152.18634.18.camel@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.21.0206140037260.7607-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 10 Jun 2002, Ralf Baechle wrote:

> Looks like a good start but unfortunately your concept is ignoring
> userspace entirely.

indeed ;)

> You might have to deal with mmapped pages that are being written to
> backing storage.

True.

> In such a case you'll have to trackdown all mappings and disable
> access to them

I don't think so. Before doing DMA, pages will be locked with lock_page
(mm/filemap.c) and processes accessing this page will be
forced to wait for I/O completion. Quote from include/asm/page.h:
>> * During disk I/O, PG_locked is used. This bit is set before I/O
>> * and reset when I/O completes. page->wait is a wait queue of all
>> * tasks waiting for the I/O on this page to complete.

Thus, no user process should be accessing the page during the I/O transfer
(this would cause problems anyway, even on coherent
architectures). However, now our problem is that the mappings may still be
in the TLB, and thus speculative stores could be executed to the DMA
buffer. However, this can be easily worked around by flushing the TLB
entries for these mappings (we only have 64 to check, or we can do the
bovine flush_tlb_all ;)). Thus mappings will be invalid for the CPU,
causing an exception that will abort the speculative store.
Does that sound ok?

> Intially I guess you can simply avoid this hairy job by doing all DMA using
> bounce buffers only.  Expensive but doable ...

I'd prefer to avoid those expensive memcpy if possible..

Vivien.
