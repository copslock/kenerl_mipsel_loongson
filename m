Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g04KkK521596
	for linux-mips-outgoing; Fri, 4 Jan 2002 12:46:20 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g04KkGg21579
	for <linux-mips@oss.sgi.com>; Fri, 4 Jan 2002 12:46:17 -0800
Received: from resel.enst-bretagne.fr (user94819@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g04Jk7b07726
	for <linux-mips@oss.sgi.com>; Fri, 4 Jan 2002 20:46:07 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id UAA26202
	for <linux-mips@oss.sgi.com>; Fri, 4 Jan 2002 20:46:07 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MaI3-00014n-00
	for <linux-mips@oss.sgi.com>; Fri, 04 Jan 2002 20:46:07 +0100
Date: Fri, 4 Jan 2002 20:46:07 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: linux-mips@oss.sgi.com
Subject: Re: aic7xxx (O2 scsi) DMA coherency (fwd)
Message-ID: <Pine.LNX.4.21.0201042044320.3734-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

forgot the Cc to the list...
BTW sorry for the dual post.

---------- Forwarded message ----------
Date: Fri, 4 Jan 2002 20:33:48 +0100 (CET)
From: Vivien Chappelier <glaurung@melkor.maisel.enst-bretagne.fr>
To: Ilya Volynets <ilya@theilya.com>
Subject: Re: aic7xxx (O2 scsi) DMA coherency

> Are you sure GFP_DMA does what you think it does?

> I'm not. I thnk using pci_alloc_consistant is more appropriate for
> this purpose.

Neither am I, I'm just a new kernel hacker :)
Anyway, I think what we want is doing I/O using DMA with the scsi
controller, so I think we need DMA safe memory for this. Wether the arch
needs to ensure coherency for that is not really the concern. On the O2,
dma memory is uncacheable memory, but other archs might have other
concerns regarding dma memory (below 16Mb for example?), so I think
pci_alloc_consistent is not appropriate in this case.

regards,
Vivien Chappelier.
