Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 02:09:14 +0100 (CET)
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:40177 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009415AbaKDBJMezxXP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 02:09:12 +0100
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-09v.sys.comcast.net with comcast
        id BD8k1p0065BUCh401D95Mw; Tue, 04 Nov 2014 01:09:05 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-po-16v.sys.comcast.net with comcast
        id BD931p00J3aNLgd01D94vn; Tue, 04 Nov 2014 01:09:05 +0000
Message-ID: <5458272A.7050309@gentoo.org>
Date:   Mon, 03 Nov 2014 20:08:58 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com>
In-Reply-To: <5457CF0A.7020303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415063345;
        bh=9TosW1OuJYgoTsoi+GjYcuPt0ERXcahdI9XCsHtt5JU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=UfQwKrtzykTzbBdOyT/43RDoDaxn9t90VpOS0n0yxwkdbI4kSwuR5nZJkAoGDbFLU
         SIZC/oRZUwRqAcZ1VuEbxHSKMPn/y+ljrzBWVj4/sfUjoTLsvPI1VZlMLaLWHATHs9
         G3JA8NSmBPzYv5lc1Ea1ub08j6jme76HOYaBexjoCMQYoCqQ7I2nNS1HbCG1FoyWfk
         rFzoB/qSYnWkLIXCKJ1FrpMrdI8ipXQzwewfBcpT8mOD7TUCJgXo86zr90k9WW3MDr
         ymxWDgZr0XFzCQ3U/BWGtShBZ8WoUg+21KeqFtqe3F2bv+AU71NRNpuW/pE0Im9CaS
         /FlIkdNh7M3Wg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 11/03/2014 13:52, David Daney wrote:
> On 11/02/2014 02:53 AM, Joshua Kinard wrote:
>>
>> So I have been testing the Onyx2 I have out the last few days with the IOC3
>> metadriver used on Octane, and I can get it to boot, but if
>> CONFIG_TRANSPARENT_HUGEPAGE is enabled in the kernel, bus errors can happen.
>>
>> If I use CONFIG_PAGE_SIZE_4KB, I get bus errors rather frequently -- running
>> Gentoo's 'emerge' command  can produce one.  Switch to CONFIG_PAGE_SIZE_16KB,
>> and the bus errors are far less frequent.  I suspect CONFIG_PAGE_SIZE_64KB will
>> be even less.
>>
>> Disable CONFIG_TRANSPARENT_HUGEPAGE, and the machine works pretty good.  It's
>> been up for almost 8 hours compiling, and not a single bus error yet.  It's got
>> 2x node board with dual R12K/400MHz CPUs per node.
>>
>> I'm not really sure what CONFIG_TRANSPARENT_HUGEPAGE is enabling that's causing
>> R12K CPUs on the IP27 such a headache (and on Octane, really screws up R14K
>> CPUs).  I tried getting a core dump on one of the bus errors, but that
>> produces a
>> truncated or corrupted core file that actually crashed GDB, plus I get a nice
>> oops message in dmesg:
> 
> Well, as its name implies, if you enable CONFIG_TRANSPARENT_HUGEPAGE, huge
> pages will be created and used in the background transparently to the userspace
> application.
> 
> With 4KB base page size, the huge pages will be 2MB in size..  I don't know
> much about the R10K/R12K/R14K CPUs, but it is possible that either their TLBs
> cannot handle such pages, or that the TLB Exception handlers don't contain
> proper code for these CPUs.
> 
> For each doubling of the base PAGE_SIZE, the huge page size will increase by a
> factor of 4.  So with 16KB base pages the huge page size would be 32MB, since
> there are many fewer opportunities to transparently use a 32MB page, I would
> expect any errors related to huge pages to be correspondingly less frequent.
> 
> With 64KB PAGE_SIZE the huge page size is 512MB, and It is likely that that
> could never be used by normal userspace programs.

I checked the R10K/R12K manual, and the PageMask register there has bits 24:13
open for setting a mask value.  It looks like these CPUs only support a page
size from 4KB to 16MB (so a 2MB page size should work w/ transparent
hugepages).  I assume that the R14K on the Octane might be the same (but I
don't have a manual specific to the R14k, so I don't know).  All of the
remaining bits in that register read 0 and must have 0's written back.

I guess I could find a way to have the kernel trigger a non-fatal oops/dump the
registers on a bus error and get a look at the cause register to see if that
sheds any light on things.  Doesn't a SIGBUS on MIPS typically mean that an
address wasn't aligned on a 32-bit boundary?  Or could it also mean other things?

I believe that the R10K is largely compatible with the R4K-style TLB setup, but
Ralf or someone else more knowledge in that area will have to verify.  Maybe
the R10k-family CPUs need their own TLB routines, or what currently exists
needs modifications?  I have not tried to understand the whole TLB thing in
MIPS yet, so that's a bit of voodoo to me.

--J



>> [ 1302.260000] CPU: 0 PID: 1179 Comm: emerge Not tainted
>> 3.17.1-mipsgit-20141006 #57
>> [ 1302.260000] task: a8000000ffbbf288 ti: a8000000fa6f0000 task.ti:
>> a8000000fa6f0000
>> [ 1302.260000] $ 0   : 0000000000000000 0000000000000001 0000000000000000
>> a8000000ff5ad800
>> [ 1302.260000] $ 4   : a8000000006d5480 00000000000f9c00 00000001f380173f
>> a800000001000000
>> [ 1302.260000] $ 8   : 00000001f380173f 0000000000100077 a8000000fe77a000
>> 0000000000000000
>> [ 1302.260000] $12   : 0000000000660000 0000000000000000 0000000000000000
>> 776bc40c00000004
>> [ 1302.260000] $16   : 0000000000e00000 0000000000000000 00000000018ee000
>> 6db6db6db6db6db7
>> [ 1302.260000] $20   : 00000000000000ca a8000000006d5480 a8000000ff65fa68
>> 0000000000001000
>> [ 1302.260000] $24   : 0000000000000000 a8000000000469c0
>> [ 1302.260000] $28   : a8000000fa6f0000 a8000000fa6f3a00 0000000000e00000
>> a800000000046720
>> [ 1302.260000] Hi    : 00000000002ed400
>> [ 1302.260000] Lo    : 00000000000f9c00
>> [ 1302.260000] epc   : a8000000000467e4 r4k_flush_cache_page+0x104/0x2e0
>> [ 1302.260000]     Not tainted
>> [ 1302.260000] ra    : a800000000046720 r4k_flush_cache_page+0x40/0x2e0
>> [ 1302.260000] Status: 90001ce3 KX SX UX KERNEL EXL IE
>> [ 1302.260000] Cause : 0000c010
>> [ 1302.260000] BadVA : 00000001f380173f
>> [ 1302.260000] PrId  : 00000e35 (R12000)
>> [ 1302.260000] Process emerge (pid: 1179, threadinfo=a8000000fa6f0000,
>> task=a8000000ffbbf288, tls=00000000778d2490)
>> [ 1302.260000] Stack : a8000000ff65fa68 0000000000e00000 00000000000f9c00
>> a8000000006d5480
>>            a8000000ff65fa68 0000000000001000 0000000000e00000 a80000000010cb00
>>            a8000000046a2000 a8000000ff65fa68 00000000018ee000 6db6db6db6db6db7
>>            a8000000fe7fdce0 a8000000000375ec a8000000ff4e5800 a8000000005fbd90
>>            0000000300000080 a8000000ff668580 a8000000005fbd90 5349474900000080
>>            a8000000fa6f3ad8 a8000000005fbd90 0000000600000088 a8000000ff5ad928
>>            a8000000005fbd90 46494c4500002bf9 c000000000101000 0000000a00000080
>>            0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>            0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>            0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>            ...
>> [ 1302.260000] Call Trace:
>> [ 1302.260000] [<a8000000000467e4>] r4k_flush_cache_page+0x104/0x2e0
>> [ 1302.260000] [<a80000000010cb00>] get_dump_page+0xc8/0xe8
>> [ 1302.260000] [<a8000000000375ec>] elf_core_dump+0x1294/0x14d8
>> [ 1302.260000] [<a8000000001b41e4>] do_coredump+0x5e4/0x1048
>> [ 1302.260000] [<a80000000005c0b8>] get_signal+0x1b8/0x710
>> [ 1302.260000] [<a8000000000299c0>] do_signal+0x18/0x240
>> [ 1302.260000] [<a80000000002a4c8>] do_notify_resume+0x70/0x88
>> [ 1302.260000] [<a8000000000255ac>] work_notifysig+0x10/0x18
>> [ 1302.260000]
>> [ 1302.260000]
>> Code: 0010327a  30c60ff8  00c8302d <dcc60000> 30c80001  1100003e  00000000 
>> bfb40000  df880000
>> [ 1305.340000] ---[ end trace c7649a6433db8d18 ]---
>>
>> Thoughts?



-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
