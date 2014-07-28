Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 00:14:05 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:37897 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861007AbaG1WAP2hOO7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jul 2014 00:00:15 +0200
Received: from [IPv6:2001:470:7259:0:9dcd:2485:6d06:4d01] (unknown [IPv6:2001:470:7259:0:9dcd:2485:6d06:4d01])
        by test.hauke-m.de (Postfix) with ESMTPSA id B21C72000B;
        Mon, 28 Jul 2014 23:52:16 +0200 (CEST)
Message-ID: <53D6C60F.3060509@hauke-m.de>
Date:   Mon, 28 Jul 2014 23:52:15 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: BCM47XX: Detect more then 128 MiB of RAM (HIGHMEM)
References: <1405632393-17960-1-git-send-email-zajec5@gmail.com> <1405632393-17960-2-git-send-email-zajec5@gmail.com> <53D6BA7A.5050903@hauke-m.de>
In-Reply-To: <53D6BA7A.5050903@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 07/28/2014 11:02 PM, Hauke Mehrtens wrote:
> On 07/17/2014 11:26 PM, Rafał Miłecki wrote:
>> So far BCM47XX can only detect amount of HIGHMEM. It still requires
>> adding (registering) and well-testing before enabling by default.
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>> Changes since RFC:
>> 1) Use pgtable-32.h instead of ugly "extern" in .c file
>> 2) Make it clear it needs work & testing before enabling
> 
> NACK
> 
> I tested this on my ASUS RT-66U with 256 MB ram and it panics. These
> patches are looking similar to the code the Broadcom SDK, but I do not
> know where the error is.
> 
> 
Sorry this was wrong, I assumed this was the same version as the one I
got privately. highmem still does not work, because the memory does not
get registered, but it does not panic any more.

For this patch:
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>


Here is a log output:

[    0.000000] Linux version 3.16.0-rc7+ (hauke@hauke-desktop) (gcc
version 4.8.3 (OpenWrt/Linaro GCC 4.8-2014.04 r41527) ) #369 Mon Jul 28
23:48:54 CEST 2014
[    0.000000] CPU0 revision is: 00019749 (MIPS 74Kc)
[    0.000000] bcm47xx: using bcma bus
[    0.000000] bcma: bus0: Found chip with id 0x5300, rev 0x01 and
package 0x00
[    0.000000] bcma: bus0: Core 0 found: BCM4706 ChipCommon (manuf
0x4BF, id 0x500, rev 0x1F, class 0x0)
[    0.000000] bcma: bus0: Core 3 found: MIPS 74K (manuf 0x4A7, id
0x82C, rev 0x00, class 0x0)
[    0.000000] bcma: bus0: Early bus registered
[    0.000000] Found 128 MiB of extra memory, but highmem is unsupported
yet!
[    0.000000] MIPS: machine is Asus RT-N66U
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 07fff000 @ 00000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x07ffefff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x07ffefff]
