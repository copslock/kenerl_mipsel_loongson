Received:  by oss.sgi.com id <S42222AbQGFBZf>;
	Wed, 5 Jul 2000 18:25:35 -0700
Received: from u-69.karlsruhe.ipdial.viaginterkom.de ([62.180.21.69]:28932
        "EHLO u-69.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42203AbQGFBZd>; Wed, 5 Jul 2000 18:25:33 -0700
Received:  by lappi.waldorf-gmbh.de id <S407622AbQGFBZK>;
	Wed, 5 Jul 2000 18:25:10 -0700
Date:   Thu, 6 Jul 2000 03:25:10 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Erik Niessen <erik_niessen@hotmail.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Doing DMA with the ide-driver
Message-ID: <20000706032510.A5122@bacchus.dhis.org>
References: <20000706002824.64367.qmail@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000706002824.64367.qmail@hotmail.com>; from erik_niessen@hotmail.com on Thu, Jul 06, 2000 at 02:28:24AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 06, 2000 at 02:28:24AM +0200, Erik Niessen wrote:

> I am trying to get an external ide-pci controller (CMD 646) working on an 
> embedded mips board. The kernel-source is based on a 2.2.12 source tree.
> 
> The problem is doing DMA. I receive address (0x80ff0000) for my dmatable in 
> the function ide_setup_dma (__get_free_pages). Then in ide_buildtable it 
> sets up the dmatable. Address 0x80376000 and a count of 0x400 
> (check_partition reads 2 sectors from the harddrive). These are all virtual 
> addresses. For setting up the dmatable I use physical addresses. On the 
> embedded board there is a 1:1 map of i/o bus to main memory so 
> platform_mem_iobus_base is 0.
> 
> So after doing the DMA read, I read only zero's at address 0x80376000 and 
> the kernel hangs. But the harddrive is ready and I can't find any errors. It 
> seems that it writes the data to a different memory location. After 
> searching the memory the data is written at address 0x80000000??  Is the 
> memory manager somewhere in between???
> 
> The next thing I did was reserving a piece of physical memory for DMA and 
> fill in the dmatable myself. So that it uses my piece of reserved memory. 
> After I did this, the data was at the correct address and the kernel didn't 
> crash. Is this the solution???

What you're observing can be explained by caches not being flushed properly.
What kernel versions are you using?

  Ralf
