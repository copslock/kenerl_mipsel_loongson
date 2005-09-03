Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2005 04:59:31 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:62735 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8224989AbVICD7D>; Sat, 3 Sep 2005 04:59:03 +0100
Received: from [192.168.2.27] (h69-21-252-132.69-21.unk.tds.net [69.21.252.132])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j833k0KW026454;
	Fri, 2 Sep 2005 23:46:00 -0400
In-Reply-To: <43190B15.7080301@kde.ru>
References: <43190B15.7080301@kde.ru>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e603bacb50427983d7330a58abccb4fa@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: framebuffer for au1000 based board.
Date:	Sat, 3 Sep 2005 00:05:11 -0400
To:	Maxim Moroz <maxim@kde.ru>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Sep 2, 2005, at 10:31 PM, Maxim Moroz wrote:

> Hello, I'm writing framebuffer (800x600@16bpp) for au1000 based board 
> for latest linux-2.6.13 mips kernel.
> video memory is located at address 0xbe00_0000.
> The problem is that I cannot correctly mmap video memory to userspace.

What happens if you just use /dev/mem and that address?

> mmap was taken from au1500 lcd framebuffer driver(code follows)

Bad choice.  Neither the Au1000 nor the Au1500 have internal frame
buffers, so in both cases these are going to be board specific devices.
Since the Au1500 has a PCI bridge, I suspect that driver is designed
to work with the 36-bit address from the Au1500 core.  You are going
to have to write a custom mmap() function that does the proper mapping
for your board design.  Also, the Au1000 had some challenging bus
interface issues to things like graphics controllers and you have to
choose the proper memory controller configuration and hardware
design to even have a chance at this working.

Good Luck, you may have lots of work ahead of you very specific
to your board design :-)


	-- Dan
