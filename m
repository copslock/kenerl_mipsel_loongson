Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 22:18:19 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:56416 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823690Ab3EOURokZzBH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 22:17:44 +0200
Received: by mail-oa0-f53.google.com with SMTP id g12so2778818oah.12
        for <multiple recipients>; Wed, 15 May 2013 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=c0CKRE7D2iqpcBAOCTGwyCXwxqt4FIJypuzswkSHGRo=;
        b=LcYN9IqDybKg7H4G5ZrKkHGCaA37NqcT4tXVqHp21O0gOzMUYJL2stPHWwTOAXKHbg
         PP+Z4kYhkuXguiKSsum60H7hnzbL5Yme+5P0ucj2wGTZSNcUlcP12MCMIpGzNn8fsWnw
         RirthWR1A2C9/rgwMfvMjl9FjizjlGaig446lFCuA2/oiEItBHdUzz33I6HAlG2Kp/0F
         EswecOliTKfG2hgXo7QXnBlf99QaY+1s/Yr8+WcTgzTq+AVSpkzN8C7VvlOfVzrSUjdl
         QVXsHPm9SdBxS76mqBze/Zmojk+XK53VC7fM8Q1U4pPkyiV0w9MxISXT1/ibJ5yKllIT
         i6jA==
X-Received: by 10.60.96.105 with SMTP id dr9mr20085704oeb.59.1368649049456;
        Wed, 15 May 2013 13:17:29 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id b5sm1814811oby.12.2013.05.15.13.17.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 13:17:28 -0700 (PDT)
Message-ID: <5193ED56.3040602@gmail.com>
Date:   Wed, 15 May 2013 13:17:26 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 3.10-rc1 MIPS regression: Lemote mini-PC boot hangs
References: <20130515194805.GA14202@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130515194805.GA14202@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36412
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

On 05/15/2013 12:48 PM, Aaro Koskinen wrote:
> Hi,
>
> Lemote mini-PC boot hangs always with 3.10-rc1, the only console
> output is:
>
> [    0.000000] Linux version 3.10.0-rc1-lemote+ (aaro@blackmetal) (gcc version 4
> .8.0 (GCC) ) #2 PREEMPT Wed May 15 22:31:32 EEST 2013
> [    0.000000] busclock=66000000, cpuclock=797780000, memsize=256, highmemsize=2
> 56
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU revision is: 00006303 (ICT Loongson-2)
> [    0.000000] FPU revision is: 00000501
> [    0.000000] Checking for the multiply/shift bug... no.
> [    0.000000] Checking for the daddiu bug... no.
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 0000000010000000 @ 0000000000000000 (usable)
> [    0.000000]  memory: 0000000030000000 @ 0000000010000000 (reserved)
> [    0.000000]  memory: 0000000010000000 @ 0000000090000000 (usable)
> [    0.000000]  memory: 0000000010000000 @ 0000000080000000 (reserved)
> [    0.000000] debug: skip boot console de-registration.
> [    0.000000] Initrd not found or empty - disabling initrd
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x00000000-0x9fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00000000-0x3fffffff]
> [    0.000000]   node   0: [mem 0x80000000-0x9fffffff]
> [    0.000000] On node 0 totalpages: 98304
> [    0.000000]   Normal zone: 336 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 98304 pages, LIFO batch:7
> [    0.000000] Reserving 0MB of memory at 0MB for crashkernel
> [    0.000000] Primary instruction cache 64kB, VIPT, direct mapped, linesize 32 bytes.
> [    0.000000] Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 32 bytes
> [    0.000000] Unified secondary cache 512kB 4-way, linesize 32 bytes.
> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> [    0.000000] pcpu-alloc: [0] 0
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 97968
> [    0.000000] Kernel command line: console=tty console=ttyS0,115200 keep_bootcon=1 initcall_debug=1 loglevel=9
> [    0.000000] PID hash table entries: 4096 (order: 1, 32768 bytes)
> [    0.000000] Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)
> [    0.000000] Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)
>
> On the VGA console there is a register dump, with following (manually copied):
>
> [...]
>
> Exception Cause=address error on load or ifetch, SB=0x140000e2, PC=807273d0
>
> [...]
>
> System.map shows:
>
> ffffffff807261f8 T build_copy_page
> ffffffff80727390 t insn_fixup
> ffffffff80727430 t setup_asid
>
> Any suggestions what to try next?

http://www.linux-mips.org/archives/linux-mips/2013-05/msg00096.html

Specifically, the dynamic ASID sizing is broken.  You should be able to 
boot if you revert that bit.

David Daney

>
> This is plain 3.10-rc1 + "MIPS: loongson: fix random early boot hang" applied,
> config below.
>
> Thanks,
>
> A.
>
