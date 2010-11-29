Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2010 11:25:06 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:35855 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492485Ab0K2KZD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Nov 2010 11:25:03 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id oATAOqjX013911;
        Mon, 29 Nov 2010 02:24:52 -0800 (PST)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Mon, 29 Nov 2010 02:24:51 -0800
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Mon, 29 Nov 2010 11:24:48 +0100
Message-ID: <4CF37F5D.9070709@windriver.com>
Date:   Mon, 29 Nov 2010 18:24:29 +0800
From:   "tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
MIME-Version: 1.0
To:     Wolfgang Grandegger <wg@grandegger.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Can't read from mmaped PCI memory space
References: <4CF2C7B1.5030007@grandegger.com>
In-Reply-To: <4CF2C7B1.5030007@grandegger.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2010 10:24:49.0187 (UTC) FILETIME=[A6DEF730:01CB8FAF]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

Wolfgang Grandegger wrote:
> Hello,
> 
> I'm trying to read from mmapped PCI memory space on an alchemy board,
> but I can't get it to work. Here's the lspci output of the PCI card:
> 
>   bash-3.00# lspci -v
>   00:00.0 Class 0200: 168c:001b (rev 01)
> 	Subsystem: 168c:2063
> 	Flags: bus master, medium devsel, latency 168, IRQ 9
> 	Memory at 0000000040000000 (32-bit, non-prefetchable) [size=64K]
> 	Capabilities: [44] Power Management version 2
> 
> I used mmap on "/dev/mem" and "/sys/bus/pci/.../resource0", but I do not
> read the expected values using "*(volatile u32 *)mmap_addr" from that
> region. The value also changes from read to read. Reading from kernel
> space just work fine. Am I doing something illegal? Any idea why it does
> not work?

Form here I'm not sure how you did exactly.

Theoretically, you can mmap() directly that at least from the sys resource. But
I think you have to notice the aligning requirement for a page. I means you
should firstly map one given base_address & ~(PAGE_SIZE - 1). Then access the
last destination address with adding the corresponding offset as you want.

Hope its useful.

Tiejun

> 
> TIA,
> 
> Wolfgang.
> 
> 
