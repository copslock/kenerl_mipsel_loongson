Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2010 14:22:09 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:58829 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492511Ab0K2NWG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Nov 2010 14:22:06 +0100
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 857E11853BAA;
        Mon, 29 Nov 2010 14:22:04 +0100 (CET)
X-Auth-Info: bKQfVZHbmPSsK7jzO11mX0yKQmgwW0wv7vFFhxn0ncU=
Received: from lancy.mylan.de (p4FF0477D.dip.t-dialin.net [79.240.71.125])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 494381C000EB;
        Mon, 29 Nov 2010 14:22:04 +0100 (CET)
Message-ID: <4CF3A94B.6010407@grandegger.com>
Date:   Mon, 29 Nov 2010 14:23:23 +0100
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "tiejun.chen" <tiejun.chen@windriver.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Can't read from mmaped PCI memory space
References: <4CF2C7B1.5030007@grandegger.com> <4CF37F5D.9070709@windriver.com>
In-Reply-To: <4CF37F5D.9070709@windriver.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

On 11/29/2010 11:24 AM, tiejun.chen wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I'm trying to read from mmapped PCI memory space on an alchemy board,
>> but I can't get it to work. Here's the lspci output of the PCI card:
>>
>>   bash-3.00# lspci -v
>>   00:00.0 Class 0200: 168c:001b (rev 01)
>> 	Subsystem: 168c:2063
>> 	Flags: bus master, medium devsel, latency 168, IRQ 9
>> 	Memory at 0000000040000000 (32-bit, non-prefetchable) [size=64K]
>> 	Capabilities: [44] Power Management version 2
>>
>> I used mmap on "/dev/mem" and "/sys/bus/pci/.../resource0", but I do not
>> read the expected values using "*(volatile u32 *)mmap_addr" from that
>> region. The value also changes from read to read. Reading from kernel
>> space just work fine. Am I doing something illegal? Any idea why it does
>> not work?
> 
> Form here I'm not sure how you did exactly.
> 
> Theoretically, you can mmap() directly that at least from the sys resource. But
> I think you have to notice the aligning requirement for a page. I means you
> should firstly map one given base_address & ~(PAGE_SIZE - 1). Then access the
> last destination address with adding the corresponding offset as you want.
> 
> Hope its useful.
> 
> Tiejun
> 
>>
>> TIA,
>>
>> Wolfgang.
>>
>>
> 
> 
> 
