Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 02:43:53 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46519 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009415AbaKDBnvf30-0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 02:43:51 +0100
Received: by mail-ie0-f169.google.com with SMTP id tr6so6682791ieb.28
        for <linux-mips@linux-mips.org>; Mon, 03 Nov 2014 17:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=32HUgEadl1ExbEeKLgC5izeA8yAUD6G7SEjj/nRJzoc=;
        b=eWRYVAQpUvgrUV2LF6Uu+Lne+3B3tDp0PcrgBmaYbamuKhq91EqwBM8oszlVYSuA17
         BXYU7o1SwNBvA48vX+lQi+WNtod9tDhlEdd14eim/ZL2sl5foowwIhGhnYfeuONF1XOG
         kMBeZhxGUZ/erz4O4AmUF8h4dgOgWAdvcBwKSrHj2oO6z/Jga6hMw/AK0qW60FYd1Xwe
         LSA2dOPfA6N3ooXolaSCuWUIoWqyGiIZJ/beq82sp3Oq7Vod5mKZbZTAq8k+sJopru4n
         6QhtTLPfjJsFVxcFq40C2o3i467c6YmIqHBuWcD9ya3gpLK2GLPdfs6B7/05hjAzZgDy
         mOdQ==
X-Received: by 10.107.131.136 with SMTP id n8mr49987138ioi.34.1415065425610;
        Mon, 03 Nov 2014 17:43:45 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id g70sm2710142ioe.18.2014.11.03.17.43.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 17:43:45 -0800 (PST)
Message-ID: <54582F50.5010202@gmail.com>
Date:   Mon, 03 Nov 2014 17:43:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>
CC:     linux-mips@linux-mips.org
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <54582D1B.9060502@gentoo.org>
In-Reply-To: <54582D1B.9060502@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 11/03/2014 05:34 PM, Joshua Kinard wrote:
> On 11/03/2014 20:23, David Daney wrote:
>> On 11/03/2014 05:08 PM, Joshua Kinard wrote:
>>> On 11/03/2014 13:52, David Daney wrote:
>>>> On 11/02/2014 02:53 AM, Joshua Kinard wrote:
>>>>>
>>>>> So I have been testing the Onyx2 I have out the last few days with the IOC3
>>>>> metadriver used on Octane, and I can get it to boot, but if
>>>>> CONFIG_TRANSPARENT_HUGEPAGE is enabled in the kernel, bus errors can happen.
>>>>>
>>>>> If I use CONFIG_PAGE_SIZE_4KB, I get bus errors rather frequently -- running
>>>>> Gentoo's 'emerge' command  can produce one.  Switch to CONFIG_PAGE_SIZE_16KB,
>>>>> and the bus errors are far less frequent.  I suspect CONFIG_PAGE_SIZE_64KB
>>>>> will
>>>>> be even less.
>>>>>
>>>>> Disable CONFIG_TRANSPARENT_HUGEPAGE, and the machine works pretty good.  It's
>>>>> been up for almost 8 hours compiling, and not a single bus error yet.  It's
>>>>> got
>>>>> 2x node board with dual R12K/400MHz CPUs per node.
>>>>>
>>>>> I'm not really sure what CONFIG_TRANSPARENT_HUGEPAGE is enabling that's
>>>>> causing
>>>>> R12K CPUs on the IP27 such a headache (and on Octane, really screws up R14K
>>>>> CPUs).  I tried getting a core dump on one of the bus errors, but that
>>>>> produces a
>>>>> truncated or corrupted core file that actually crashed GDB, plus I get a nice
>>>>> oops message in dmesg:
>>>>
>>>> Well, as its name implies, if you enable CONFIG_TRANSPARENT_HUGEPAGE, huge
>>>> pages will be created and used in the background transparently to the userspace
>>>> application.
>>>>
>>>> With 4KB base page size, the huge pages will be 2MB in size..  I don't know
>>>> much about the R10K/R12K/R14K CPUs, but it is possible that either their TLBs
>>>> cannot handle such pages, or that the TLB Exception handlers don't contain
>>>> proper code for these CPUs.
>>>>
>>>> For each doubling of the base PAGE_SIZE, the huge page size will increase by a
>>>> factor of 4.  So with 16KB base pages the huge page size would be 32MB, since
>>>> there are many fewer opportunities to transparently use a 32MB page, I would
>>>> expect any errors related to huge pages to be correspondingly less frequent.
>>>>
>>>> With 64KB PAGE_SIZE the huge page size is 512MB, and It is likely that that
>>>> could never be used by normal userspace programs.
>>>
>>> I checked the R10K/R12K manual, and the PageMask register there has bits 24:13
>>> open for setting a mask value.  It looks like these CPUs only support a page
>>> size from 4KB to 16MB (so a 2MB page size should work w/ transparent
>>> hugepages).  I assume that the R14K on the Octane might be the same (but I
>>> don't have a manual specific to the R14k, so I don't know).  All of the
>>> remaining bits in that register read 0 and must have 0's written back.
>>>
>>> I guess I could find a way to have the kernel trigger a non-fatal oops/dump the
>>> registers on a bus error and get a look at the cause register to see if that
>>> sheds any light on things.  Doesn't a SIGBUS on MIPS typically mean that an
>>> address wasn't aligned on a 32-bit boundary?  Or could it also mean other
>>> things?
>>>
>>> I believe that the R10K is largely compatible with the R4K-style TLB setup, but
>>> Ralf or someone else more knowledge in that area will have to verify.  Maybe
>>> the R10k-family CPUs need their own TLB routines, or what currently exists
>>> needs modifications?  I have not tried to understand the whole TLB thing in
>>> MIPS yet, so that's a bit of voodoo to me.
>>
>> I haven't checked, but there may be workarounds required in the TLB management
>> code that are not in place for the huge page case.  When the huge TLB code was
>> developed, we didn't do any testing on R10K.  Somebody should dump the
>> exception handlers and carefully look at the rest of the huge TLB management
>> code, and check to see that any required workarounds are in place.
>
> How does one dump the exception handlers?  Is it a debug switch somewhere?
>

Add as the very first line of tlbex.c "#define DEBUG 1"

Then rebuild, and pass "debug" on the kernel command line.

The output can be fed though gas, and then disassembled with objdump -d


> --J
>
>
>
>
>> David.
>>
>>
>>>
>>> --J
>>>
>>>
>>>
>>>>> [ 1302.260000] CPU: 0 PID: 1179 Comm: emerge Not tainted
>>>>> 3.17.1-mipsgit-20141006 #57
>>>>> [ 1302.260000] task: a8000000ffbbf288 ti: a8000000fa6f0000 task.ti:
>>>>> a8000000fa6f0000
>>>>> [ 1302.260000] $ 0   : 0000000000000000 0000000000000001 0000000000000000
>>>>> a8000000ff5ad800
>>>>> [ 1302.260000] $ 4   : a8000000006d5480 00000000000f9c00 00000001f380173f
>>>>> a800000001000000
>>>>> [ 1302.260000] $ 8   : 00000001f380173f 0000000000100077 a8000000fe77a000
>>>>> 0000000000000000
>>>>> [ 1302.260000] $12   : 0000000000660000 0000000000000000 0000000000000000
>>>>> 776bc40c00000004
>>>>> [ 1302.260000] $16   : 0000000000e00000 0000000000000000 00000000018ee000
>>>>> 6db6db6db6db6db7
>>>>> [ 1302.260000] $20   : 00000000000000ca a8000000006d5480 a8000000ff65fa68
>>>>> 0000000000001000
>>>>> [ 1302.260000] $24   : 0000000000000000 a8000000000469c0
>>>>> [ 1302.260000] $28   : a8000000fa6f0000 a8000000fa6f3a00 0000000000e00000
>>>>> a800000000046720
>>>>> [ 1302.260000] Hi    : 00000000002ed400
>>>>> [ 1302.260000] Lo    : 00000000000f9c00
>>>>> [ 1302.260000] epc   : a8000000000467e4 r4k_flush_cache_page+0x104/0x2e0
>>>>> [ 1302.260000]     Not tainted
>>>>> [ 1302.260000] ra    : a800000000046720 r4k_flush_cache_page+0x40/0x2e0
>>>>> [ 1302.260000] Status: 90001ce3 KX SX UX KERNEL EXL IE
>>>>> [ 1302.260000] Cause : 0000c010
>>>>> [ 1302.260000] BadVA : 00000001f380173f
>>>>> [ 1302.260000] PrId  : 00000e35 (R12000)
>>>>> [ 1302.260000] Process emerge (pid: 1179, threadinfo=a8000000fa6f0000,
>>>>> task=a8000000ffbbf288, tls=00000000778d2490)
>>>>> [ 1302.260000] Stack : a8000000ff65fa68 0000000000e00000 00000000000f9c00
>>>>> a8000000006d5480
>>>>>              a8000000ff65fa68 0000000000001000 0000000000e00000
>>>>> a80000000010cb00
>>>>>              a8000000046a2000 a8000000ff65fa68 00000000018ee000
>>>>> 6db6db6db6db6db7
>>>>>              a8000000fe7fdce0 a8000000000375ec a8000000ff4e5800
>>>>> a8000000005fbd90
>>>>>              0000000300000080 a8000000ff668580 a8000000005fbd90
>>>>> 5349474900000080
>>>>>              a8000000fa6f3ad8 a8000000005fbd90 0000000600000088
>>>>> a8000000ff5ad928
>>>>>              a8000000005fbd90 46494c4500002bf9 c000000000101000
>>>>> 0000000a00000080
>>>>>              0000000000000000 0000000000000000 0000000000000000
>>>>> 0000000000000000
>>>>>              0000000000000000 0000000000000000 0000000000000000
>>>>> 0000000000000000
>>>>>              0000000000000000 0000000000000000 0000000000000000
>>>>> 0000000000000000
>>>>>              ...
>>>>> [ 1302.260000] Call Trace:
>>>>> [ 1302.260000] [<a8000000000467e4>] r4k_flush_cache_page+0x104/0x2e0
>>>>> [ 1302.260000] [<a80000000010cb00>] get_dump_page+0xc8/0xe8
>>>>> [ 1302.260000] [<a8000000000375ec>] elf_core_dump+0x1294/0x14d8
>>>>> [ 1302.260000] [<a8000000001b41e4>] do_coredump+0x5e4/0x1048
>>>>> [ 1302.260000] [<a80000000005c0b8>] get_signal+0x1b8/0x710
>>>>> [ 1302.260000] [<a8000000000299c0>] do_signal+0x18/0x240
>>>>> [ 1302.260000] [<a80000000002a4c8>] do_notify_resume+0x70/0x88
>>>>> [ 1302.260000] [<a8000000000255ac>] work_notifysig+0x10/0x18
>>>>> [ 1302.260000]
>>>>> [ 1302.260000]
>>>>> Code: 0010327a  30c60ff8  00c8302d <dcc60000> 30c80001  1100003e  00000000
>>>>> bfb40000  df880000
>>>>> [ 1305.340000] ---[ end trace c7649a6433db8d18 ]---
>>>>>
>>>>> Thoughts?
>
>
>
