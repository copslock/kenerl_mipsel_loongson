Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 20:44:49 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:60167 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225957AbVCDUoe>; Fri, 4 Mar 2005 20:44:34 +0000
Received: from [10.1.100.57] ([64.164.196.27])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j24KiZX5028537;
	Fri, 4 Mar 2005 15:44:35 -0500
In-Reply-To: <20050304202338.GA14128@linux-mips.org>
References: <1109157737.16445.6.camel@localhost.localdomain> <000301c5199d$3154ad40$0300a8c0@Exterity.local> <1109160313.16445.20.camel@localhost.localdomain> <cb80abe539fa80effd786cacc1340de7@embeddededge.com> <20050223150617.GA18290@linux-mips.org> <b230ff2324d488cc6e240cee05ca3af0@embeddededge.com> <20050304202338.GA14128@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7f99ffacb17cd1e961c026057fb89571@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	JP Foster <jp.foster@exterity.co.uk>, linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: Big Endian au1550
Date:	Fri, 4 Mar 2005 12:44:26 -0800
To:	Ralf Baechle <ralf@linux-mips.org>
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Mar 4, 2005, at 12:23 PM, Ralf Baechle wrote:

> Okay.  I don't know which of the Alchemy systems are capable of 
> supporting
> big endian at all -

They all will.

>  some might not due to unavailable firmware for example.

Well, you can (and I have) changed the mode when booting the
kernel from what the boot rom initialized.  It's not pretty, but it 
works.

> So I guess I'll leave cooking a patch to you or Pete.

OK.


	-- Dan
