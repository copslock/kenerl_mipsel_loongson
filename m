Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 15:42:44 +0100 (BST)
Received: from mail.mazunetworks.com ([IPv6:::ffff:4.19.249.111]:32184 "EHLO
	mail.mazunetworks.com") by linux-mips.org with ESMTP
	id <S8226827AbVGROm3>; Mon, 18 Jul 2005 15:42:29 +0100
Received: from [172.31.1.134] ([172.31.1.134])
	by mail.mazunetworks.com (8.12.11/8.12.11) with ESMTP id j6IEVXNX019481;
	Mon, 18 Jul 2005 10:31:33 -0400
Message-ID: <42DBC030.7020600@mazunetworks.com>
Date:	Mon, 18 Jul 2005 10:44:00 -0400
From:	David Chau <dchau@mazunetworks.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Dan Malek <dan@embeddedalley.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Why is mmap()ed reserved memory so slow?
References: <42D836F8.8030209@mazunetworks.com> <dc678ee4c98d1fc3eb2cb1960b759f05@embeddedalley.com>
In-Reply-To: <dc678ee4c98d1fc3eb2cb1960b759f05@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dchau@mazunetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dchau@mazunetworks.com
Precedence: bulk
X-list: linux-mips

Dan Malek wrote:

> How about a little more info, like what kernel are you using and what are
> the parameters you are sending to mmap()?

Linux (none) 2.4.31 #412 SMP Fri Jul 15 16:26:05 EDT 2005 mips unknown
(unmodified kernel from linux-mips.org).
It's running on the SB1 on a Broadcom 1250 board.

I mmap() with:
int mem_fd = open("/dev/mem", O_RDWR);
void* mem_base =
    mmap(NULL, DRIVER_MEM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
         mem_fd, DRIVER_MEM_PHYS_BASE);
Where driver_mem_phys_base = 253M, and driver_mem_size=1M.

> The better way to approach this is to place an mmap() function in the
> associated driver that works in conjunction with the application to gain
> shared access as you expect.  This also closes a hole where an errant
> application could write into unexpected places through /dev/mem.


Could you point me to an example of this so I can figure out how to do it?

Thanks,
David
