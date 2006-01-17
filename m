Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 13:05:32 +0000 (GMT)
Received: from mail.hot.ee ([194.126.101.116]:22475 "EHLO mail.hot.ee")
	by ftp.linux-mips.org with ESMTP id S3465570AbWAQNFK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 13:05:10 +0000
References: <20060117094053.D0DFBAF060@mh3-4.hot.ee>  <20060117121018.GA3336@linux-mips.org>
In-Reply-To: <20060117094053.D0DFBAF060@mh3-4.hot.ee> <20060117121018.GA3336@linux-mips.org>
x-mailer: Elion E-kohvik Webmail (http://www.hot.ee)
From:	Riisisulg <riisisulg@hot.ee>
Date:	Tue, 17 Jan 2006 15:08:42 +0200
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: RE: Re: atomic_add function on memory allocated with dma_alloc_coherent hangs
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
Message-Id: <20060117130847.2F2AC4A553@mh3-6.hot.ee>
X-Virus-Scanned: by amavisd-new-2.2.1 (20041222) (Debian) at hot.ee
Return-Path: <riisisulg@hot.ee>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riisisulg@hot.ee
Precedence: bulk
X-list: linux-mips

> On Tue, Jan 17, 2006 at 11:40:53AM +0200, Riisisulg wrote:
> 
> > Hello. I'm using AMD Alchemy db1550 with au1550, it has 2.6.15
kernel
> > patched with linux-2.6.14.5-mips-1.patch, i have compiled cross
compiler
> > for the platform (but not checked it for correctness)
> > 
> > since db1550 does not have USB2.0 but instead has two PCI slots, i
> > installed NEC's PCI to USB 2.0 host controller board to it. I was
able
> > to load ehci-hcd driver with success but after the usb mass storage
> > device was inserted the system hanged. 
> > After debugging a while i found out that function atomic_add did
not
> > return. I run few tests where atomic add asm code was alerted and
got
> > confidence that sc instruction did not never succeed so the cycle
was
> > repeating forever.
> 
> The operation of ll/sc is undefined on uncached memory; non-coherent
> MIPS systems - that is most embedded MIPS systems - will return non
> cache-coherent memory for dma_alloc_coherent.  Yes, the naming sucks,
> dma_alloc_{non}coherent do the opposite of what their name is.
> 
>   Ralf

Thank you for quick answer so i will make some conclusions here

The problem come out by using ehci-hcd, that diver uses it's own dma
pool where it allocates structures of type ehci_qh.
struct ehci_qh has field of kref of type struct kref

in ehci-mem.c file there are functions qh_get(struct ehci_qh *qh),
qh_put(struct ehci_qh *qh) that use functions kref_get and kref_put.

Since ehci_qh structures are allocated from dma pool and both kref_get
and kref_put are using atomic functions that use ll sc then on
non-coherent MIPS system both qh_get and qh_put will hang the system.
The simplest workaround is to replace kref_get and kref_put in
ehci-mem.c or not to use dma pool. I have not cheked other kernel
drivers that use atomic functions on uncached memory.

END, i hope.
