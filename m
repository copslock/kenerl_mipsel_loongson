Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MDOOU01501
	for linux-mips-outgoing; Tue, 22 Jan 2002 05:24:24 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MDOKP01498
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 05:24:20 -0800
Received: from resel.enst-bretagne.fr (root@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g0MCO3506737;
	Tue, 22 Jan 2002 13:24:04 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.1/8.12.1/Debian -5) with ESMTP id g0MBXh0R011235;
	Tue, 22 Jan 2002 12:33:44 +0100
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16SzBP-0000WI-00; Tue, 22 Jan 2002 12:33:43 +0100
Date: Tue, 22 Jan 2002 12:33:43 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Gerald Champagne <gerald.champagne@esstech.com>
cc: linux-mips@oss.sgi.com
Subject: Re: ide dma in latest cvs
In-Reply-To: <3C4CA8C8.5010801@esstech.com>
Message-ID: <Pine.LNX.4.21.0201221226450.1387-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 21 Jan 2002, Gerald Champagne wrote:

> - blk_rq_map_sg() is called to build a list of blocks to be transferred.
>    It sets address = NULL for every entry (other fields like "page" are
>    set to valid values).
> 
> - dma_cache_wback_inv(addr, size) is called for each block entry.  This
>    routine crashes because the address parameter is always set to zero
>    when the routine is called.
> 
> I see that this is part of the new bio code recently added.  Should I expect
> this code to work, or is it not yet working for the mips platform?

I've encountered a similar problem on O2. You can probably fix it by
adding the code for handling pages in 
pci_map_sg/pci_unmap_sg/pci_sync_sg. This is what I've done for ip32 and
ip27:

 unsigned long address;

 if(sg->address)
   address = sg->address;
 else
   address = page_address(sg->page) + sg->offset; 
 dma_cache_wback_inv(address, sg->length);


regards,
Vivien Chappelier.
