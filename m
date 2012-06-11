Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2012 20:32:27 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:44303 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903657Ab2FKScU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2012 20:32:20 +0200
Received: by ggcs5 with SMTP id s5so3083111ggc.36
        for <multiple recipients>; Mon, 11 Jun 2012 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=39vOQUTcXt9ud77ak9CS4wCjWwz0LQA8vdKprK3pBXg=;
        b=zMvhH2LuHCKX0mOMf8r82O1FcloaKg59P8h1h+V5ScAkhlqcXnyt1o/c5S8oO7TTpQ
         U0ZaXuoeBco28uhO0W8Xx0GRYInDxWJpxJDb2awsGrce4tiucnxh0sForzRBU72Uedqv
         9K6z4R+lG/is2WgUCxZ/26FWZTBrsITxnNemglgFwh95HIE3quIK/73x3S9S6hLlPsRd
         XlQyaUl4FPIMWAVcSIiEiS8uVVm6VOLocvhEBJTcz151YUXBllewL/r77dUNwwBfv5dP
         zmIAwzitrZvjukIVfz6mUC0dIW8GN4+H6MBz/zI6Lm5NfP8xNVDdPTcIvvqduNrWWumg
         UGig==
MIME-Version: 1.0
Received: by 10.50.10.164 with SMTP id j4mr7068347igb.13.1339439533885; Mon,
 11 Jun 2012 11:32:13 -0700 (PDT)
Received: by 10.231.219.5 with HTTP; Mon, 11 Jun 2012 11:32:13 -0700 (PDT)
In-Reply-To: <4FD61F35.1080103@gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
        <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com>
        <CACoURw4+N8Nk-N81kryXHOg9O_=ntvqv9prOLAZW6KKEYQ9v+A@mail.gmail.com>
        <4FD61B22.3040407@gmail.com>
        <4FD61F35.1080103@gmail.com>
Date:   Mon, 11 Jun 2012 12:32:13 -0600
Message-ID: <CACoURw6oCNKHh7o9N_kE6uryfpu57sQqA-p2fq6hKnsikO5KgA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MIPS: Move cache setup to setup_arch().
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi David:

  A little more info, if it's useful...

On Mon, Jun 11, 2012 at 10:39 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>>> I've run into a problem in linux-3.5-rc1, and I've tracked it down
>>> to this patch, MIPS: Move cache setup to setup_arch().,
>>> commit 6650df3c380e0db558dbfec63ed860402c6afb2a.
>>>
>>
>> Are you permitted to describe the problem in any additional detail?
>>
>> Knowing what type of system is affected and the nature of the problem
>> would be useful in trying to arrive at a good solution.
>
>>> I'm running a single-CPU, PMC-Sierra RM7035C-based system.
>>>
>>> Before applying this patch, cca_setup() in arch/mips/mm/c-r4k.c
>>> is called before coherency_setup() (called from rk4_cache_init()).
>>> After applying the patch, it is called afterwards. Because
>>> coherency_setup() relies on cca_setup() properly setting the
>>> variable cca, it won't use the value of cca supplied on the
>>> kernel command line.
>>>
>>> I haven't verified it, but I suspect the same problem will occur
>>> with the call to setcoherentio(), also in c-r4k.c.
>>>
>>> Unfortunately, I don't have the knowledge to formulate a patch
>>> to this problem, but I wanted to raise the issue.

The board is the PMC-Sierra "Xiao Hu", described at
http://www.linuxjournal.com/article/7854.  The version I have
has the 600 MHz RM7035C processor.  The code supporting
the board is not in-tree, unfortunately.  I believe PMC-Sierra
is no longer maintaining their BSP, but I've been keeping
a copy of the kernel code up-to-date.

Here is the info on the processor reported by PMON:

CPU type RM7065.  Rev 5.3.  600 MHz/100 MHz.
Memory size 128 MB.
Icache size  16 KB, 32/line (4 way)
Dcache size  16 KB, 32/line (4 way)
Scache size 256 KB, 32/line (4 way)

I typically boot with the command-line options:
root=/dev/hda1 cca=3

CPU information displayed upon booting is:

CPU revision is: 00002753 (RM7000)
FPU revision is: 00002750

Cache information displayed upon booting is:

Primary instruction cache 16kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 32 bytes
Secondary cache size 256K, linesize 32 bytes.

Here are some snippets from the .config file (I've removed lines
that are probably irrelevant to this problem):

CONFIG_PMC_XIAOHU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_CEVT_R4K_LIB=y
CONFIG_CEVT_R4K=y
CONFIG_CSRC_R4K_LIB=y
CONFIG_CSRC_R4K=y
# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
CONFIG_DMA_NONCOHERENT=y

CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
CONFIG_IRQ_CPU=y
CONFIG_MIPS_L1_CACHE_SHIFT=5

#
# CPU selection
#
CONFIG_CPU_RM7000=y
CONFIG_SYS_HAS_CPU_RM7000=y
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y

#
# Kernel type
#
CONFIG_32BIT=y
# CONFIG_64BIT is not set
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_BOARD_SCACHE=y
CONFIG_RM7000_CPU_SCACHE=y
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_MIPS_MT_DISABLED=y
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set


After adding in some debugging statements, I see that after applying
the subject patch, coherency_setup() is called before cca_setup()
is called.  Before applying the patch, coherency_setup() is called
after cca_setup().

cca_setup() grabs the value of the cca= command line parameter,
and stores it in the variable cca.  If no such command line parameter
is given, cca uses its default value of -1.  coherency_setup() then uses
the cca variable when setting up the coherency mode.
that value

> I will think about how to fix it.
>
> David Daney

Thanks.  There is a line:

__setup("cca=", cca_setup);

that seems to be used to call cca_setup().  I don't know how
the __setup() works, so I'm a little lost on the solution myself.

Note that, besides the cca_setup(), there is also a routine
setcoherentio() that is defined the same way as cca_setup().
I suspect that suffers from the same problem as cca_setup().

If there is any other information I can provide,
please let me know!  Thanks.

Shane McDonald
