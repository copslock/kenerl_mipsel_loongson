Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 21:46:37 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34073 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025906AbcDDTqfn8Sin (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 21:46:35 +0200
Received: by mail-lb0-f169.google.com with SMTP id vo2so177942408lbb.1
        for <linux-mips@linux-mips.org>; Mon, 04 Apr 2016 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0bQeETP6r/pUoIf30yDpLfMrvLWHYnHaCELbBalrdkw=;
        b=fFQjWnU7zTK1U4yRF+e3ibeOtC6s60m3VIUXRLH13/hVvNwEAQ+h940i3Xr0Smn2vz
         827ZvxGE/d1WlmvEDj7aAnXLrUdZU5tdM0B/LxaE1XXO2Z+ZQGjbT7Qi8R5p+f7e1TLZ
         8mZFGvbWsBEFCHdz7JcQ9Dw125/fgu/WzunvWOPiCMcnm183VLx6ED5GJIhZbI3IpLFm
         S9DdcI2zAgbWy738xIDstMiQ0ijbfQB5mxWMldEogngQ0NCNpbSvFCM100rcuHfgSp9z
         g/JQrAQRI8Y+mepI/tvaBi3ev2j6+kX9bGylmN928MIxBu/K/Rz9FtdtZApECfTmjL9w
         2gBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0bQeETP6r/pUoIf30yDpLfMrvLWHYnHaCELbBalrdkw=;
        b=Tx8sCkq1YEHLTY2k732sckomwa7+jIi3JU60bK7Dtjlx7IJJcYfH9uVOhRhM6JqHTK
         I3iJ9pW53BV+pcQyK8KRCW4xIbJNUkG/afYMcD4uvXgiTpfrukt/6R0xqNpvlWZpGuA6
         9RChbHJXuHTS/GVxTn+fdIfahZ27iIOXZ0VhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0bQeETP6r/pUoIf30yDpLfMrvLWHYnHaCELbBalrdkw=;
        b=G87ECpQw3dIbpxToLPXASGuWdDbEYHM1+F2t4ZI08pZ2wsCkhraYnSmrBrOUqgeJ4w
         nPvwPX4FiUVqXm5dym8xivSmQBwFIVZ0IYhpt3TtE92pBtaXLTB9VDvCpq9d6pCPScDV
         nTUCymn/gppD5rZShQAC+g96bD9JHfS0srSijReuXgtbeVOLfbGfBjPke3xtkcVIxxU0
         Aci510WctdUeVFdHd4mQjtKFydOTirAloEabkDP41XENal4E/gE1yO6Nw6XYsoZjCVQJ
         BfsNzQkn4K7HMTHmLPo+SCtiiUrkqi/jGpDWYUUTvyKpxeN885iZwvuCnmEtdVJUZcfb
         l0qg==
X-Gm-Message-State: AD7BkJJ32+LyLJ0QonyS1w1xhbas/2C5gHhdULvpzEuOrzYm+FCoMw/lzRka9nmxCrO8ONaD1tWRYL6rAjuMM6YW
MIME-Version: 1.0
X-Received: by 10.28.125.8 with SMTP id y8mr14188463wmc.87.1459799190033; Mon,
 04 Apr 2016 12:46:30 -0700 (PDT)
Received: by 10.28.157.205 with HTTP; Mon, 4 Apr 2016 12:46:29 -0700 (PDT)
In-Reply-To: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
Date:   Mon, 4 Apr 2016 12:46:29 -0700
X-Google-Sender-Auth: behcgDHK8QcHJb14aYVJW2OHwA4
Message-ID: <CAGXu5jKMLcRmMkowF=fUEQdtccTJLR9FEWT4g_zeyZMW4BWQOg@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH v2 00/11] MIPS relocatable kernel & KASLR
From:   Kees Cook <keescook@chromium.org>
To:     "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Daney <ddaney@caviumnetworks.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Thu, Mar 31, 2016 at 2:05 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>
> This series adds the ability for the MIPS kernel to relocate itself at
> runtime, optionally to an address determined at random each boot. This
> series is based on v4.4 and has been tested on the Malta, Boston and
> SEAD3 platforms.
>
> Here is a description of how relocation is achieved:
> * Kernel is compiled & statically linked as normal, with no position
>   independent code. MIPS before R6 only has limited relative jump
>   instructions so the vast majority of jumps are absolute. To compile
>   the kernel position independent would introduce a highly undesireable
>   overhead. Relocating the static binary gives a small startup time
>   penalty but the kernel otherwise perforns normally.
> * The linker flag --emit-relocs is added to the linker command line,
>   causing ld to include relocation sections in the output elf
> * A tool derived from the x86 relocs tool is used to parse the
>   relocation sections and create a binary table of relocations. Each
>   entry in the table is 32bits, comprised of a 24bit offset (in words)
>   from _text and an 8bit relocation type.
> * The table is inserted into the vmlinux elf, into some space reserved
>   for it in the linker script. Inserting the table into vmlinux means
>   all boot targets will automatically include the relocation code and
>   information.
> * At boot, the kernel memcpy()s itself elsewhere in memory, then goes
>   through the table performing each relocation on the new image.
> * If all goes well, control is passed to the entry point of the new
>   kernel.

This is great! Thanks for working on this! :)

Without actually reading the code yet, I wonder if the x86 and MIPS
relocs tool could be merged at all? Sounds like it might be more
difficult though -- the relocation output is different and its storage
location is different...

> Restrictions:
> * The new kernel is not allowed to overlap the old kernel, such that
>   the original kernel can still be booted if relocation fails.

This sounds like physical-only relocation then? Is the virtual offset
randomized as well (like arm64) or just physical (like x86 currently
-- though there is a series to fix this).

> * Relocation is supported only by multiples of 64k bytes. This
>   eliminates the need to handle R_MIPS_LO16 relocations as the bottom
>   16bits will remain the same at the relocated address.

IIUC, that's actually better than x86, which needs to be 2MB aligned.

> * In 64 bit kernels, relocation is supported only within the same 4Gb
>   memory segment as the kernel link address (CONFIG_PHYSICAL_START).
>   This eliminates the need to handle R_MIPS_HIGHEST and R_MIPS_HIGHER
>   relocations as the top 32bits will remain the same at the relocated
>   address.

Interesting. Could the relocation code be updated in the future to
bump the high addresses too?

> Changes in v2:
> - Added support  for MIPSr6
> - Accept the "nokaslr" command line option
> - Add a kernel panic notifier to print the relocation information
> - Accept entropy via the /chosen/kaslr-seed property in device tree
> - Tested on MIPS Malta, Boston and SEAD3 platforms
>
> Matt Redfearn (11):
>   MIPS: tools: Add relocs tool
>   MIPS: tools: Build relocs tool
>   MIPS: Reserve space for relocation table
>   MIPS: Generate relocation table when CONFIG_RELOCATABLE
>   MIPS: Kernel: Add relocate.c
>   MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
>   MIPS: bootmem: When relocatable, free memory below kernel
>   MIPS: Add CONFIG_RELOCATABLE Kconfig option
>   MIPS: Introduce plat_get_fdt a platform API to retrieve the FDT
>   MIPS: Kernel: Implement KASLR using CONFIG_RELOCATABLE
>   MIPS: KASLR: Print relocation Information on boot
>
>  arch/mips/Kconfig                  |  64 ++++
>  arch/mips/Makefile                 |  19 ++
>  arch/mips/boot/tools/Makefile      |   8 +
>  arch/mips/boot/tools/relocs.c      | 680 +++++++++++++++++++++++++++++++++++++
>  arch/mips/boot/tools/relocs.h      |  45 +++
>  arch/mips/boot/tools/relocs_32.c   |  17 +
>  arch/mips/boot/tools/relocs_64.c   |  27 ++
>  arch/mips/boot/tools/relocs_main.c |  84 +++++
>  arch/mips/include/asm/bootinfo.h   |  18 +
>  arch/mips/kernel/Makefile          |   2 +
>  arch/mips/kernel/head.S            |  20 ++
>  arch/mips/kernel/relocate.c        | 386 +++++++++++++++++++++
>  arch/mips/kernel/setup.c           |  23 ++
>  arch/mips/kernel/vmlinux.lds.S     |  21 ++
>  arch/mips/mti-malta/malta-setup.c  |   7 +-
>  arch/mips/mti-sead3/sead3-setup.c  |   5 +
>  16 files changed, 1425 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/tools/Makefile
>  create mode 100644 arch/mips/boot/tools/relocs.c
>  create mode 100644 arch/mips/boot/tools/relocs.h
>  create mode 100644 arch/mips/boot/tools/relocs_32.c
>  create mode 100644 arch/mips/boot/tools/relocs_64.c
>  create mode 100644 arch/mips/boot/tools/relocs_main.c
>  create mode 100644 arch/mips/kernel/relocate.c
>
> --
> 2.5.0
>

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
