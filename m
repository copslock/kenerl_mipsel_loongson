Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Dec 2010 21:46:54 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:59852 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491773Ab0LMUqv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Dec 2010 21:46:51 +0100
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 262511C08DE6;
        Mon, 13 Dec 2010 21:46:44 +0100 (CET)
X-Auth-Info: kKA9cPkVHUvQcgLi2wAfJtIYiJFFVqTOnXofG0kYWN0=
Received: from lancy.mylan.de (p4FE67482.dip.t-dialin.net [79.230.116.130])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 8B8161C000B7;
        Mon, 13 Dec 2010 21:46:44 +0100 (CET)
Message-ID: <4D06868A.4000904@grandegger.com>
Date:   Mon, 13 Dec 2010 21:48:10 +0100
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "tiejun.chen" <tiejun.chen@windriver.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Can't read from mmaped PCI memory space
References: <4CF2C7B1.5030007@grandegger.com> <4CF37F5D.9070709@windriver.com> <4CF3A94B.6010407@grandegger.com> <4CF3AD82.3030100@grandegger.com>
In-Reply-To: <4CF3AD82.3030100@grandegger.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

On 11/29/2010 02:41 PM, Wolfgang Grandegger wrote:
> Hello,
> 
> I hit the send button too early, sorry...
> 
> On 11/29/2010 02:23 PM, Wolfgang Grandegger wrote:
>> On 11/29/2010 11:24 AM, tiejun.chen wrote:
>>> Wolfgang Grandegger wrote:
>>>> Hello,
>>>>
>>>> I'm trying to read from mmapped PCI memory space on an alchemy board,
>>>> but I can't get it to work. Here's the lspci output of the PCI card:
>>>>
>>>>   bash-3.00# lspci -v
>>>>   00:00.0 Class 0200: 168c:001b (rev 01)
>>>> 	Subsystem: 168c:2063
>>>> 	Flags: bus master, medium devsel, latency 168, IRQ 9
>>>> 	Memory at 0000000040000000 (32-bit, non-prefetchable) [size=64K]
>>>> 	Capabilities: [44] Power Management version 2
>>>>
>>>> I used mmap on "/dev/mem" and "/sys/bus/pci/.../resource0", but I do not
>>>> read the expected values using "*(volatile u32 *)mmap_addr" from that
>>>> region. The value also changes from read to read. Reading from kernel
>>>> space just work fine. Am I doing something illegal? Any idea why it does
>>>> not work?
>>>
>>> Form here I'm not sure how you did exactly.
>>>
>>> Theoretically, you can mmap() directly that at least from the sys resource. But
>>> I think you have to notice the aligning requirement for a page. I means you
>>> should firstly map one given base_address & ~(PAGE_SIZE - 1). Then access the
>>> last destination address with adding the corresponding offset as you want.
> 
> I'm aware of the alignment issue. Anyway, I'm mapping the above address,
> which is already aligned. It must be something else. I'm using the
> ath_info and devmem2 Program for testing.

It's an issue with 64-bit address mapping. Currently mmap tries to map
0x4000'0000 but the physical address of the PCI memory space on my CPU is
0x4'4000'0000. I wonder why this problem has not yet been discovered.
The attached patch below works for my board.

Wolfgang.
