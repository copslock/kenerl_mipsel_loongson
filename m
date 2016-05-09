Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 17:09:22 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.73]:52243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028304AbcEIPJUpg2cO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 17:09:20 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0Lkxnh-1baE9D19pF-00ajXf; Mon, 09 May
 2016 17:08:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, benh@au1.ibm.com,
        linux-mips@linux-mips.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, a.seppala@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Mon, 09 May 2016 17:08:48 +0200
Message-ID: <4908563.V9YuKsSrTJ@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <8737prikg9.fsf@intel.com>
References: <4231696.iL6nGs74X8@debian64> <4162108.qmr2GZCaDN@wuerfel> <8737prikg9.fsf@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:ECbGoHFWa+PoVDX5HbFDQgsMj5Of9IGBZW+nRC8XrfX/5wP4ewr
 TwPdRFn6UqRuEvyuagwq7228/uvmptyN0y//lUd2kcAD10f43r8xbi2VBzrKYPaRu8q+EwJ
 KBhDcObvSAUeNMu/SyyTn40JP4SovRRT6LB9v/Zlg31KXyRKT0BYbNx89WbQUFRJRjPZlZ7
 mVP51fqikOxB0p6igBx1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w5Scmjev0tk=:aRdVkpWI6n1YUJJfo1ed8q
 axwR1lTBQgOIPvPNmCG6nBErKZIRwZiYOnKgOUDg+W9u3yyNLJYJ7fgTJJLM+xVND5pfwOIwQ
 TFd3QLXIlBXPnjPzV+QaqOymoLk6G/RjbiFRon4tQ+I9+UTAsPhLjcg97r28puZbHO/vFlKJ5
 zNIl3WNPCBI6DBj8zjhN7s/J3L4SrClaC3CQowQN0A1Xr6UikvzSpaZ08o3vyW7ER5G3qaAza
 Z1QI0m0KwrEmz/1AlJlK0Wf1sFBfwf3WowZbjnJ0Dz+rQthW19OqCM3GGbWef1YuEC9a3BCkF
 wMxt1BEKICpT4nWEiNpgemrzvtVssitAGTfxJVjfWsbOHqJxJnUsh6yVgVLYVpboR6+jDGf3v
 M/5lh8TaBN9aE3NT5Ld0qtGFy9JFN/UeuGcMjICVKimz+6QT/bINM6srcZCwDPT0iKZVH6FxK
 daQwEJa0Z1dpL4BjJX8B/goKAgsj1Iv87jmRo/k6meOtCvbuxhWJMecjZ4IZwDbIxhLeFD3hN
 g8cC67fT++bFjWr65Sh2rHG3gjgvl3i09VjCR7/sBXwDrnHehoZ6RqF/4svi/eZZOhhyk5adG
 oksQB7XNf645CUulC2b5lt3+uMF4ElhYrRswPWt9lknRPF1Le815N44cQt8eRRH3+SqzfkEvp
 /HoIpIvksC5t5nZKKpK/LQQZgQU/PfhH07X53Nzx5RTHUP9vXis1D8MnDXUUGidD2b6XX8zwz
 O5oLDL7JNgdlZeW+
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53313
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

On Monday 09 May 2016 13:39:50 Felipe Balbi wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
> >> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
> >
> > The patch that caused the problem had multiple issues:
> >
> > - it broke big-endian ARM kernels: any machine that was working
> >   correctly with a little-endian kernel is no longer using byteswaps
> >   on big-endian kernels, which clearly breaks them.
> > - On PowerPC the same thing must be true: if it was working before,
> >   using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
> >   usually uses big-endian kernels, so they are likely all broken.
> > - The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
> >   so the MMIO no longer synchronizes with DMA operations.
> > - On architectures that require specific CPU instructions for MMIO
> >   access, using the __raw_ variant may turn this into a pointer
> >   dereference that does not have the same effect as the readl/writel.
> >
> > I think we can simply make this set of accessors architecture-dependent
> > (MIPS vs. the rest of the world) to revert ARM and PowerPC back to
> > the working version.
> 
> and patch all drivers similarly? Shouldn't arch/mips itself deal with it
> and hide it from drivers ?
> 

Unfortunately, I don't see any way this could be done in MIPS specific
code: There is typically a byteswap between the internal bus and the PCI
bus on big-endian MIPS systems, so the PCI MMIO ends up being little-endian,
which matches the expected behavior of readl/writel. However, drivers
for non-PCI devices often use the same readl/writel accessors because
that is how it's done on ARMv6/ARMv7.

Doing it hardcoded by architecture is just the simplest way to deal
with it, working on the assumption that nothing actually needs the
runtime detection that Ben suggested. Detecting the endianess of the
device is probably the best future-proof solution, but it's also
considerably more work to do in the driver, and comes with a
tiny runtime overhead.

	Arnd
