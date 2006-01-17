Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 12:07:02 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:46869 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465570AbWAQMGp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 12:06:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HCAJ1P009596;
	Tue, 17 Jan 2006 12:10:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0HCAIQD009595;
	Tue, 17 Jan 2006 12:10:18 GMT
Date:	Tue, 17 Jan 2006 12:10:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Riisisulg <riisisulg@hot.ee>
Cc:	linux-mips@linux-mips.org
Subject: Re: atomic_add function on memory allocated with dma_alloc_coherent hangs
Message-ID: <20060117121018.GA3336@linux-mips.org>
References: <20060117094053.D0DFBAF060@mh3-4.hot.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117094053.D0DFBAF060@mh3-4.hot.ee>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 17, 2006 at 11:40:53AM +0200, Riisisulg wrote:

> Hello. I'm using AMD Alchemy db1550 with au1550, it has 2.6.15 kernel
> patched with linux-2.6.14.5-mips-1.patch, i have compiled cross compiler
> for the platform (but not checked it for correctness)
> 
> since db1550 does not have USB2.0 but instead has two PCI slots, i
> installed NEC's PCI to USB 2.0 host controller board to it. I was able
> to load ehci-hcd driver with success but after the usb mass storage
> device was inserted the system hanged. 
> After debugging a while i found out that function atomic_add did not
> return. I run few tests where atomic add asm code was alerted and got
> confidence that sc instruction did not never succeed so the cycle was
> repeating forever.

The operation of ll/sc is undefined on uncached memory; non-coherent
MIPS systems - that is most embedded MIPS systems - will return non
cache-coherent memory for dma_alloc_coherent.  Yes, the naming sucks,
dma_alloc_{non}coherent do the opposite of what their name is.

  Ralf
