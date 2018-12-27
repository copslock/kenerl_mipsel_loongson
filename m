Return-Path: <SRS0=uIlq=PE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5F6C43387
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 20:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2D82148D
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 20:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeL0UWL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:22:11 -0500
Received: from hall.aurel32.net ([163.172.24.10]:45142 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbeL0UWL (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 27 Dec 2018 15:22:11 -0500
X-Greylist: delayed 1176 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2018 15:22:09 EST
Received: from [78.30.2.155] (helo=ohm.local)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aurelien@aurel32.net>)
        id 1gcbrR-0007Dj-16; Thu, 27 Dec 2018 21:02:29 +0100
Received: from aurel32 by ohm.local with local (Exim 4.91)
        (envelope-from <aurelien@aurel32.net>)
        id 1gcbrK-00014m-Fp; Thu, 27 Dec 2018 21:02:22 +0100
Date:   Thu, 27 Dec 2018 21:02:22 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@vger.kernel.org, rachel.mozes@intel.com
Subject: Re: [PATCH v5 2/5] MIPS: kexec: Make a framework for both jumping
 and halting on nonboot CPUs
Message-ID: <20181227200222.GA29774@aurel32.net>
References: <20180911214924.21993-1-dzhu@wavecomp.com>
 <20180911214924.21993-3-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180911214924.21993-3-dzhu@wavecomp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 2018-09-11 14:49, Dengcheng Zhu wrote:
> The existing implementation lets machine_kexec() CPU jump to reboot code
> buffer, whereas other CPUs to relocated_kexec_smp_wait. The natural way to
> bring up an SMP new kernel would be to let CPU0 do it while others being
> halted. For those failing to do so, fall back to the jumping method.
> 
> Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
> ---
>  arch/mips/cavium-octeon/smp.c         |  7 +++
>  arch/mips/include/asm/kexec.h         |  5 +-
>  arch/mips/include/asm/smp-ops.h       |  3 +
>  arch/mips/include/asm/smp.h           | 16 +++++
>  arch/mips/kernel/crash.c              |  4 +-
>  arch/mips/kernel/machine_kexec.c      | 88 ++++++++++++++++++++++++---
>  arch/mips/kernel/smp-bmips.c          |  7 +++
>  arch/mips/loongson64/loongson-3/smp.c |  4 ++
>  8 files changed, 124 insertions(+), 10 deletions(-)
> 

[ snip ]

> diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
> index 493a3cc7c39a..5eeb648c4e3a 100644
> --- a/arch/mips/include/asm/kexec.h
> +++ b/arch/mips/include/asm/kexec.h
> @@ -39,11 +39,12 @@ extern unsigned long kexec_args[4];
>  extern int (*_machine_kexec_prepare)(struct kimage *);
>  extern void (*_machine_kexec_shutdown)(void);
>  extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
> -extern void default_machine_crash_shutdown(struct pt_regs *regs);
> +void default_machine_crash_shutdown(struct pt_regs *regs);
> +void kexec_nonboot_cpu_jump(void);
> +void kexec_reboot(void);
>  #ifdef CONFIG_SMP
>  extern const unsigned char kexec_smp_wait[];
>  extern unsigned long secondary_kexec_args[4];
> -extern void (*relocated_kexec_smp_wait) (void *);
>  extern atomic_t kexec_ready_to_reboot;
>  extern void (*_crash_smp_send_stop)(void);
>  #endif

[ snip ]

> diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
> index 4b3726e4fe3a..c63c1f52d1c5 100644
> --- a/arch/mips/kernel/machine_kexec.c
> +++ b/arch/mips/kernel/machine_kexec.c
> @@ -19,15 +19,19 @@ extern const size_t relocate_new_kernel_size;
>  extern unsigned long kexec_start_address;
>  extern unsigned long kexec_indirection_page;
>  
> -int (*_machine_kexec_prepare)(struct kimage *) = NULL;
> -void (*_machine_kexec_shutdown)(void) = NULL;
> -void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
> +static unsigned long reboot_code_buffer;
> +
>  #ifdef CONFIG_SMP
> -void (*relocated_kexec_smp_wait) (void *);
> +static void (*relocated_kexec_smp_wait)(void *);
> +
>  atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
>  void (*_crash_smp_send_stop)(void) = NULL;
>  #endif

The above changes broke kexec support on Octeon, as
relocated_kexec_smp_wait() is still called from octeon_kexec_smp_down():

|   gcc-8 -Wp,-MD,arch/mips/cavium-octeon/.setup.o.d  -nostdinc -isystem /usr/lib/gcc/mips-linux-gnu/8/include -I/<<PKGBUILDDIR>>/arch/mips/include -I./arch/mips/include/generated  -I/<<PKGBUILDDIR>>/include -I./include -I/<<PKGBUILDDIR>>/arch/mips/include/uapi -I./arch/mips/include/generated/uapi -I/<<PKGBUILDDIR>>/include/uapi -I./include/generated/uapi -include /<<PKGBUILDDIR>>/include/linux/kconfig.h -include /<<PKGBUILDDIR>>/include/linux/compiler_types.h  -I/<<PKGBUILDDIR>>/arch/mips/cavium-octeon -Iarch/mips/cavium-octeon -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=0xffffffff81100000 -DDATAOFFSET=0 -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -fno-PIE -DCC_HAVE_ASM_GOTO -mmcount-ra-address -DKBUILD_MCOUNT_RA_ADDRESS -mno-check-zero-division -mabi=64 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -fno-stack-chec
 k -march=octeon -Wa,--trap -Wa,-mfix-cn63xxp1 -DTOOLCHAIN_SUPPORTS_VIRT -DTOOLCHAIN_SUPPORTS_XPA -DTOOLCHAIN_SUPPORTS_CRC -DTOOLCHAIN_SUPPORTS_DSP  -I/<<PKGBUILDDIR>>/arch/mips/include/asm/mach-cavium-octeon  -I/<<PKGBUILDDIR>>/arch/mips/include/asm/mach-generic -msym32 -DKBUILD_64BIT_SYM32 -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=allow-store-data-races=0 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g -pg -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -fmacro-prefix-map=/<<PKGBUILDDIR>>/= -Wno-packed-not-aligned   -fdebug-
 prefix-map=/<<PKGBUILDDIR>>=. -DKBUILD_BASENAME='"setup"' -DKBUILD_MODNAME='"setup"' -c -o arch/mips/cavium-octeon/.tmp_setup.o /<<PKGBUILDDIR>>/arch/mips/cavium-octeon/setup.c
| /<<PKGBUILDDIR>>/arch/mips/cavium-octeon/setup.c: In function 'octeon_kexec_smp_down':
| /<<PKGBUILDDIR>>/arch/mips/cavium-octeon/setup.c:99:2: error: implicit declaration of function 'relocated_kexec_smp_wait'; did you mean 'octeon_kexec_smp_down'? [-Werror=implicit-function-declaration]
|   relocated_kexec_smp_wait(NULL);
|   ^~~~~~~~~~~~~~~~~~~~~~~~
|   octeon_kexec_smp_down
| 
| cc1: some warnings being treated as errors
| make[7]: *** [/<<PKGBUILDDIR>>/scripts/Makefile.build:296: arch/mips/cavium-octeon/setup.o] Error 1
| make[6]: *** [/<<PKGBUILDDIR>>/scripts/Makefile.build:521: arch/mips/cavium-octeon] Error 2

Regards,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
