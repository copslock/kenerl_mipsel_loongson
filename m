Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 09:24:29 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:51905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028563AbcEJHYZt3B7F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 09:24:25 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0LsQ2q-1bkBZO4344-01243G; Tue, 10 May
 2016 09:24:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        a.seppala@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Tue, 10 May 2016 09:23:59 +0200
Message-ID: <5347627.S9K7mIusOJ@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1462833472.20290.129.camel@kernel.crashing.org>
References: <4231696.iL6nGs74X8@debian64> <4908563.V9YuKsSrTJ@wuerfel> <1462833472.20290.129.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:9FsbYn38ksggy7UIpMlJQS+3cFZ9aF48ID52GV0UOQE4JeSe4wj
 pIdGeEP31aIGOU9h16XS+28NDGsQ8ECZ73yAlK2Sw3wI/iqznYQZpNRbY0HKtKW++0x1MZw
 nv7SwT9UVGwchV9cOLRizJEWxOG+pKSmx/tTPF9A9ix7BprjW2bvrBlL956iHOBakRtOVX1
 bU5/RoY6M2PygqoOAJu9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L8sdfJiCTBw=:ishWf6Tm6nOtn6W7/evw2h
 bEUNkzqv6N28QRMwZ1HQRRUBrWsCZmsjMLQMRfbwef7oebBGhX1+INXSCJSeyOZ82oGUIdhWd
 +TojDWAw5aL+W1M0uJV9FScT+EQc3gBieYMZwrAtPfQejDOn2GLvFsv47hnRj6CI7YLJEN9Iy
 ug5bkBTzBAmo7gU6/+vMhfzmGbJSzBcaYlOI3mwsWAEdGiARx2GDSSGKycckYTKksnF7IKg38
 oQuFX4tDSOqVlQAZQfPMZjXYYXybl4A9XcMfg8nwjnCXV7+3sAT1K8FliIIj6P5GSm68gvF6T
 mTJkdqXyB08xZXHjQ9UKBHGrSn6zJYm4AqwiIq7u7/Rf39WWDl1mW4FiZfPwZdCvTr3dYUBgk
 zrjZMiP51cEL57J4UU8VgFZllm4Ot6XiU5sZ6WAkEl4x4oJtVKwRulOpHTWNlewjL3m6s9esy
 fb/lP9IZuti2VSQsKIdIyomg19uMLzNqzujjvvV0BYPEfM8RtzSMo6Jr6mvfVdIteJdTE9pcJ
 qPFgi2vs8Az6oYj3CUyHU6lxx/nAQkEHPUtTqBcjeJP+cg0sStBMYg0ZLrH2Y6ig4ilLoqNx4
 ZQnKOwRFdSs/XpSCdn67MIC7tzDsOs6dSyX5juHAi02r6ZR8Oxgq+844VMgle0I3eFK0CReHd
 0kK3pTbuMW0wmmExVqluY0HYd0n1XQaadLDQlq+vpPlKMCwBckXPhrd6ZdupoJmG45eB/vJYN
 Jl6JD8GV0iJMUcII
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53333
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

On Tuesday 10 May 2016 08:37:52 Benjamin Herrenschmidt wrote:
> On Mon, 2016-05-09 at 17:08 +0200, Arnd Bergmann wrote:
> > 
> > Unfortunately, I don't see any way this could be done in MIPS specific
> > code: There is typically a byteswap between the internal bus and the PCI
> > bus on big-endian MIPS systems, so the PCI MMIO ends up being little-endian,
> 
> Ugh ... not exactly, re-watch my talk on the matter :-) While there is
> a specific lane wiring to preserve byte addresss, in the end it's the
> end device itself that is either BE or LE. Regardless of any "bus
> endianness".

I found your slides on

http://www.linuxplumbersconf.org/2012/wp-content/uploads/2012/09/2012-lpc-ref-big-little-endian-herrenschmidt.odp

but there are at least two more twists that you completely missed here:

- Some architectures (e.g. ARMv5 "BE32" mode in IXP4xx, surely some others)
  do not implement big-endian mode by wiring up the data lines between the
  bus and the CPU differently between big- and little-endian mode like
  powerpc and armv7 "BE8" do, but instead they swizzle the *address* lines
  on 8-bit and 16-bit addresses. The effect of that is that normal RAM
  accesses work as expected both ways, and devices that are accessed using
  32-bit MMIO ops never need any byteswap (you actually get "native
  endian") while MMIO with 8 and 16 bit width does something completely
  unexpected and touches the wrong register. Having an explicit byteswap
  on the PCI host bridge gets you the expected addresses again for 8-bit
  cycles but it also means that readl()/writel() again need to swap the
  data.

- Some other architectures (e.g. Broadcom MIPS) apparently are even fancier
  and use a strapping pin on the SoC flips the endianess of the CPU core
  at the same time as all the peripheral MMIO registers, with the intention
  of never requiring any byte swaps. I believe they are implemented careful
  enough to actually get this right, but it confuses the heck out of
  Linux drivers that don't expect this.

> > which matches the expected behavior of readl/writel. However, drivers
> > for non-PCI devices often use the same readl/writel accessors because
> > that is how it's done on ARMv6/ARMv7.
> 
> Even then, you can have on-SoC (non-PCI) devices that also have a
> different endianness from the main CPU. How does it work on ARM for
> example ? The device endianness should be fixed, regardless of the
> endianness of the core, no ?

ARMv6/v7 is uses BE8 mode like powerpc: each peripheral is fixed-endian
and you have to know what it is. Only Freescale managed to put identical
IP blocks on various (powerpc-derived) SoCs and have a subset of them
treat the access as little-endian while others remain big-endian, so all
those drivers now require runtime detection.

> > Doing it hardcoded by architecture is just the simplest way to deal
> > with it, working on the assumption that nothing actually needs the
> > runtime detection that Ben suggested. 
> 
> No, it's not an archicture problem. It's a problem specific to that one
> SoC that the device was synthetized to be a certain endian while it was
> synthetized differently on another SoC... that also happens to be a
> different architecture. But doesn't have to.
> 
> For example, we had in the past cases of both LE and BE EHCI
> implementations on the same architecture (PowerPC).

I understand this, but from what I see in this history of this particular
driver, all ARM and PowerPC implementations chose to use LE registers for
DWC2 because the normal approach for these is to not mess with endianess,
while presumably all MIPS users of the same block wired up the endian-select
line of the IP block to match that of the CPU core, again because it's
what you are expected to do on a MIPS based SoC.

So hardcoding it per architecture would make an assumption based on
the mindset of the SoC designers rather than strict technical differences,
and that can fail as soon as someone does things differently on any of
them (see the Freescale example), but I still think it's the easiest
workaround for backporting to stable kernels. A revert of the original
patch would be even easier, but that would break the one big-endian
MIPS machine we know about.

> > Detecting the endianess of the
> > device is probably the best future-proof solution, but it's also
> > considerably more work to do in the driver, and comes with a
> > tiny runtime overhead.
> 
> The runtime overhead is probably non-measurable compared with the cost
> of the actual MMIOs.

Right. The code size increase is probably measurable (but still small),
the runtime overhead is not.

	Arnd
