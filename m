Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 14:43:04 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:56589 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225311AbUJNNm6>; Thu, 14 Oct 2004 14:42:58 +0100
Received: from [192.168.2.27] (x1000-57.tellink.net [63.161.110.249])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id i9EDZkb0028399;
	Thu, 14 Oct 2004 09:35:47 -0400
In-Reply-To: <20041014115304.3edbe141.toch@dfpost.ru>
References: <20041014115304.3edbe141.toch@dfpost.ru>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <447121BB-1DE7-11D9-8FE5-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Strange instruction
Date: Thu, 14 Oct 2004 09:45:10 -0400
To: Dmitriy Tochansky <toch@dfpost.ru>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Oct 14, 2004, at 7:53 AM, Dmitriy Tochansky wrote:

> Hello!
>
> When starts kernel for my au1500 board reseting board. After 
> disassembling I found instruction
> which reseting board. Here is few strings of "mipsel-linux-objdump -D 
> vmlinux" output:
>
> ---
>
> a0000650:       07400003        bltz    k0,a0000660 <nmi_handler+0x1c>
> a0000654:       03a0d82d        0x3a0d82d
> a0000658:       3c1ba020        lui     k1,0xa020

The Au1xxx is schizophrenic about the way it handles endianness.
The core starts up big endian mode, the bus interface depends upon
configuration options.  When you want to run the processor in
little endian mode (as is the case with this board), there are still
times during initialization that it is running big endian.  For these 
code
sequences, the instructions have to be byte swapped because the
bus interface is running little endian.  You are also using little 
endian
tools, so you will have to also byte swap these before disassembly
to get the proper instructions.


	-- Dan
