Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2016 02:19:47 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:61680 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013027AbcBTBTpXH3zy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Feb 2016 02:19:45 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u1K1JYNZ007919
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 19 Feb 2016 17:19:34 -0800 (PST)
Received: from [147.11.216.197] (147.11.216.197) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.248.2; Fri, 19 Feb 2016
 17:19:33 -0800
Subject: Re: 4.5-rc4 kernel is failed to bootup on CN6880
To:     David Daney <ddaney@caviumnetworks.com>
References: <56C7BD89.2040800@windriver.com>
 <56C7BE3F.7030906@caviumnetworks.com>
CC:     <david.daney@cavium.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
From:   Yang Shi <yang.shi@windriver.com>
Message-ID: <56C7BF26.3040208@windriver.com>
Date:   Fri, 19 Feb 2016 17:19:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <56C7BE3F.7030906@caviumnetworks.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 2/19/2016 5:15 PM, David Daney wrote:
> On 02/19/2016 05:12 PM, Yang Shi wrote:
>> Hi David,
>>
>> I tried to boot 4.5-rc4 kernel on my CN6880 board, but it is failed at
>> booting up secondary cores. The error is:
>
> Have you had luck with any other kernel.org versions?

Not tried yet. I will try to bisect it.

>
> FWIW, I recently posed some patches that may help.  I haven't recently 
> tested on cn68xx though, so I can't really say what it might be.

Do you mean the change in CN78xx support patchset?

Thanks,
Yang

>
>
>>
>> CPU31 revision is: 000d9101 (Cavium Octeon II)
>> SMP: Booting CPU32 (CoreId 32)...
>> Secondary boot timeout
>>
>> I passed "numcores=32" in kernel commandline since there are 32 cores
>> ion CN6880. And, the bootloader information is as below:
>>
>> U-Boot 2013.07 ( (U-BOOT build: 104, SDK version: 3.1.1-544),
>> svnversion: u-boot:107133M, exec:)-svn107117 (Build time: Oct 31 2014 -
>> 19:39:37)
>>
>> Skipping PCIe port 0 BIST, reset not done. (port not configured)
>> Skipping PCIe port 1 BIST, reset not done. (port not configured)
>> BIST check passed.
>> EBB6800 board revision major:2, minor:0, serial #: 2011-2.0-00120
>> OCTEON CN6880-AAP pass 1.1, Core clock: 1200 MHz, IO clock: 800 MHz, DDR
>> clock: 667 MHz (1334 Mhz DDR)
>> Base DRAM address used by u-boot: 0x20f000000, size: 0x1000000
>> DRAM: 8 GiB
>> Clearing DRAM...... done
>> NAND:  4096 MiB
>> Registered IDE device 0 from IDE bus:dev 0:0
>> Flash: 8 MiB
>> 0:PCIe: Port 0 is unknown, skipping.
>> 0:PCIe: Port 1 is unknown, skipping.
>> PCI console init succeeded, 1 consoles, 1024 bytes each
>> Net:   octmgmt0, octeth0, octeth1, octeth2, octeth3
>> Bus 0: OK
>>    Device 0: Model: CF 1GB Firm: 20071116 Ser#: TSS20037110113081057
>>              Type: Hard Disk
>>              Capacity: 967.6 MB = 0.9 GB (1981728 x 512)
>> USB0:   USB EHCI 1.00
>> scanning bus 0 for devices... 1 USB Device(s) found
>> Type the command 'usb start' to scan for USB storage devices.
>>
>>
>> Any hint is appreciated.
>>
>> Thanks,
>> Yang
>>
>
>
