Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 12:01:56 +0200 (CEST)
Received: from mail-bk0-f51.google.com ([209.85.214.51]:50133 "EHLO
        mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818476Ab3FSHT5E0BUe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 09:19:57 +0200
Received: by mail-bk0-f51.google.com with SMTP id ji1so2166558bkc.24
        for <multiple recipients>; Wed, 19 Jun 2013 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=AhDfLFMW8Ub9NwkPB8k2mA9ub9SowFWzP9fmtfQWMcs=;
        b=KgPJwkdrNbK+ILsNqePvXcOMG1j1ykrrdx57DjuTmtXtVQ2WToGALQlJaROVsIGpV5
         LaJbnVymye00N1ddwqRlpSyCNbUrsHB3t50fdoMDwNSWwbBlOkvVx7VkvYdi28KaVhNr
         xZ7Nu87hdDkD8mPCe52zMo/Q4K00TBaZX6pTQCqnsFN4DrfTIgNfy0hIWfUPupitELwL
         J94L/3E4tc6E2fVKB3SI9fLqIfO0Dv9u6VucjinqY9zmVB2KSLQVoMJ7wU2fUgyzDQuf
         wpOKD+nb2o25Z2LDOZCJRZ8Hl6GbALIcjEOctb0k1lui62iK+UuXZeJopDexw84h8OP+
         e5CQ==
MIME-Version: 1.0
X-Received: by 10.204.166.197 with SMTP id n5mr203111bky.102.1371626390638;
 Wed, 19 Jun 2013 00:19:50 -0700 (PDT)
Received: by 10.204.30.210 with HTTP; Wed, 19 Jun 2013 00:19:50 -0700 (PDT)
In-Reply-To: <CAAhV-H42-6W4gYLkAF=O6pAQv1VZymRLE0MxPbTCKGsEthJMMw@mail.gmail.com>
References: <CAAhV-H42-6W4gYLkAF=O6pAQv1VZymRLE0MxPbTCKGsEthJMMw@mail.gmail.com>
Date:   Wed, 19 Jun 2013 15:19:50 +0800
X-Google-Sender-Auth: QiiZUrdCbZ9yqoQjh9SuSr3ygXE
Message-ID: <CAAhV-H7MCEyrPjK6Onzgk7vKF8e+u_7u9rX7OE4CLRsjnUi8JA@mail.gmail.com>
Subject: Re: [RFD] Something wrong with commit "MIPS: Use inline function to
 access current thread pointer"?
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37196
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Seems like a compiler issue. When I upgrade my GCC-4.5.2 to GCC-4.6.0,
everything is OK.
Sorry for my noise.

Huacai Chen

On Mon, Jun 17, 2013 at 9:10 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Hi, ralf and all,
>
> I found that the latest upstream kernel has some problems on
> Loongson-3, I want to know whether other MIPS has similar problems.
>
> 1, When configure with SMP but no NUMA, it complaims "schedule while atomic":
> [    0.000000] allocated 2097152 bytes of page_cgroup
> [    0.000000] please try 'cgroup_disable=memory' option if you don't
> want memory cgroups
> [    0.023437] Calibrating delay loop... 717.28 BogoMIPS (lpj=1400832)
> [    0.054687] pid_max: default: 32768 minimum: 301
> [    0.058593] Mount-cache hash table entries: 1024
> [    0.062500] Initializing cgroup subsys memory
> [    0.066406] ------------[ cut here ]------------
> [    0.070312] WARNING: at lib/idr.c:423 idr_preload+0x5c/0x174()
> [    0.074218] Modules linked in:
> [    0.078125] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.10.0-rc6+ #1271
> [    0.082031] Stack : 0000000000000800 ffffffff80428ec4
> ffffffff8095fcb8 ffffffff8120d348
>           ffffffff81210000 ffffffff81210000 ffffffff808c7608 ffffffff809771f7
>           00000000000001a7 ffffffff808e30c0 00000000000000d0 0000000000000000
>           0000000000000000 0000000000000000 0000000000000000 ffffffff80759bc8
>           ffffffff8095fcb8 ffffffff8022b8e4 0000000000000000 ffffffff8022f17c
>           ffffffff80977660 ffffffff808c7608 0000000000000000 0000000000000000
>           ffffffff80977600 0000000000000000 0000000000000000 0000000000000000
>           0000000000000000 ffffffff8095fc10 0000000000000000 ffffffff8022b9dc
>           0000000000000000 0000000000000000 00000000000001a7 0000000000000009
>           ffffffff8041e0b4 ffffffff8020977c ffffffff808e30c0 ffffffff8022b9dc
>           ...
> [    0.152343] Call Trace:
> [    0.152343] [<ffffffff8020977c>] show_stack+0x48/0x70
> [    0.156250] [<ffffffff8022b9dc>] warn_slowpath_common+0x78/0xa4
> [    0.160156] [<ffffffff8041e0b4>] idr_preload+0x5c/0x174
> [    0.164062] [<ffffffff8028632c>] get_new_cssid+0x50/0xec
> [    0.167968] [<ffffffff80288788>] cgroup_init_idr+0x30/0x6c
> [    0.171875] [<ffffffff811c7954>] cgroup_init+0x90/0x1dc
> [    0.175781] [<ffffffff811bca40>] start_kernel+0x4f4/0x554
> [    0.179687]
> [    0.179687] ---[ end trace 554a547e6319cb64 ]---
> [    0.183593] Initializing cgroup subsys blkio
> [    0.187500] Checking for the daddi bug... no.
> [    0.191406] BUG: scheduling while atomic: swapper/0/0/0xffc60201
> [    0.195312] Modules linked in:
> [    0.195312] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> 3.10.0-rc6+ #1271
> [    0.199218] Stack : 0000000000000800 ffffffff80428ec4
> ffffffff8095fcc8 ffffffff8120d348
>           ffffffff81210000 ffffffff81210000 ffffffff808c7608 ffffffff809771f7
>           0000000000000001 ffffffff811c0000 0000000000000001 ffffffff808cc820
>           ffffffff811c0000 ffffffff811fa420 98000000059c6420 ffffffff80759bc8
>           ffffffff8095fcc8 ffffffff8022b85c 0000000000000000 ffffffff8022f17c
>           ffffffff80977660 ffffffff808c7608 0000000000000000 0000000000000000
>           ffffffff80977600 0000000000000000 0000000000000000 0000000000000000
>           0000000000000000 ffffffff8095fc20 0000000000000000 ffffffff80256010
>           0000000000000000 0000000000000000 000000001400cce3 ffffffff811fa420
>           ffffffff80972fe8 ffffffff8020977c ffffffff811c0000 ffffffff80256010
>           ...
> [    0.269531] Call Trace:
> [    0.269531] [<ffffffff8020977c>] show_stack+0x48/0x70
> [    0.273437] [<ffffffff80256010>] __schedule_bug+0x44/0x64
> [    0.277343] [<ffffffff8075b7d0>] __schedule+0xb8/0x6dc
> [    0.281250] [<ffffffff8075c248>] schedule_preempt_disabled+0x18/0x30
> [    0.285156] [<ffffffff80749e98>] rest_init+0x7c/0x8c
> [    0.289062] [<ffffffff811bca84>] start_kernel+0x538/0x554
>
> 2, when both SMP and NUMA configured, it complaims "early out of memory":
> [    0.000000] CPU revision is: 00006305 (ICT Loongson-3A)
> [    0.000000] FPU revision is: 00770501
> [    0.000000] Checking for the multiply/shift bug... no.
> [    0.000000] Checking for the daddiu bug... no.
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 000000000fe00000 @ 0000000000200000 (usable)
> [    0.000000]  memory: 0000000070000000 @ 0000000110000000 (usable)
> [    0.000000] Initrd not found or empty - disabling initrd
> [    0.000000] software IO TLB [mem 0x03a60000-0x07a60000] (64MB)
> mapped at [9800000003a60000-9800000007a5ffff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
> [    0.000000]   Normal   [mem 0x100000000-0x17fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x01000000-0x0fffffff]
> [    0.000000]   node   0: [mem 0x110000000-0x17fffffff]
> [    0.000000] Detected 3 available secondary CPU(s)
> [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
> [    0.000000] Primary data cache 64kB, 4-way, VIPT, no aliases,
> linesize 32 bytes
> [    0.000000] Unified secondary cache 4096kB 4-way, linesize 32 bytes.
> [    0.000000] PERCPU: Embedded 3 pages/cpu @9800000007adc000 s11968
> r8192 d28992 u49152
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 129603
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: console=tty console=ttyS0,115200
> root=/dev/sda5 PMON_VER=A1101-3.1.8 EC_VER=undefined
> machtype=lemote-3a-itx-a1101  autoplug=off
> [    0.000000] PID hash table entries: 4096 (order: 1, 32768 bytes)
> [    0.000000] total ram pages initialed 0
> [    0.000000] total ram pages are 123261
> [    0.000000] Kernel panic - not syncing: Oh boy, that early out of memory?
>
> 3, If I revert the commit ad04c2e9 (MIPS: Use inline function to
> access current thread pointer), everything is OK.
>
> If other MIPS have no problem, could anyone give me some suggestions?
> Kernel code of Loongson-3 is here:
> http://dev.lemote.com/cgit/linux-official.git/
>
> Thanks,
> Huacai Chen
