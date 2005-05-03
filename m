Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2005 21:10:15 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:20999 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225545AbVECUKA>; Tue, 3 May 2005 21:10:00 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j43K3ifg027627;
	Tue, 3 May 2005 16:03:44 -0400
In-Reply-To: <e02bc66105050312564d0dacdb@mail.gmail.com>
References: <e02bc66105050312564d0dacdb@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f2bcc2c8588140446359a0f5f5cf78ca@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: How to the the physical addresses under linux (au1500)
Date:	Tue, 3 May 2005 16:09:58 -0400
To:	Sergio Ruiz <quekio@gmail.com>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On May 3, 2005, at 3:56 PM, Sergio Ruiz wrote:

> I am trying to program  the DMA (with the ac97) in assembler using a
> linux kernel module for mips teaching purposes.

I think you want to choose a more simple teaching example :-)

> Looking at the kernel source code, I found that I can get the physical
> address subtracting 0x8000000, but It doesnt seem to work.

Not always.  On systems like this one that are not cache coherent,
we play games with mapped addresses to get uncached spaces
or you need to apply various macros/functions to keep the space
coherent.

> Any idea?

Use a more simple example.  Maybe just update one of the
LED displays on the board.


	-- Dan
