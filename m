Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 22:54:57 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.74]:52295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011231AbcA2VyzmCBjc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 22:54:55 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0LbIy2-1ZePb10r7a-00kv6h; Fri, 29 Jan
 2016 22:54:09 +0100
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
Date:   Fri, 29 Jan 2016 22:54:02 +0100
Message-ID: <4727572.ddrMioV3Fi@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <19656457.qoKNGRmV4Q@wuerfel> <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:8MwsxqK3HlAEI25xJvpxA04oq44XHdAbEHbI3z3/ySwJhj708S7
 Ot3OkLsHIFLO4yW2ZWSyVnE2QZARVpjGJQQS1JQUUiEPF2yvO9wifAK8D7fhpD7PUbvdTvi
 trDELElCzhUpI4z0srQzZJpTLqDlAVetep4A8YYe2bn7b+2SctXjJYhsJ1ICHpEc1eBtNdU
 gaDiQMCk4Pzs84Z49uc9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6zO3R664FxI=:ATf3iaG3u5ZtNaf8sVmlIU
 8MXPFIhsDFztW7fXi30PuGihxG1CzpgMRcQyhoniTn356gTvyBoDwcLkEvmwfmcWrtnk1xrA4
 R64Aj+uC6qBce//10gcdY6FdSL5SInbSCVcRfgPfSkpSx39+aQzvIZiP61HeeAwS78yr9lO29
 nZ29X5z39jl2TjWXF/emZeCBzXOBIf3R7ai8k8Av9xP88/3Q7GSf2p+IaLFfUkaUAQk9kLpqZ
 MTMv0J3o9eQqhR/LDGK/ngBYNXiTsbwtZvwB2A4EcCXJCceHQ3G/oQWQDVPTfhBJTmFZ4qTCt
 +VlkeZeV1SyN8OPMT6u/sRCLSYRlGyG//QT48NXXiIJec7UbISFx4hXyYCeIZhMMFWvdsydOq
 e8pShl3SeBagBU85okOJVH+WPdA8zmn0Wz4JhYzK18LrtdXbG+4CErGGwiDKtHYF3N+mWfimW
 tHMLNtuONoJ7ZChj7YOPZ5TJmBKB0PdVIy3HS1pOJYARkj9iyLIDMLCfXtd3t30JVEBwS0bOW
 4GMd3wYQp++jbhR1vCM6dXFF1JzreYjfGE/SuH4AGjj+ums0gx1rh+yGbpiJBNAzRPPgzXRKZ
 oRD3WVd8C2ox4a8agr/MrGmf34+xhcFaWEmWq36KkNjjOAN7q0/fiKInY3yQCS378t/imw95P
 10sawF2YzUjZYvHeuvxN+UE3vFScCF5xdEyGqZYVp8gMTccUuuIWg1Qs0h9QdOZGasPA/psKz
 0/UtnD4M4/7JDl/v
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51533
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

On Friday 29 January 2016 22:24:31 Geert Uytterhoeven wrote:
> > diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
> > index 7f7446f6f806..1191b1458586 100644
> > --- a/arch/arm/include/debug/8250.S
> > +++ b/arch/arm/include/debug/8250.S
> > @@ -9,6 +9,9 @@
> >   */
> >  #include <linux/serial_reg.h>
> >
> > +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xe0000000
> 
> Any special reason for 0xe0000000 vs ...
> 
> > --- a/arch/arm/include/debug/efm32.S
> > +++ b/arch/arm/include/debug/efm32.S
> > @@ -6,6 +6,9 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   */
> > +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000
> 
> 0xf0000000?

We have one platform that uses a 8250 at address 0xe0010fe0, and one using
the netx UART at virtual address 0xe0000a00, everything else uses 0xf0000000
or higher.

The 0xf0000000 address seems like a better default cutoff, because that
is close to the VMALLOC_START value for systems with 768MB of RAM or more.
Picking a lower number can easily get you in trouble here.

Now that I think about it, I guess platforms that use values above
0xfee00000 can also easily get into trouble as that conflicts with the
PCI I/O space, the fixmap or other special areas documented in
Documentation/arm/memory.txt. We have a bunch of those:

        default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
        default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
        default 0xfee82340 if ARCH_IOP13XX
        default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
        default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
        default 0xfef36000 if DEBUG_HIGHBANK_UART
        default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
        default 0xfefb0800 if DEBUG_OMAP1UART2 || DEBUG_OMAP7XXUART2
        default 0xfefb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
        default 0xfefff700 if ARCH_IOP33X
        default 0xff003000 if DEBUG_U300_UART
        default 0xffd01000 if DEBUG_HIP01_UART

The HIP01 is the only one that looks actively dangerous here (clashes with
fixmap), the others are probably all fine but it would be nice to stay out
of that area completely.

	Arnd
