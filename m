Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 23:43:02 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:49914 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011008AbaJIVnAeHxDg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 23:43:00 +0200
Received: by mail-ig0-f170.google.com with SMTP id hn15so4834292igb.3
        for <multiple recipients>; Thu, 09 Oct 2014 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=W+Jwvlb762rCPZoNafuOWvlAYUGC9MJxLaugp1zNyLs=;
        b=L7EBpisFafb1hXsiHqfBQxKIN9tTRNTwK8CAWcLpQekNckL3mavrxso0sbgknknJrC
         F4+KSjKo00B8FezkbwSZsOnkJtTROO/Pr1oHKao/mWRzDmt5K2jwfFfUPSJ9/wVWSF2X
         npzQuBUXL2tW8/zCSklNwXl6eNYjU+Nw4vU/ico1xCMlEu5WIsEfaVHm7vBNL4j/zIYn
         OJAybc5R8yBJ69WEj8QoHCtrnCdwY7Q4/a0vqv6dQmMoNIPtmIzoN/TIkrYxW7VYvteE
         wsyqpz7lxM3UJAnlK5Aw1hq9V0FQGVD4BW8ztlV4LpQORk7sUjyOl1amGzS/FD88bpFF
         rJ9w==
X-Received: by 10.42.137.129 with SMTP id y1mr11547782ict.40.1412890974155;
        Thu, 09 Oct 2014 14:42:54 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id w8sm417091igz.1.2014.10.09.14.42.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Oct 2014 14:42:53 -0700 (PDT)
Message-ID: <5437015B.3010205@gmail.com>
Date:   Thu, 09 Oct 2014 14:42:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     linux-mips@linux-mips.org, Zubair.Kakakhel@imgtec.com,
        geert+renesas@glider.be, david.daney@cavium.com,
        peterz@infradead.org, paul.gortmaker@windriver.com,
        davidlohr@hp.com, macro@linux-mips.org, chenhc@lemote.com,
        richard@nod.at, zajec5@gmail.com, james.hogan@imgtec.com,
        keescook@chromium.org, alex@alex-smith.me.uk, tglx@linutronix.de,
        blogic@openwrt.org, jchandra@broadcom.com, paul.burton@imgtec.com,
        qais.yousef@imgtec.com, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, markos.chandras@imgtec.com,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        akpm@linux-foundation.org, lars.persson@axis.com
Subject: Re: [PATCH v2 0/3] MIPS executable stack protection
References: <20141009195030.31230.58695.stgit@linux-yegoshin>
In-Reply-To: <20141009195030.31230.58695.stgit@linux-yegoshin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43173
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

On 10/09/2014 01:00 PM, Leonid Yegoshin wrote:
> The following series implements an executable stack protection in MIPS.
>
> It sets up a per-thread 'VDSO' page and appropriate TLB support.
> Page is set write-protected from user and is maintained via kernel VA.
> MIPS FPU emulation is shifted to new page and stack is relieved for
> execute protection as is as all data pages in default setup during ELF
> binary initialization. The real protection is controlled by GLIBC and
> it can do stack protected now as it is done in other architectures and
> I learned today that GLIBC team is ready for this.

What does it mean to be 'ready'?  If they committed patches before there 
was kernel support, that it putting the cart before the horse.  GlibC's 
state cannot be used as valid reason for committing major kernel 
changes.  There would be no regression in any GLibC based system as a 
result of not merging this patch.

>
> Note: actual execute-protection depends from HW capability, of course.
>
> This patch is required for MIPS32/64 R2 emulation on MIPS R6 architecture.
> Without it 'ssh-keygen' crashes pretty fast on attempt to execute instruction
> in stack.

There is much more blocking MIPS32/64 R2 emulation on MIPS R6 than just 
this patch isn't there?

Also, if you are supporting MIPS R6, this patch doesn't even work, 
because it doesn't handle PC relative instructions at all.

>
> v2 changes:
>      - Added an optimization during mmap switch - doesn't switch if the same
>        thread is rescheduled and other threads don't intervene (Peter Zijlstra)
>      - Fixed uMIPS support (Paul Burton)
>      - Added unwinding of VDSO emulation stack at signal handler invocation,
>        hiding an emulation page (Andy Lutomirski note in other patch comments)
>
> ---
>
> Leonid Yegoshin (3):
>        MIPS: mips_flush_cache_range is added
>        MIPS: Setup an instruction emulation in VDSO protected page instead of user stack
>        MIPS: set stack/data protection as non-executable
>

The recent discussions on this subject, including many comments from 
Imgtec e-mail addresses, brought to light the need to use an instruction 
set emulator for newer MIPSr6 ISA processors.

In light of this, why does it make sense to merge this patch, instead of 
taking the approach of emulating the instructions in the delay slot?

David Daney


>
>   arch/mips/include/asm/cacheflush.h   |    3 +
>   arch/mips/include/asm/fpu_emulator.h |    2
>   arch/mips/include/asm/mmu.h          |    3 +
>   arch/mips/include/asm/page.h         |    2
>   arch/mips/include/asm/processor.h    |    2
>   arch/mips/include/asm/switch_to.h    |   14 +++
>   arch/mips/include/asm/thread_info.h  |    3 +
>   arch/mips/include/asm/tlbmisc.h      |    1
>   arch/mips/include/asm/vdso.h         |    3 +
>   arch/mips/kernel/process.c           |    7 ++
>   arch/mips/kernel/signal.c            |    4 +
>   arch/mips/kernel/vdso.c              |   41 +++++++++
>   arch/mips/math-emu/cp1emu.c          |    8 +-
>   arch/mips/math-emu/dsemul.c          |  153 ++++++++++++++++++++++++++++------
>   arch/mips/mm/c-octeon.c              |    8 ++
>   arch/mips/mm/c-r3k.c                 |    8 ++
>   arch/mips/mm/c-r4k.c                 |   43 ++++++++++
>   arch/mips/mm/c-tx39.c                |    9 ++
>   arch/mips/mm/cache.c                 |    4 +
>   arch/mips/mm/fault.c                 |    5 +
>   arch/mips/mm/tlb-r4k.c               |   42 +++++++++
>   21 files changed, 333 insertions(+), 32 deletions(-)
>
