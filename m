Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2004 00:22:36 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:35085 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8224903AbUKPAWa>; Tue, 16 Nov 2004 00:22:30 +0000
Received: from [192.168.2.27] (x1000-57.tellink.net [63.161.110.249])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id iAG0BjB4004633;
	Mon, 15 Nov 2004 19:11:46 -0500
In-Reply-To: <0a2201c4ca62$25d37f80$a701a8c0@lan>
References: <20041112181335.13362.qmail@web81008.mail.yahoo.com> <09ac01c4ca24$e68a6740$a701a8c0@lan> <0a2201c4ca62$25d37f80$a701a8c0@lan>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FA00299D-3765-11D9-A70B-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: <linux-mips@linux-mips.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: GPIO on the Au1500
Date: Mon, 15 Nov 2004 19:25:10 -0500
To: "Gilad Rom" <gilad@romat.com>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Nov 14, 2004, at 10:53 AM, Gilad Rom wrote:

> For some reason, I keep getting that magical value, 0x10000001 for 
> EVERY address I try to read, be it SYS_BASE (0xB1900000) or every 
> other address.

It's not working because that is not the address of the device(s).
The 0xB1900000 is the Kernel Virtual address of these devices, the real
physical address, and the one you have to use with mmap() is the
system control block address 0x11900000.

Just be very, very careful with user space access of any IO using this
method.  The kernel can ensure atomic updates using various methods,
but user applications can't and may cause system failures.  This is why
a GPIO driver is a much better approach.

	-- Dan
