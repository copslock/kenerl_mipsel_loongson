Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 22:25:12 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:50913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011927AbaKPVZLTg6hH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 22:25:11 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue005) with ESMTP (Nemesis)
        id 0MHttJ-1XokP43pt7-003hvS; Sun, 16 Nov 2014 22:24:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     ralf@linux-mips.org, f.fainelli@gmail.com, jfraser@broadcom.com,
        dtor@chromium.org, tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
Date:   Sun, 16 Nov 2014 22:24:55 +0100
Message-ID: <50587083.ieLlCR4VrM@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1416097066-20452-23-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com> <1416097066-20452-23-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:EfnFpqSsvM7/FIqtJxyeZ/sMme5kVi9MoDjgTiESY7X
 E2gH6ZJEL8jpn4VfSA26y1z0YAYahENpWFmTBMV5BTDR2BYcxv
 5pHhi7Tzs9r46cRWw8WYj3aZ2DxhjlF+KBtJF8WxRueOjrTjNQ
 gZtMl8Q+P3V6Exujn1k6n5kb7BYPOKctsNJD78pKvIPQh4VkSt
 Icbhi3wW4B4OL3igDNnx4+vJ8m3DpSLZ49bYoWodD+vGPORdWn
 /60g8Ywm4Fyc8GIbRxeGlT6/3KavwcM1/Zzv1iP7d7H/EOBv05
 +Zr2ZG7kpcS/eFLVpuh+BT6uxKx7h6JPXBKVgP8Bm/uZ3CuuPQ
 XQ94ZdgulitnRGhHF5QE=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Saturday 15 November 2014 16:17:46 Kevin Cernekee wrote:
> +config BMIPS_MULTIPLATFORM
> +       bool "Broadcom BCM33xx/BCM63xx/BCM7xxx multiplatform kernel"
> +       select BOOT_RAW
> +       select NO_EXCEPT_FILL
> +       select USE_OF
> +       select BUILTIN_DTB
> +       select FW_CFE
> +       select CEVT_R4K
> +       select CSRC_R4K
> +       select SYNC_R4K
> +       select COMMON_CLK
> +       select BCM7038_L1_IRQ
> +       select BCM7120_L2_IRQ
> +       select BRCMSTB_L2_IRQ
> +       select IRQ_CPU
> +       select RAW_IRQ_ACCESSORS
> +       select DMA_NONCOHERENT
> +       select SYS_SUPPORTS_32BIT_KERNEL
> +       select SYS_SUPPORTS_LITTLE_ENDIAN
> +       select SYS_SUPPORTS_BIG_ENDIAN
> +       select SYS_SUPPORTS_HIGHMEM
> +       select SYS_HAS_CPU_BMIPS3300
> +       select SYS_HAS_CPU_BMIPS4350
> +       select SYS_HAS_CPU_BMIPS4380
> +       select SYS_HAS_CPU_BMIPS5000
> +       select SWAP_IO_SPACE
> +       select USB_EHCI_BIG_ENDIAN_DESC
> +       select USB_EHCI_BIG_ENDIAN_MMIO
> +       select USB_OHCI_BIG_ENDIAN_DESC
> +       select USB_OHCI_BIG_ENDIAN_MMIO

You mentioned in another thread that all MMIO is byteswapped based on the
jumper setting. Should the USB options have an 'if CPU_BIG_ENDIAN'
behind them? I think it will still work in the current way, but when you
know that you have little-endian registers, it is more efficient
not to set these.

> +       help
> +         Build a multiplatform DT-based kernel image that boots on select
> +         BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
> +         box chips.  Note that CONFIG_CPU_BIG_ENDIAN/CONFIG_CPU_LITTLE_ENDIAN
> +         must be set appropriately for your board, and the dts/dtsi files may
> +         require changes based on the system endianness.
> 

Can you clarify the meaning of "multiplatform" here? I suspect you
mean that this is one platform that includes multiple SoCs that
are all made by the same manufacturer and based on the same CPU
core family, but it is still incompatible with other Vendor's SoCs
and with Broadcom MIPS SoCs that are based on 74K or other cores, right?

It's probably not a wrong description here, but for anybody reading this
who also works on ARM, it seems rather confusing because there,
"multiplatform" implies that the particular SoC can be built into a
generic kernel image that supports SoCs from any vendor whose platform
is also marked as "multiplatform", as long as the CPU architecture level
(v4/v5, or v6/v7, or v8) is the same.

	Arnd
