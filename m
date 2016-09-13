Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 21:48:11 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34365 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992285AbcIMTsAr3QDp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Sep 2016 21:48:00 +0200
Received: by mail-pa0-f49.google.com with SMTP id wk8so10587721pab.1
        for <linux-mips@linux-mips.org>; Tue, 13 Sep 2016 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ClsKe9fa/WVKT+kUmo2eKDciQSWaDRedu4W8hbhVE5U=;
        b=rgwDtyXVhG2X3I6g3FhN7GxUrtikMjkwCpmfPE2dDMMQvxkdvZSWlcb2BnGVawVVwO
         RjRWkDwJu58TYnQfatCosKtcOcdw6nfZ0KEaxAfVaIVQ5KySLVfIn98Ze5ISvuv9lKfb
         5FMKTqivCR5XPZUN7kRDQxG1cxypbE+mrHRys2mp+P7r3Ny+LGts0riLYu2r8nqzMvHa
         FjZkDz7caQPxf9QTAdIg0j26iKaCRc6+RwoQnSI7J4ex+ZwrP+6WH3ufJaEhj4yMC45+
         4aKwL6TfYjXaCXMM3n++0I+wQ5W7HwPMkn84OLQnTv0NZDmQ6XAH0ZbExakwIlBTA1+R
         8X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ClsKe9fa/WVKT+kUmo2eKDciQSWaDRedu4W8hbhVE5U=;
        b=e9pW6XmNKd0EkcZt6uNhnezTxekI7TK7H2tncuzw8POlR+43QUOkFv/Wqr/tK1uxJM
         +W2d4++1jr7UZkJ2uLYdXr2Ux5wKDSeuqXzXSNDwcvrxZQz1rt5hlzpaMiQlcSG6AlTO
         +XLlTXwLOL/3Cru8ajAwNisgt8Prme/QHS1cv9EtZUQEycUhtGl9HyPjNVVbzjBljQys
         vjozJkKMtb0iZcsxcPJTSL82guACQ+rnOytHjNDIgU6PchcslxolVExoyE0lBqnK9x1C
         0h44O9nkiZuf2fB7eimGkd9R2UwA49CQhu5ECb2+6D9U3KYaRTaXZOXVvCSL/SUWGO8j
         LfvA==
X-Gm-Message-State: AE9vXwMxh6gIut7v4rmTc0GYlnVy/pIF058vCJjKNEypoLsXuv3Lv6WXXYhFLT67YZJlGQwu
X-Received: by 10.66.16.38 with SMTP id c6mr371389pad.64.1473796072215;
        Tue, 13 Sep 2016 12:47:52 -0700 (PDT)
Received: from localhost (c-98-203-232-209.hsd1.wa.comcast.net. [98.203.232.209])
        by smtp.gmail.com with ESMTPSA id y3sm32922026pfy.36.2016.09.13.12.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2016 12:47:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     kernel-build-reports@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: MIPS build failures in linux-next
Organization: BayLibre
References: <57d7cbc5.c62f1c0a.ad370.89de@mx.google.com>
Date:   Tue, 13 Sep 2016 12:47:49 -0700
In-Reply-To: <57d7cbc5.c62f1c0a.ad370.89de@mx.google.com> (kernelci org bot's
        message of "Tue, 13 Sep 2016 02:49:57 -0700 (PDT)")
Message-ID: <m2k2efy42i.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <khilman@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khilman@baylibre.com
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

Hello MIPS folks,

At kernelci.org, we added MIPS builds to the build testing we're doing,
and there are a handful of build failures in mainline/next for some of
the MIPS upstream defconfigs.

Below is the build report from kernelci.org, but you can also see it on
the web here: https://kernelci.org/build/next/kernel/next-20160913/

Our goal is to have all the upstream defconfigs building with no
errors/warnings, so then we can easily catch any regressions as they're
introduced.

Kevin

kernelci.org bot <bot@kernelci.org> writes:

> next build: 198 builds: 5 failed, 193 passed, 17 errors, 1183 warnings (next-20160913)
>
> Full Build Summary: https://kernelci.org/build/next/kernel/next-20160913/
>
> Tree: next
> Branch: local/master
> Git Describe: next-20160913
> Git Commit: 562d4a2d7fa26b11d995f418951f3396a5d0f550
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> Built: 3 unique architectures
>
> Build Failures Detected:
>
> mips:    gcc version 5.3.0 (Sourcery CodeBench Lite 2016.05-8)
>
>     allnoconfig: FAIL
>     cavium_octeon_defconfig: FAIL
>     loongson1c_defconfig: FAIL
>     malta_qemu_32r6_defconfig: FAIL
>     tinyconfig: FAIL
>
> Errors and Warnings Detected:
>
> arm64:    gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
>
>     allmodconfig: 2 warnings
>
> arm:    gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
>
>     acs5k_defconfig: 6 warnings
>     acs5k_tiny_defconfig: 6 warnings
>     allmodconfig: 8 warnings
>     allnoconfig: 3 warnings
>     am200epdkit_defconfig: 6 warnings
>     aspeed_g4_defconfig: 6 warnings
>     aspeed_g5_defconfig: 6 warnings
>     assabet_defconfig: 6 warnings
>     at91_dt_defconfig: 6 warnings
>     axm55xx_defconfig: 6 warnings
>     badge4_defconfig: 6 warnings
>     bcm2835_defconfig: 3 warnings
>     cerfcube_defconfig: 6 warnings
>     clps711x_defconfig: 3 warnings
>     cm_x2xx_defconfig: 6 warnings
>     cm_x300_defconfig: 6 warnings
>     cns3420vb_defconfig: 6 warnings
>     colibri_pxa270_defconfig: 6 warnings
>     colibri_pxa300_defconfig: 6 warnings
>     collie_defconfig: 3 warnings
>     corgi_defconfig: 6 warnings
>     davinci_all_defconfig: 6 warnings
>     dove_defconfig: 6 warnings
>     ebsa110_defconfig: 6 warnings
>     efm32_defconfig: 3 warnings
>     em_x270_defconfig: 6 warnings
>     ep93xx_defconfig: 6 warnings
>     eseries_pxa_defconfig: 6 warnings
>     exynos_defconfig: 6 warnings
>     ezx_defconfig: 6 warnings
>     footbridge_defconfig: 6 warnings
>     h3600_defconfig: 6 warnings
>     h5000_defconfig: 6 warnings
>     hackkit_defconfig: 6 warnings
>     hisi_defconfig: 3 warnings
>     imote2_defconfig: 6 warnings
>     imx_v4_v5_defconfig: 6 warnings
>     imx_v6_v7_defconfig: 6 warnings
>     integrator_defconfig: 6 warnings
>     iop13xx_defconfig: 6 warnings
>     iop32x_defconfig: 6 warnings
>     iop33x_defconfig: 6 warnings
>     ixp4xx_defconfig: 6 warnings
>     jornada720_defconfig: 6 warnings
>     keystone_defconfig: 6 warnings
>     ks8695_defconfig: 6 warnings
>     lart_defconfig: 6 warnings
>     lpc18xx_defconfig: 3 warnings
>     lpc32xx_defconfig: 6 warnings
>     lpd270_defconfig: 6 warnings
>     lubbock_defconfig: 6 warnings
>     magician_defconfig: 6 warnings
>     mainstone_defconfig: 6 warnings
>     mini2440_defconfig: 6 warnings
>     mmp2_defconfig: 6 warnings
>     moxart_defconfig: 3 warnings
>     mps2_defconfig: 3 warnings
>     multi_v4t_defconfig: 3 warnings
>     multi_v5_defconfig: 6 warnings
>     multi_v7_defconfig: 6 warnings
>     multi_v7_defconfig+CONFIG_ARM_LPAE=y: 6 warnings
>     multi_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y: 6 warnings
>     multi_v7_defconfig+CONFIG_EFI=y: 6 warnings
>     multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y: 6 warnings
>     multi_v7_defconfig+CONFIG_LKDTM=y: 6 warnings
>     multi_v7_defconfig+CONFIG_PROVE_LOCKING=y: 6 warnings
>     multi_v7_defconfig+CONFIG_SMP=n: 6 warnings
>     multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y: 6 warnings
>     mv78xx0_defconfig: 6 warnings
>     mvebu_v5_defconfig: 6 warnings
>     mvebu_v7_defconfig: 6 warnings
>     mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y: 6 warnings
>     mxs_defconfig: 6 warnings
>     neponset_defconfig: 6 warnings
>     netwinder_defconfig: 3 warnings
>     netx_defconfig: 6 warnings
>     nhk8815_defconfig: 6 warnings
>     nuc910_defconfig: 3 warnings
>     nuc950_defconfig: 3 warnings
>     nuc960_defconfig: 3 warnings
>     omap1_defconfig: 6 warnings
>     omap2plus_defconfig: 6 warnings
>     orion5x_defconfig: 6 warnings
>     palmz72_defconfig: 6 warnings
>     pcm027_defconfig: 6 warnings
>     pleb_defconfig: 6 warnings
>     prima2_defconfig: 6 warnings
>     pxa168_defconfig: 6 warnings
>     pxa255-idp_defconfig: 6 warnings
>     pxa3xx_defconfig: 6 warnings
>     pxa910_defconfig: 6 warnings
>     pxa_defconfig: 6 warnings
>     qcom_defconfig: 6 warnings
>     raumfeld_defconfig: 6 warnings
>     realview_defconfig: 6 warnings
>     rpc_defconfig: 6 warnings
>     s3c2410_defconfig: 6 warnings
>     s3c6400_defconfig: 6 warnings
>     s5pv210_defconfig: 6 warnings
>     sama5_defconfig: 6 warnings
>     shannon_defconfig: 6 warnings
>     shmobile_defconfig: 3 warnings
>     simpad_defconfig: 6 warnings
>     socfpga_defconfig: 6 warnings
>     spear13xx_defconfig: 6 warnings
>     spear3xx_defconfig: 6 warnings
>     spear6xx_defconfig: 6 warnings
>     spitz_defconfig: 6 warnings
>     stm32_defconfig: 3 warnings
>     sunxi_defconfig: 6 warnings
>     tct_hammer_defconfig: 6 warnings
>     tegra_defconfig: 6 warnings
>     tinyconfig: 3 warnings
>     trizeps4_defconfig: 6 warnings
>     u300_defconfig: 6 warnings
>     u8500_defconfig: 6 warnings
>     versatile_defconfig: 6 warnings
>     versatile_defconfig+CONFIG_OF_UNITTEST=y: 6 warnings
>     vexpress_defconfig: 6 warnings
>     vf610m4_defconfig: 3 warnings
>     viper_defconfig: 6 warnings
>     vt8500_v6_v7_defconfig: 3 warnings
>     xcep_defconfig: 6 warnings
>     zeus_defconfig: 6 warnings
>     zx_defconfig: 3 warnings
>
> mips:    gcc version 5.3.0 (Sourcery CodeBench Lite 2016.05-8)
>
>     allnoconfig: 3 errors, 3 warnings
>     ar7_defconfig: 7 warnings
>     ath25_defconfig: 6 warnings
>     ath79_defconfig: 6 warnings
>     bcm47xx_defconfig: 6 warnings
>     bcm63xx_defconfig: 3 warnings
>     bigsur_defconfig: 18 warnings
>     bmips_be_defconfig: 3 warnings
>     bmips_stb_defconfig: 3 warnings
>     capcella_defconfig: 7 warnings
>     cavium_octeon_defconfig: 2 errors, 9 warnings
>     ci20_defconfig: 3 warnings
>     cobalt_defconfig: 6 warnings
>     db1xxx_defconfig: 3 warnings
>     decstation_defconfig: 9 warnings
>     defconfig+CONFIG_LKDTM=y: 7 warnings
>     e55_defconfig: 6 warnings
>     fuloong2e_defconfig: 18 warnings
>     gpr_defconfig: 7 warnings
>     ip22_defconfig: 7 warnings
>     ip27_defconfig: 19 warnings
>     ip28_defconfig: 18 warnings
>     ip32_defconfig: 18 warnings
>     jazz_defconfig: 7 warnings
>     jmr3927_defconfig: 3 warnings
>     lasat_defconfig: 3 warnings
>     lemote2f_defconfig: 20 warnings
>     loongson1b_defconfig: 6 warnings
>     loongson1c_defconfig: 6 errors, 3 warnings
>     loongson3_defconfig: 20 warnings
>     malta_defconfig: 6 warnings
>     malta_kvm_defconfig: 6 warnings
>     malta_kvm_guest_defconfig: 6 warnings
>     malta_qemu_32r6_defconfig: 4 errors
>     maltaaprp_defconfig: 6 warnings
>     maltasmvp_defconfig: 6 warnings
>     maltasmvp_eva_defconfig: 6 warnings
>     maltaup_defconfig: 6 warnings
>     maltaup_xpa_defconfig: 6 warnings
>     markeins_defconfig: 6 warnings
>     mips_paravirt_defconfig: 18 warnings
>     mpc30x_defconfig: 6 warnings
>     msp71xx_defconfig: 7 warnings
>     mtx1_defconfig: 7 warnings
>     nlm_xlp_defconfig: 20 warnings
>     nlm_xlr_defconfig: 9 warnings
>     pic32mzda_defconfig: 6 warnings
>     pistachio_defconfig: 6 warnings
>     pnx8335_stb225_defconfig: 6 warnings
>     qi_lb60_defconfig: 6 warnings
>     rb532_defconfig: 6 warnings
>     rbtx49xx_defconfig: 6 warnings
>     rm200_defconfig: 7 warnings
>     rt305x_defconfig: 11 warnings
>     sb1250_swarm_defconfig: 12 warnings
>     sead3_defconfig: 6 warnings
>     sead3micro_defconfig: 6 warnings
>     tb0219_defconfig: 6 warnings
>     tb0226_defconfig: 6 warnings
>     tb0287_defconfig: 6 warnings
>     tinyconfig: 2 errors, 3 warnings
>     workpad_defconfig: 6 warnings
>     xilfpga_defconfig: 3 warnings
>     xway_defconfig: 6 warnings
>
> Errors summary:
>
>       4  mips-linux-gnu-gcc: error: unrecognized command line option '-mcompact-branches=optimal'
>       2  arch/mips/include/asm/mach-cavium-octeon/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift-count-overflow]
>       1  {standard input}:191: Error: number (0x9000000080000000) larger than 32 bits
>       1  {standard input}:164: Error: number (0x9000000080000000) larger than 32 bits
>       1  {standard input}:154: Error: number (0x9000000080000000) larger than 32 bits
>       1  {standard input}:139: Error: number (0x9000000080000000) larger than 32 bits
>       1  {standard input}:131: Error: number (0x9000000080000000) larger than 32 bits
>       1  drivers/clk/clk-ls1x.c:148:29: error: 'BYPASS_DDR_WIDTH' undeclared (first use in this function)
>       1  drivers/clk/clk-ls1x.c:148:11: error: 'BYPASS_DDR_SHIFT' undeclared (first use in this function)
>       1  drivers/clk/clk-ls1x.c:131:28: error: 'BYPASS_DC_WIDTH' undeclared (first use in this function)
>       1  drivers/clk/clk-ls1x.c:131:11: error: 'BYPASS_DC_SHIFT' undeclared (first use in this function)
>       1  drivers/clk/clk-ls1x.c:115:29: error: 'BYPASS_CPU_WIDTH' undeclared (first use in this function)
>       1  drivers/clk/clk-ls1x.c:115:11: error: 'BYPASS_CPU_SHIFT' undeclared (first use in this function)
>
> Warnings summary:
>
>     384  <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     384  <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     384  <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>       8  crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       4  WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-aspeed.o
>       1  drivers/net/ethernet/ti/cpmac.c:1213:2: warning: #warning FIXME: unhardcode gpio&reset bits [-Wcpp]
>       1  drivers/mtd/maps/pmcmsp-flash.c:149:30: warning: passing argument 1 of 'strncpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>       1  crypto/wp512.c:987:1: warning: the frame size of 1568 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       1  crypto/wp512.c:987:1: warning: the frame size of 1504 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       1  crypto/wp512.c:987:1: warning: the frame size of 1264 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       1  crypto/wp512.c:987:1: warning: the frame size of 1128 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       1  crypto/serpent_generic.c:436:1: warning: the frame size of 1472 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       1  crypto/serpent_generic.c:436:1: warning: the frame size of 1456 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       1  arch/mips/ralink/timer.c:74:13: warning: 'rt_timer_free' defined but not used [-Wunused-function]
>       1  arch/mips/ralink/timer.c:104:13: warning: 'rt_timer_disable' defined but not used [-Wunused-function]
>       1  arch/mips/ralink/rt305x.c:92:13: warning: 'rt305x_wdt_reset' defined but not used [-Wunused-function]
>       1  arch/mips/ralink/prom.c:70:2: warning: 'argv' is used uninitialized in this function [-Wuninitialized]
>       1  arch/mips/ralink/prom.c:70:2: warning: 'argc' is used uninitialized in this function [-Wuninitialized]
>       1  arch/mips/netlogic/common/smpboot.S:63: Warning: dla used to load 32-bit register; recommend using la instead
>       1  arch/mips/netlogic/common/smpboot.S:62: Warning: dla used to load 32-bit register; recommend using la instead
>       1  arch/mips/dec/int-handler.S:198: Warning: macro instruction expanded into multiple instructions in a branch delay slot
>       1  arch/mips/dec/int-handler.S:149: Warning: macro instruction expanded into multiple instructions in a branch delay slot
>       1  arch/mips/configs/lemote2f_defconfig:42:warning: symbol value 'm' invalid for CPU_FREQ_STAT
>       1  arch/mips/configs/ip27_defconfig:136:warning: symbol value 'm' invalid for SCSI_DH
>
> ================================================================================
>
> Detailed per-defconfig build reports:
>
> --------------------------------------------------------------------------------
> acs5k_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> acs5k_tiny_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> allmodconfig (arm64) — PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
>     WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-aspeed.o
>     WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-aspeed.o
>
> --------------------------------------------------------------------------------
> allmodconfig (arm) — PASS, 0 errors, 8 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-aspeed.o
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-aspeed.o
>
> --------------------------------------------------------------------------------
> allnoconfig (mips) — FAIL, 3 errors, 3 warnings, 0 section mismatches
>
> Errors:
>     {standard input}:131: Error: number (0x9000000080000000) larger than 32 bits
>     {standard input}:154: Error: number (0x9000000080000000) larger than 32 bits
>     {standard input}:191: Error: number (0x9000000080000000) larger than 32 bits
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> allnoconfig (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> allnoconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> am200epdkit_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ar7_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     drivers/net/ethernet/ti/cpmac.c:1213:2: warning: #warning FIXME: unhardcode gpio&reset bits [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> aspeed_g4_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> aspeed_g5_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> assabet_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> at91_dt_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ath25_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ath79_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> axm55xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> badge4_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> bcm2835_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> bcm47xx_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> bcm63xx_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> bigsur_defconfig (mips) — PASS, 0 errors, 18 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> bmips_be_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> bmips_stb_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> capcella_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> cavium_octeon_defconfig (mips) — FAIL, 2 errors, 9 warnings, 0 section mismatches
>
> Errors:
>     arch/mips/include/asm/mach-cavium-octeon/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift-count-overflow]
>     arch/mips/include/asm/mach-cavium-octeon/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift-count-overflow]
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> cerfcube_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ci20_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> clps711x_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> cm_x2xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> cm_x300_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> cns3420vb_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> cobalt_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> colibri_pxa270_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> colibri_pxa300_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> collie_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> corgi_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> davinci_all_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> db1xxx_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> decstation_defconfig (mips) — PASS, 0 errors, 9 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     arch/mips/dec/int-handler.S:149: Warning: macro instruction expanded into multiple instructions in a branch delay slot
>     arch/mips/dec/int-handler.S:198: Warning: macro instruction expanded into multiple instructions in a branch delay slot
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> defconfig (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> defconfig+CONFIG_CPU_BIG_ENDIAN=y (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> defconfig+CONFIG_EXPERT=y+CONFIG_ACPI=y (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> defconfig+CONFIG_LKDTM=y (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> defconfig+CONFIG_LKDTM=y (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> defconfig+CONFIG_OF_UNITTEST=y (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> defconfig+CONFIG_RANDOMIZE_BASE=y (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> dove_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> e55_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ebsa110_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> efm32_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> em_x270_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ep93xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> eseries_pxa_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> exynos_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ezx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> footbridge_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> fuloong2e_defconfig (mips) — PASS, 0 errors, 18 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> gpr_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> h3600_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> h5000_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> hackkit_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> hisi_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> imote2_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> imx_v4_v5_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> imx_v6_v7_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> integrator_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> iop13xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> iop32x_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> iop33x_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ip22_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ip27_defconfig (mips) — PASS, 0 errors, 19 warnings, 0 section mismatches
>
> Warnings:
>     arch/mips/configs/ip27_defconfig:136:warning: symbol value 'm' invalid for SCSI_DH
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ip28_defconfig (mips) — PASS, 0 errors, 18 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ip32_defconfig (mips) — PASS, 0 errors, 18 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ixp4xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> jazz_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> jmr3927_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> jornada720_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> keystone_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> ks8695_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> lart_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> lasat_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> lemote2f_defconfig (mips) — PASS, 0 errors, 20 warnings, 0 section mismatches
>
> Warnings:
>     arch/mips/configs/lemote2f_defconfig:42:warning: symbol value 'm' invalid for CPU_FREQ_STAT
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1264 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> loongson1b_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> loongson1c_defconfig (mips) — FAIL, 6 errors, 3 warnings, 0 section mismatches
>
> Errors:
>     drivers/clk/clk-ls1x.c:115:11: error: 'BYPASS_CPU_SHIFT' undeclared (first use in this function)
>     drivers/clk/clk-ls1x.c:115:29: error: 'BYPASS_CPU_WIDTH' undeclared (first use in this function)
>     drivers/clk/clk-ls1x.c:131:11: error: 'BYPASS_DC_SHIFT' undeclared (first use in this function)
>     drivers/clk/clk-ls1x.c:131:28: error: 'BYPASS_DC_WIDTH' undeclared (first use in this function)
>     drivers/clk/clk-ls1x.c:148:11: error: 'BYPASS_DDR_SHIFT' undeclared (first use in this function)
>     drivers/clk/clk-ls1x.c:148:29: error: 'BYPASS_DDR_WIDTH' undeclared (first use in this function)
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> loongson3_defconfig (mips) — PASS, 0 errors, 20 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1504 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     crypto/serpent_generic.c:436:1: warning: the frame size of 1456 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> lpc18xx_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> lpc32xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> lpd270_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> lubbock_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> magician_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mainstone_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> malta_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> malta_kvm_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> malta_kvm_guest_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> malta_qemu_32r6_defconfig (mips) — FAIL, 4 errors, 0 warnings, 0 section mismatches
>
> Errors:
>     mips-linux-gnu-gcc: error: unrecognized command line option '-mcompact-branches=optimal'
>     mips-linux-gnu-gcc: error: unrecognized command line option '-mcompact-branches=optimal'
>     mips-linux-gnu-gcc: error: unrecognized command line option '-mcompact-branches=optimal'
>     mips-linux-gnu-gcc: error: unrecognized command line option '-mcompact-branches=optimal'
>
> --------------------------------------------------------------------------------
> maltaaprp_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> maltasmvp_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> maltasmvp_eva_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> maltaup_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> maltaup_xpa_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> markeins_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mini2440_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mips_paravirt_defconfig (mips) — PASS, 0 errors, 18 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mmp2_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> moxart_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mpc30x_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mps2_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> msp71xx_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     drivers/mtd/maps/pmcmsp-flash.c:149:30: warning: passing argument 1 of 'strncpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mtx1_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v4t_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v5_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_ARM_LPAE=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_EFI=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_LKDTM=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_PROVE_LOCKING=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_SMP=n (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mv78xx0_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mvebu_v5_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mvebu_v7_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> mxs_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> neponset_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> netwinder_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> netx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> nhk8815_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> nlm_xlp_defconfig (mips) — PASS, 0 errors, 20 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1568 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     crypto/serpent_generic.c:436:1: warning: the frame size of 1472 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> nlm_xlr_defconfig (mips) — PASS, 0 errors, 9 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     arch/mips/netlogic/common/smpboot.S:62: Warning: dla used to load 32-bit register; recommend using la instead
>     arch/mips/netlogic/common/smpboot.S:63: Warning: dla used to load 32-bit register; recommend using la instead
>     crypto/wp512.c:987:1: warning: the frame size of 1128 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> nuc910_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> nuc950_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> nuc960_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> omap1_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> omap2plus_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> orion5x_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> palmz72_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pcm027_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pic32mzda_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pistachio_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pleb_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pnx8335_stb225_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> prima2_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pxa168_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pxa255-idp_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pxa3xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pxa910_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> pxa_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> qcom_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> qi_lb60_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> raumfeld_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> rb532_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> rbtx49xx_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> realview_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> rm200_defconfig (mips) — PASS, 0 errors, 7 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     crypto/wp512.c:987:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> rpc_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> rt305x_defconfig (mips) — PASS, 0 errors, 11 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     arch/mips/ralink/prom.c:70:2: warning: 'argc' is used uninitialized in this function [-Wuninitialized]
>     arch/mips/ralink/prom.c:70:2: warning: 'argv' is used uninitialized in this function [-Wuninitialized]
>     arch/mips/ralink/timer.c:74:13: warning: 'rt_timer_free' defined but not used [-Wunused-function]
>     arch/mips/ralink/timer.c:104:13: warning: 'rt_timer_disable' defined but not used [-Wunused-function]
>     arch/mips/ralink/rt305x.c:92:13: warning: 'rt305x_wdt_reset' defined but not used [-Wunused-function]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> s3c2410_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> s3c6400_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> s5pv210_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> sama5_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> sb1250_swarm_defconfig (mips) — PASS, 0 errors, 12 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> sead3_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> sead3micro_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> shannon_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> shmobile_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> simpad_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> socfpga_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> spear13xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> spear3xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> spear6xx_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> spitz_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> stm32_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> sunxi_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> tb0219_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> tb0226_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> tb0287_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> tct_hammer_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> tegra_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> tinyconfig (mips) — FAIL, 2 errors, 3 warnings, 0 section mismatches
>
> Errors:
>     {standard input}:139: Error: number (0x9000000080000000) larger than 32 bits
>     {standard input}:164: Error: number (0x9000000080000000) larger than 32 bits
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> tinyconfig (arm64) — PASS, 0 errors, 0 warnings, 0 section mismatches
>
> --------------------------------------------------------------------------------
> tinyconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> trizeps4_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> u300_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> u8500_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> versatile_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> versatile_defconfig+CONFIG_OF_UNITTEST=y (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> vexpress_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> vf610m4_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> viper_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> vt8500_v6_v7_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> workpad_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> xcep_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> xilfpga_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> xway_defconfig (mips) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> zeus_defconfig (arm) — PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> --------------------------------------------------------------------------------
> zx_defconfig (arm) — PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
>     <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
>     <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
>     <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
>
> ---
> For more info write to <info@kernelci.org>
> _______________________________________________
> Kernel-build-reports mailing list
> Kernel-build-reports@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/kernel-build-reports
