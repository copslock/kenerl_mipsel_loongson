Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 18:59:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:62621 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20033046AbYAHS7K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jan 2008 18:59:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m08Ix3qP024035;
	Tue, 8 Jan 2008 18:59:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m08Ix3Aw024034;
	Tue, 8 Jan 2008 18:59:03 GMT
Date:	Tue, 8 Jan 2008 18:59:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	lovecentry <lovecentry@gmail.com>, linux-mips@linux-mips.org
Subject: Re: kseg1 uncache access issue
Message-ID: <20080108185903.GC30643@linux-mips.org>
References: <4783a652.1cef600a.2530.fffffe31@mx.google.com> <20080108170206.GA8777@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080108170206.GA8777@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 08, 2008 at 06:02:06PM +0100, Thomas Bogendoerfer wrote:

> On Wed, Jan 09, 2008 at 12:35:06AM +0800, lovecentry wrote:
> > As we know in mips achitecture if current pc falls into kseg1 segment, any
> > memory reference will bypass cache and fetch directly from dram. But for
> > some prcoessor such like mips R10K it has off chip L2 cache. I haven't found
> 
> why do you think so ? R10k L2 cache controller is inside CPU and any
> access with uncached attribute will go directly to memory. The only
> systems, where this might be different are systems with caches unknown
> to the cpu. But even those usually obey that uncached accesses are
> going directly to memory.

It should also be mentioned that some R10000 machines do odd stuff with
uncached addresses.

IP27 class machines reuse the entire physical address space several times
to map different things.  The selection of the four uncached address
spaces id done by the uncached attribute which is specified either in
the TLB or or as as bit 59..60 of a virtual address in XKPHYS.

The memory controller of the Indigo 2 R10000 needs to be switched to a
special slower mode to allow uncached accesses first.

  Ralf
