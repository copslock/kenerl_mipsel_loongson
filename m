Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 12:03:38 +0200 (CEST)
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35396 "EHLO
        mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010263AbbD0KDgy03Lp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 12:03:36 +0200
Received: by obcux3 with SMTP id ux3so79299361obc.2
        for <linux-mips@linux-mips.org>; Mon, 27 Apr 2015 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MI7sY+B7dpjwthoF8tWIyZX81rBn3isS3F5C+a3A6Gg=;
        b=Q96t9xuyiXtNagDWh6gD1VVqELSCsNIo0OS1xMJjVyv2iVSGXButOD/4+iZ9J2Jcs8
         pYmzsVqccFRPDA0qd8YDEC/Mh386QW7AaU8+763yV7NPRNMYo4jHUQ0IPNxL7ZOPO91j
         XoRp1FqEGi1GL5SWO1htdl2GjbxEaemHmsl8IyLcXwdXs3u0ia7YL7AT37fcThqR3aLc
         qBuuWCVPJFLJwqPibzBnrD+6OkR39h2ML+S8bIfPP5ek90hiiZhf7hMe+fQ1OfE5L/u8
         p5u5Ff/OBtGDYBYIHIfG6stdOXSMNt3XiL1yAEJwUIxrarT+AgpfX5X1UilJXkT2vVMk
         0qEw==
MIME-Version: 1.0
X-Received: by 10.60.40.195 with SMTP id z3mr9243144oek.85.1430129012701; Mon,
 27 Apr 2015 03:03:32 -0700 (PDT)
Received: by 10.60.103.171 with HTTP; Mon, 27 Apr 2015 03:03:32 -0700 (PDT)
In-Reply-To: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
Date:   Mon, 27 Apr 2015 12:03:32 +0200
X-Google-Sender-Auth: cnrcckzO1MBsQQ5x1xD18EKeBgA
Message-ID: <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.1-rc1
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthew Wilcox <willy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47084
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

On Mon, Apr 27, 2015 at 11:51 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.1-rc1[1] compared to v4.0[2].
>
> Summarized:
>   - build errors: +34/-11
>   - build warnings: +135/-163
>
> As I haven't mastered kup yet, there's no verbose summary at
> http://www.kernel.org/pub/linux/kernel/people/geert/linux-log/v4.1-rc1.summary.gz
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/head/8779/ (254 out of 257 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/8710/ (254 out of 257 configs)
>
>
> *** ERRORS ***
>
> 34 regressions:

The quiet days are over...

>   + /home/kisskb/slave/src/arch/mips/cavium-octeon/smp.c: error: passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 242:2
>   + /home/kisskb/slave/src/arch/mips/kernel/process.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 52:2
>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 149:2, 211:2
>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 221:2

mips/bigsur_defconfig
mips/malta_defconfig
mips/cavium_octeon_defconfig
mips/ip27_defconfig

and related warnings due to lack of -Werror on
ia64-defconfig
tilegx_defconfig
m32r/m32700ut.smp_defconfig

cpumask also gives fishy warnings:

    lib/cpumask.c:167:25: warning: the address of 'cpu_all_bits' will
always evaluate as 'true' [-Waddress]

on sparc (e.g. sparc64/sparc64-allmodconfig) and powerpc (e.g.
powerpc/ppc64_defconfig), which seem to have been reported 6 months ago...

Can we throw some bitcoins at the cpumasks? ;-)

>   + /home/kisskb/slave/src/arch/mips/sgi-ip32/ip32-platform.c: error: 'sgio2_cmos_devinit' undeclared here (not in a function):  => 138:1
>   + /home/kisskb/slave/src/arch/mips/sgi-ip32/ip32-platform.c: error: expected identifier or '(' before '+' token:  => 133:1

mips/ip32_defconfig

>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: "arch_read_can_lock" redefined [-Werror]:  => 185:0
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: "arch_write_can_lock" redefined [-Werror]:  => 186:0
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: "smp_mb__after_unlock_lock" redefined [-Werror]:  => 31:0
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: 'arch_rwlock_t' has no member named 'lock':  => 267:12, 303:4, 214:12, 295:11, 253:12, 238:25
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: 'arch_spinlock_t' has no member named 'slock':  => 86:27, 59:13
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: expected ')' before '(' token:  => 62:19
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: expected identifier or '(' before 'do':  => 159:20, 139:6, 168:13, 123:20
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: expected identifier or '(' before 'void':  => 62:19
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: expected identifier or '(' before 'while':  => 168:13, 123:20, 139:6, 159:20
>   + /home/kisskb/slave/src/arch/powerpc/include/asm/spinlock.h: error: expected identifier or '(' before '{' token:  => 92:19

powerpc/ppc64_defconfig+UP

>   + /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c: error: implicit declaration of function 'dma_alloc_attrs' [-Werror=implicit-function-declaration]:  => 218:2
>   + /home/kisskb/slave/src/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c: error: implicit declaration of function 'dma_free_attrs' [-Werror=implicit-function-declaration]:  => 154:2

xtensa-allmodconfig
powerpc/mpc85xx_defconfig

>   + /home/kisskb/slave/src/drivers/spi/spi-bcm2835.c: error: dereferencing pointer to incomplete type:  => 356:21, 387:21
>   + /home/kisskb/slave/src/drivers/spi/spi-bcm2835.c: error: implicit declaration of function 'gpiochip_find' [-Werror=implicit-function-declaration]:  => 382:2

m68k-allmodconfig
s390-allyesconfig
s390-allmodconfig
parisc-allmodconfig
sh-allmodconfig
sh-allyesconfig
mips-allmodconfig

(fix stuck in the spi tree?)

>   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 265:2

sh-randconfig

>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: 'AT_FDCWD' undeclared (first use in this function):  => 373
>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: (Each undeclared identifier is reported only once:  => 373
>   + /home/kisskb/slave/src/fs/hostfs/hostfs_user.c: error: for each function it appears in.):  => 373

um-i386/um-defconfig

>   + /home/kisskb/slave/src/include/asm-generic/io.h: error: implicit declaration of function 'bfin_read16' [-Werror=implicit-function-declaration]:  => 121:2
>   + /home/kisskb/slave/src/include/asm-generic/io.h: error: implicit declaration of function 'bfin_read32' [-Werror=implicit-function-declaration]:  => 129:2
>   + /home/kisskb/slave/src/include/asm-generic/io.h: error: implicit declaration of function 'bfin_read8' [-Werror=implicit-function-declaration]:  => 113:2
>   + /home/kisskb/slave/src/include/asm-generic/io.h: error: implicit declaration of function 'bfin_write16' [-Werror=implicit-function-declaration]:  => 155:2
>   + /home/kisskb/slave/src/include/asm-generic/io.h: error: implicit declaration of function 'bfin_write32' [-Werror=implicit-function-declaration]:  => 163:2
>   + /home/kisskb/slave/src/include/asm-generic/io.h: error: implicit declaration of function 'bfin_write8' [-Werror=implicit-function-declaration]:  => 147:2

bfin/BF561-EZKIT-SMP_defconfig

>   + error: No rule to make target include/config/auto.conf:  => N/A

arm-randconfig

>   + error: initramfs.c: undefined reference to `__stack_chk_guard':  => .init.text+0x1b30)

i386-randconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
