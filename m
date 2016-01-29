Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 21:45:10 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:56455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011109AbcA2UpGJga2f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 21:45:06 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0MBO57-1aHJH50mYf-00ADaS; Fri, 29 Jan
 2016 21:44:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Marek <mmarek@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date:   Fri, 29 Jan 2016 21:44:13 +0100
Message-ID: <19656457.qoKNGRmV4Q@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAMuHMdX33SQe8n7SRda0TjQV05yP1zbuw129Jqjknt8=CY=LjA@mail.gmail.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <7619136.niuXthzi6R@wuerfel> <CAMuHMdX33SQe8n7SRda0TjQV05yP1zbuw129Jqjknt8=CY=LjA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:DwvTgYTKmxAGRNEaMLa8C2cQ60HRPSDp/yQ8YjdqkTMPI092hEL
 GsVAx3N8bdKxA3koMzfbsWVzLnUTXJIl0xIF50MyX/qzTkqU0g+BqOmB8isymVVh6Uhg4Gn
 E34ekRfx/MoOnsoxz7KCRCLYaTz7siOdjqHJtz13dzWsrDQahLTZkTmRDlYv5FterIrXHcD
 SCd/FgXdGhUw/2EAEoxGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8NQu+JsZMS8=:l1YGVZ6VgRvTd5vHMlxYch
 jd70VgE1AUSrUD/rBUb1RDB918yf1L6/V2BaNgC1pWdbT+xGTCKzbsTNZCfDCtAL/lDjsAuiN
 uNIEKur06vPhR8cYyRKF0c1sKBfkUInIZx8c4B8aNtdiE+H6h4MDrRnAqgaFkG++TS9xON5x0
 duA/qOEaWHFMi4SAA3Kp/+eKOfLxvMWny+sAwI3i/vy05HztoaUOJYktY2aqEsl/t3IbCpLRS
 3h4NqBNl3lrveAuq3hmT5p4oB7xACoQd+yu8Z51Pk92nw89y8BY1p8M/EIBQbUytLq02Ln+MR
 LTUiIyrLeHxIzq4EWVsktEuUjaaRGCq4BxeAwSQFYcTTuj6d0zeVGjmYiRoRFyHDVcduA1usf
 okVXs5jEA9uS/tzPoLs0T3HUIKEE3a4CjPjFWi6ZR9f01GjmYfkDyCFbejqXbETjH49HEBXfm
 prY9Dz+wl1yyPV8VxawTalb8obbTtz7VX7zWUZrY7tC+hYK9KZo/0TQECpu5uO8dBxB9epz1k
 WtoOlxUqR4+vAaRH4KllpYeWBCgpezFuX8op8mmv+1NSmB7b74yiPFI4MnC1apINmjm93oAH0
 9kLQRr7JQ5IYMQI98oVm4H8I6Famn+BXUOS0R8YLYZt7H0Dxw25qRLRUrnL/63KtmorCiNvKs
 hr45EodjVLB7/b6gW4OIrMkBKAAbA0E79CMprhfJJcKl2ioEWkjYdrOuO5x4Jmc9QyAkEb5Un
 pCAT/2cmNYq3A0hd
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51529
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

On Friday 29 January 2016 09:01:31 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Fri, Jan 29, 2016 at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The other related issue is the DEBUG_UART_{VIRT,PHYS} setting,
> > where there is no safe platform-specific default. I have two
> > ideas for working around that, maybe one of them sounds ok to
> > you:
> >
> > a) find a way to warn and/or disable DEBUG_LL when no address
> >    is set, rather than failing the build
> >
> > b) add 'default 0 if COMPILE_TEST' to make it harder to get this
> >    wrong by accident (hopefully nobody tries to run a COMPILE_TEST
> >    kernel). Also maybe add a #warning if DEBUG_UART_VIRT is
> 
> Make sure to add it at the end of the list, so enabling COMPILE_TEST in a
> working .config should give another working .config.

Sure, I've just done a largish series of patches in 4.5 to fix that
bug where we had it already.

> Perhaps you can use 0xdeadbeef instead of 0, and add
> 
>     #if DEBUG_UART_PHYS == 0xdeadbeed
>     #warning Broken value of DEBUG_UART_PHYS.
>     #endif
> 
> somewhere?

I can do that, though I don't see much of an advantage, as zero
is no more likely to be a real address than 0xdeadbeed.

How about the version below?

	Arnd

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c6b6175d0203..6cc09cf8618f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1526,6 +1526,7 @@ config DEBUG_UART_PHYS
 	default 0xfffb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
 	default 0xfffe8600 if DEBUG_BCM63XX_UART
 	default 0xfffff700 if ARCH_IOP33X
+	default 0xdeadbeef if DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || DEBUG_LL_UART_EFM32
 	depends on ARCH_EP93XX || \
 	        DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
@@ -1628,6 +1629,7 @@ config DEBUG_UART_VIRT
 	default 0xff003000 if DEBUG_U300_UART
 	default 0xffd01000 if DEBUG_HIP01_UART
 	default DEBUG_UART_PHYS if !MMU
+	default 0xdeadbeef if DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || DEBUG_LL_UART_EFM32
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_NETX_UART || \
diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
index 7f7446f6f806..1191b1458586 100644
--- a/arch/arm/include/debug/8250.S
+++ b/arch/arm/include/debug/8250.S
@@ -9,6 +9,9 @@
  */
 #include <linux/serial_reg.h>
 
+#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xe0000000
+#include "none.S"
+#else
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
 		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
@@ -55,3 +58,5 @@
 		beq	1001b
 #endif
 		.endm
+
+#endif
diff --git a/arch/arm/include/debug/efm32.S b/arch/arm/include/debug/efm32.S
index 660fa1e4b77b..537021761e4a 100644
--- a/arch/arm/include/debug/efm32.S
+++ b/arch/arm/include/debug/efm32.S
@@ -6,6 +6,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000
+#include "none.S"
+#else
 
 #define UARTn_CMD		0x000c
 #define UARTn_CMD_TXEN			0x0004
@@ -43,3 +46,5 @@
 		tst	\rd, #UARTn_STATUS_TXC
 		bne	1001b
 		.endm
+
+#endif
diff --git a/arch/arm/include/debug/none.S b/arch/arm/include/debug/none.S
new file mode 100644
index 000000000000..75cd1bbee5c4
--- /dev/null
+++ b/arch/arm/include/debug/none.S
@@ -0,0 +1,16 @@
+
+#warning DEBUG_LL not configured, disabling
+
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp, =0
+		ldr	\rv, =0
+		.endm
+
+		.macro	senduart,rd,rx
+		.endm
+
+		.macro	busyuart,rd,rx
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index f7d8323cefcc..fbe0cad32be0 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -10,6 +10,9 @@
  * published by the Free Software Foundation.
  *
 */
+#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000
+#include "none.S"
+#else
 #include <linux/amba/serial.h>
 
 #ifdef CONFIG_DEBUG_ZTE_ZX
@@ -43,3 +46,4 @@
 		tst	\rd, #UART01x_FR_BUSY
 		bne	1001b
 		.endm
+#endif
