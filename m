Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g04Lx0e24435
	for linux-mips-outgoing; Fri, 4 Jan 2002 13:59:00 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g04Lwtg24432
	for <linux-mips@oss.sgi.com>; Fri, 4 Jan 2002 13:58:56 -0800
Received: from resel.enst-bretagne.fr (user46613@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g04Kwjb11653;
	Fri, 4 Jan 2002 21:58:45 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id VAA31614;
	Fri, 4 Jan 2002 21:58:46 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MbQM-0001AH-00; Fri, 04 Jan 2002 21:58:46 +0100
Date: Fri, 4 Jan 2002 21:58:45 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ilya Volynets <ilya@theilya.com>
cc: linux-mips@oss.sgi.com
Subject: Re: aic7xxx (O2 scsi) DMA coherency
In-Reply-To: <20020104194622.29320.qmail@gateway.total-knowledge.com>
Message-ID: <Pine.LNX.4.21.0201042102120.4156-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 4 Jan 2002, Ilya Volynets wrote:

> On Friday 04 January 2002 11:33 am, you wrote:
> This is true in theory. In practice you have to look at kmalloc implementation
> and how it uses GFP_DMA. I don't remember anything arch specific in there,
> but I never seriously dug in that part. I believe it doesn't do what we need,
> otherwice We'd be using it for pci_alloc_consistent.

Well, both pci_alloc_consistent and kmalloc will end up calling
__get_free_pages, with the GFP_DMA flag set. On setup, with the MIPS64
arch, DMA memory is set to start in non-cacheable space (don't know how).
So both pci_alloc_consistent and kmalloc(GFP_DMA,...) will return DMA safe
(i.e. non cacheable) memory.
see mm/slab.c (for kmalloc and how it finally calls __get_free_pages).

regards,
Vivien Chappelier.
