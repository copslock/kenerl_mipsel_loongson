Received:  by oss.sgi.com id <S42219AbQGFA2o>;
	Wed, 5 Jul 2000 17:28:44 -0700
Received: from f260.law9.hotmail.com ([64.4.8.135]:47114 "HELO hotmail.com")
	by oss.sgi.com with SMTP id <S42203AbQGFA2U>;
	Wed, 5 Jul 2000 17:28:20 -0700
Received: (qmail 64368 invoked by uid 0); 6 Jul 2000 00:28:24 -0000
Message-ID: <20000706002824.64367.qmail@hotmail.com>
Received: from 208.198.161.2 by www.hotmail.com with HTTP;
	Wed, 05 Jul 2000 17:28:24 PDT
X-Originating-IP: [208.198.161.2]
From:   "Erik Niessen" <erik_niessen@hotmail.com>
To:     linux-mips@oss.sgi.com
Subject: Doing DMA with the ide-driver
Date:   Thu, 06 Jul 2000 02:28:24 CEST
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am trying to get an external ide-pci controller (CMD 646) working on an 
embedded mips board. The kernel-source is based on a 2.2.12 source tree.

The problem is doing DMA. I receive address (0x80ff0000) for my dmatable in 
the function ide_setup_dma (__get_free_pages). Then in ide_buildtable it 
sets up the dmatable. Address 0x80376000 and a count of 0x400 
(check_partition reads 2 sectors from the harddrive). These are all virtual 
addresses. For setting up the dmatable I use physical addresses. On the 
embedded board there is a 1:1 map of i/o bus to main memory so 
platform_mem_iobus_base is 0.

So after doing the DMA read, I read only zero's at address 0x80376000 and 
the kernel hangs. But the harddrive is ready and I can't find any errors. It 
seems that it writes the data to a different memory location. After 
searching the memory the data is written at address 0x80000000??  Is the 
memory manager somewhere in between???

The next thing I did was reserving a piece of physical memory for DMA and 
fill in the dmatable myself. So that it uses my piece of reserved memory. 
After I did this, the data was at the correct address and the kernel didn't 
crash. Is this the solution???

Anyone a clue?

Thanks,

	Erik

________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com
