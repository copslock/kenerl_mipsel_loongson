Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 23:49:07 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:14758 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S28640072AbXCBXtD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 23:49:03 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1HNHRb-0000YW-00; Sat, 03 Mar 2007 00:45:47 +0100
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
	#2]
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	ralf <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <116841864595-git-send-email-fbuihuu@gmail.com>
References: <116841864595-git-send-email-fbuihuu@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Freebox
Date:	Sat, 03 Mar 2007 00:45:47 +0100
Message-Id: <1172879147.964.65.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Wed, 2007-01-10 at 09:44 +0100, Franck Bui-Huu wrote:

Hi Franck,

> Here's is the second attempt to make this works on your Malta board
> and all other boards that have some data reserved at the start of
> their memories. In these cases the first patchset assumed wrongly that

I was happy to try this patch on my 4Kec board with memory starting at
0x10000000 but it doesn't work.


Setting PHYS_OFFSET to 0, I get the expected "Wasting 2098176 bytes for
tracking 65568 unused pages" and everything works as usual.

Setting PHYS_OFFSET to 0x10000000, I get "Wasting 1024 bytes for
tracking 32 unused pages", but the kernel doesn't boot and crash in
init_bootmem_node().


Looking at phys_to_virt(), it looks like I also need to change
PAGE_OFFSET to 0x90000000 to get correct values. This makes the kernel
boot with a correct memory map, but userspace doesn't work anymore.

Just in case, I'm not using git head, but a 2.6.20 kernel with the 2
patches applied. Just tell me if you need complete dmesg.

Regards,

-- 
Maxime
