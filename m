Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 02:15:49 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46127 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014066AbaKTBPmDwqzB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2014 02:15:42 +0100
Received: by mail-ie0-f169.google.com with SMTP id y20so1808972ier.14
        for <multiple recipients>; Wed, 19 Nov 2014 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qSHdqvJ//v1uFkELedOlxnX4NMhny5x3QuAYtxEqEFw=;
        b=k0Q9h3fA76R9tpegL0yJPUvQCuHECciqu9afROzZornWyoih/T84J94P3+gJPOq3Fi
         dneXxuKSEKCjlmwlSFZgbd3MjOLAFsPKian1zgJMgzYzU6DwP1RDhLFd2PTZ2YIOJQbq
         y2x+mgQNlMfQszV7lpqAuq2e4RmXjnBo8r6ePajfSXpz4DfmkHHx/xmd/YMi9kV5jDWp
         a1F0Jx1ZRlDThqwnoJHyJBzxJ/w7W4W3weIkWZN54HGC9ym2eDwu6l96DhoQk6VvZ8ni
         akB8Joa6zcQHWbKd6xJ04G9MBxpcVV3DDVNBgSwErDPWtjGtWxnzZK0QkA8HMwfj2HNA
         fQWA==
MIME-Version: 1.0
X-Received: by 10.51.16.37 with SMTP id ft5mr6571797igd.6.1416446136146; Wed,
 19 Nov 2014 17:15:36 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Wed, 19 Nov 2014 17:15:36 -0800 (PST)
In-Reply-To: <20141119192214.GH8625@linux-mips.org>
References: <20141119192214.GH8625@linux-mips.org>
Date:   Thu, 20 Nov 2014 09:15:36 +0800
Message-ID: <CAAhV-H7Rshve6S6Wz0B-MuSmLBbM7LKTOJN07i99wcq=VjDJfA@mail.gmail.com>
Subject: Re: MIPS: Pull request
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, Ralf,

It seems like this patch is missing during rebase:
 MIPS: Fix a copy & paste error in unistd.h

Huacai

On Thu, Nov 20, 2014 at 3:22 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Hi Linus,
>
> The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:
>
>   Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)
>
> are available in the git repository at:
>
>   git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream
>
> for you to fetch changes up to 935c2dbec4d6d3163ee8e7409996904a734ad89a:
>
>   MIPS: jump_label.c: Handle the microMIPS J instruction encoding (2014-11-19 18:22:09 +0100)
>
> More 3.18 fixes for MIPS:
>
>  - Backtraces were not quite working on on 64-bit kernels
>  - Loongson needs a different cache coherency setting
>  - Loongson 3 is a MIPS64 R2 version but due to erratum we treat is an
>    older architecture revision.
>  - Fix build errors due to undefined references to __node_distances for
>    certain configurations.
>  - Fix instruction decodig in the jump label code.
>  - For certain configurations copy_{from,to}_user destroy the content
>    of $3 so that register needs to be marked as clobbed by the calling
>    code.
>  - Hardware Table Walker fixes.
>  - Fill the delay slot of the last instruction of memcpy otherwise
>    whatever ends up there randomly might have undesirable effects.
>  - Ensure get_user/__get_user always zero the variable to be read even
>    in case of an error.
>
> Please consider pulling,
>
>   Ralf
>
> ----------------------------------------------------------------
> This has survived the usual torture by Imagination's build farm and
> sat in -next.
>
>
> Aaro Koskinen (1):
>       MIPS: oprofile: Fix backtrace on 64-bit kernel
>
> Huacai Chen (2):
>       MIPS: Loongson: Fix the write-combine CCA value setting
>       MIPS: Loongson: Set Loongson-3's ISA level to MIPS64R1
>
> James Cowgill (2):
>       MIPS: Loongson3: Fix __node_distances undefined error
>       MIPS: IP27: Fix __node_distances undefined error
>
> Maciej W. Rozycki (2):
>       MIPS: jump_label.c: Correct the span of the J instruction
>       MIPS: jump_label.c: Handle the microMIPS J instruction encoding
>
> Markos Chandras (3):
>       MIPS: asm: uaccess: Add v1 register to clobber list on EVA
>       MIPS: tlb-r4k: Add missing HTW stop/start sequences
>       MIPS: lib: memcpy: Restore NOP on delay slot before returning to caller
>
> Ralf Baechle (1):
>       MIPS: Zero variable read by get_user / __get_user in case of an error.
>
>  arch/mips/include/asm/jump_label.h                 |  8 ++++-
>  .../asm/mach-loongson/cpu-feature-overrides.h      |  2 --
>  arch/mips/include/asm/uaccess.h                    | 12 ++++---
>  arch/mips/kernel/cpu-probe.c                       |  7 ++--
>  arch/mips/kernel/jump_label.c                      | 42 ++++++++++++++++------
>  arch/mips/lib/memcpy.S                             |  1 +
>  arch/mips/loongson/loongson-3/numa.c               |  1 +
>  arch/mips/mm/tlb-r4k.c                             |  4 +++
>  arch/mips/oprofile/backtrace.c                     |  2 +-
>  arch/mips/sgi-ip27/ip27-memory.c                   |  1 +
>  10 files changed, 60 insertions(+), 20 deletions(-)
>
