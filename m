Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 17:39:56 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39482 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842994AbaFQPXOF3Edw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 17:23:14 +0200
Received: by mail-lb0-f178.google.com with SMTP id 10so2942290lbg.23
        for <linux-mips@linux-mips.org>; Tue, 17 Jun 2014 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oIRnBs1VOzixeG4gowVT3qbI1brBHkMnCseNIV2yxaw=;
        b=wDd/3zdtBEOglm9RfRfoxPUTj1MQihFiQIDRBWFaBOXM4hm60IyaadwLL7vG+G92Lh
         YpkcLt86qYK21vFqeXsh6SMEHSuXdP3/6kpbt8A4lKvSZ6wx4R2a8itNPvS0J1dww2eA
         AdbASHa5zcg5weKtKao5IT2n7NMOdjV31ihZA/zJ/XDON59Pe6oRmHu4quM6oEckuO1y
         y5iTLt/HtocGHdwZ5JCaTXaF9t/5DlQjv/hf/d6ryKq9bLu+GMAwAshqlUgst+yr9NPp
         ZBpi6TMJ9KyuIYPtRm/CPtAGSksWs9NKu6OE2hJLB57Ep1Ip1m5BdVJ7zDT6tkfLpjoM
         7N0w==
MIME-Version: 1.0
X-Received: by 10.152.4.137 with SMTP id k9mr7024704lak.46.1403018588454; Tue,
 17 Jun 2014 08:23:08 -0700 (PDT)
Received: by 10.152.43.4 with HTTP; Tue, 17 Jun 2014 08:23:08 -0700 (PDT)
In-Reply-To: <1403018163-25307-1-git-send-email-geert@linux-m68k.org>
References: <1403018163-25307-1-git-send-email-geert@linux-m68k.org>
Date:   Tue, 17 Jun 2014 17:23:08 +0200
X-Google-Sender-Auth: CL1ue0cprtN2Nf2CIVojlHS6Y9M
Message-ID: <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.16-rc1
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Tue, Jun 17, 2014 at 5:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> 85 regressions:
>   + /scratch/kisskb/src/arch/mips/net/bpf_jit.c: error: 'BPF_S_ALU_ADD_K' undeclared (first use in this function):  => 930:8
    [....]
>   + /scratch/kisskb/src/arch/mips/net/bpf_jit.c: error: 'BPF_S_STX' undeclared (first use in this function):  => 925:8

mips-allmodconfig (being fixed)

>   + /scratch/kisskb/src/arch/powerpc/kernel/cacheinfo.c: error: 'size_kb' may be used uninitialized in this function [-Werror=uninitialized]:  => 525:2
>   + /scratch/kisskb/src/drivers/tty/serial/nwpserial.c: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]:  => 53:3
>   + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

powerpc-randconfig

>   + /scratch/kisskb/src/arch/sh/kernel/smp.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]:  => 368:5
>   + /scratch/kisskb/src/arch/sh/kernel/smp.c: error: lvalue required as left operand of assignment:  => 405:24, 368:24, 448:32
>   + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: 'cached_to_uncached' undeclared (first use in this function):  => 99:17
>   + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

>   + /scratch/kisskb/src/drivers/of/platform.c: error: 'struct pdev_archdata' has no member named 'dma_mask':  => 170:16

microblaze/mmu_defconfig (being fixed)

>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add' [-Werror=implicit-function-declaration]:  => 176:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_negative' [-Werror=implicit-function-declaration]:  => 211:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_return' [-Werror=implicit-function-declaration]:  => 218:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec' [-Werror=implicit-function-declaration]:  => 169:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_and_test' [-Werror=implicit-function-declaration]:  => 197:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_return' [-Werror=implicit-function-declaration]:  => 239:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]:  => 162:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_and_test' [-Werror=implicit-function-declaration]:  => 204:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_return' [-Werror=implicit-function-declaration]:  => 232:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_set' [-Werror=implicit-function-declaration]:  => 155:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub' [-Werror=implicit-function-declaration]:  => 183:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_and_test' [-Werror=implicit-function-declaration]:  => 190:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_return' [-Werror=implicit-function-declaration]:  => 225:2
>   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function '__atomic_add_unless' [-Werror=implicit-function-declaration]:  => 53:2
>   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_cmpxchg' [-Werror=implicit-function-declaration]:  => 89:3
>   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]:  => 136:2

sparc-allmodconfig

>   + /scratch/kisskb/src/sound/soc/fsl/fsl_dma.c: error: invalid use of undefined type 'struct ccsr_ssi':  => 926:34, 927:34

powerpc/mpc85xx_defconfig

>   + error: filter.c: undefined reference to `__fpscr_values':  => .text+0x3166c), .text+0x32000), .text+0x31860), .text+0x31d8c), .text+0x324b0)

sh4/se7206_defconfig
sh4/rsk7203_defconfig (toolchain issue)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
