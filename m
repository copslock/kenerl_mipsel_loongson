Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 23:20:44 +0100 (BST)
Received: from mail.mazunetworks.com ([IPv6:::ffff:4.19.249.111]:20140 "EHLO
	mail.mazunetworks.com") by linux-mips.org with ESMTP
	id <S8226752AbVGOWU3>; Fri, 15 Jul 2005 23:20:29 +0100
Received: from [172.31.1.134] ([172.31.1.134])
	by mail.mazunetworks.com (8.12.11/8.12.11) with ESMTP id j6FM9Xgq022962
	for <linux-mips@linux-mips.org>; Fri, 15 Jul 2005 18:09:34 -0400
Message-ID: <42D836F8.8030209@mazunetworks.com>
Date:	Fri, 15 Jul 2005 18:21:44 -0400
From:	David Chau <dchau@mazunetworks.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Why is mmap()ed reserved memory so slow?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dchau@mazunetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dchau@mazunetworks.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm working on a driver for the Broadcom 1250, and I am using reserved 
memory for some data buffers. The board comes with 256 MB of RAM, so I 
boot Linux with "mem=253M" to reserve some RAM at the top of memory, and 
then mmap() /dev/mem starting at 253 MB.

The problem is that accessing this memory is ridiculously slow. A simple 
benchmark revealed that it takes about 200 cycles to read a 64-bit 
number. If I mmap() /dev/zero instead, a read takes under 3 cycles.

For those of you who knows how the Linux VM works, could you tell me why 
the memory access is so slow? It look like it might be invoking the 
page-fault handler on every read. How can I make memory access faster?

Thanks,
David
