Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Dec 2013 19:21:10 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60642 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816383Ab3LASVHvH1MU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Dec 2013 19:21:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D683885EA;
        Sun,  1 Dec 2013 19:21:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ME08rcpl1wDF; Sun,  1 Dec 2013 19:20:53 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:95dd:7b48:3a72:d5e1] (unknown [IPv6:2001:470:1f0b:447:95dd:7b48:3a72:d5e1])
        by hauke-m.de (Postfix) with ESMTPSA id 42062857F;
        Sun,  1 Dec 2013 19:20:52 +0100 (CET)
Message-ID: <529B7E02.2040208@hauke-m.de>
Date:   Sun, 01 Dec 2013 19:20:50 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Ungerer <gerg@snapgear.com>,
        Ashok Kumar <ashoks@broadcom.com>
CC:     linux-mips@linux-mips.org
Subject: Re: MIPS: 3.13-rc1 regression: initrd/cramfs broken
References: <20131124110518.GA24645@blackmetal.musicnaut.iki.fi> <20131130215942.GB30823@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20131130215942.GB30823@blackmetal.musicnaut.iki.fi>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38621
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

On 11/30/2013 10:59 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Nov 24, 2013 at 01:05:18PM +0200, Aaro Koskinen wrote:
>> With 3.13-rc1 the boot hangs early when initrd/cramfs is used. I bisected
>> this to commit f9a7febd82f413b9c8bafd40145bc398b7eb619f (MIPS: Fix start
>> of free memory when using initrd).
>>
>> I'm loading cramfs initrd on my WRT54GL router (16 MB memory) to
>> 0x80400000. The kernel command line is:
>> console=ttyS0,115200 rd_start=0x80400000 rd_size=5181440 root=/dev/ram init=/init
>>
>> With 3.13-rc1 it hangs with below output. With the above commit reverted,
>> the board boots fine.
>>
>> Starting program at 0x80231cb0
>> [    0.000000] Linux version 3.13.0-rc1-wrt54gl-los.git-6e483b8-dirty (aaro@blackmetal) (gcc version 4.8.2 (GCC) ) #13 Sun Nov 24 12:54:47 EET 2013
>> [    0.000000] bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 00029008 (Broadcom BMIPS3300)
>> [    0.000000] bcm47xx: using ssb bus
>> [    0.000000] ssb: Found chip with id 0x5352, rev 0x00 and package 0x02
>> [    0.000000] ssb: Sonics Silicon Backplane found at address 0x18000000
>> [    0.000000] Determined physical RAM map:
>> [    0.000000]  memory: 01000000 @ 00000000 (usable)
>> [    0.000000] Initial ramdisk at: 0x80400000 (5181440 bytes)
>> [    0.000000] Zone ranges:
>> [    0.000000]   Normal   [mem 0x00000000-0x00ffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x00000000-0x00ffffff]
>> [    0.000000] Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
>> [    0.000000] Primary data cache 8kB, 2-way, VIPT, no aliases, linesize 16 bytes
> 
> It seems the commit itself is OK, but it just exposes some limitation or
> "feature" when running Linux on WRT54GL. It seems some areas of memory
> cannot be used by Linux.
> 
> The hang seems to happen in memset() called by alloc_bootmem_bdata(). It's
> trying to zero 8 pages starting from address 0x80301000. This seems to
> be perfectly valid and I have no idea why it hangs, but this area seems
> to be used by CFE code earlier during the boot:
> 
> 	Total memory: 16384 KBytes
> 
> 	Total memory used by CFE:  0x80300000 - 0x803A39B0 (670128)
> 
> Kernel works if I blacklist this area using command line:
> 
> 	mem=3M@0 mem=12M@0x400000
> 
> 	[...]
> 
> 	[    0.000000] Determined physical RAM map:
> 	[    0.000000]  memory: 01000000 @ 00000000 (usable)
> 	[    0.000000] User-defined physical RAM map:
> 	[    0.000000]  memory: 00300000 @ 00000000 (usable)
> 	[    0.000000]  memory: 00c00000 @ 00400000 (usable)
> 	[    0.000000] Initial ramdisk at: 0x80400000 (5181440 bytes)
> 
> And the rest of the boot is now fine.
> 
> A.

kernel 3.13 uses CFE for early printks and the kernel use CFE's memory.
I send patches to remove usage of CFE for the boot console some time ago.

Please thy these patches:
https://patchwork.linux-mips.org/patch/5888/
https://patchwork.linux-mips.org/patch/5889/

Hauke
