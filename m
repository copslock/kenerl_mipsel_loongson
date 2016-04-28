Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 21:16:01 +0200 (CEST)
Received: from ns.horizon.com ([71.41.210.147]:45836 "HELO ns.horizon.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S27027746AbcD1TP7DfAtf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Apr 2016 21:15:59 +0200
Received: (qmail 17439 invoked by uid 1000); 28 Apr 2016 15:15:51 -0400
Date:   28 Apr 2016 15:15:51 -0400
Message-ID: <20160428191551.17438.qmail@ns.horizon.com>
From:   "George Spelvin" <linux@horizon.com>
To:     dalias@libc.org, geert@linux-m68k.org
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Cc:     akpm@linux-foundation.org, davem@davemloft.net, deller@gmx.de,
        ink@jurassic.park.msu.ru, james.hogan@imgtec.com,
        jejb@parisc-linux.org, jonas@southpole.se, lennox.wu@gmail.com,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@arm.linux.org.uk,
        linux@horizon.com, linux@lists.openrisc.net, liqin.linux@gmail.com,
        mattst88@gmail.com, monstr@monstr.eu,
        nios2-dev@lists.rocketboards.org, peterz@infradead.org,
        ralf@linux-mips.org, rth@twiddle.net, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp,
        zengzhaoxiu@163.com, zhaoxiu.zeng@gmail.com
In-Reply-To: <20160428175843.GZ21636@brightrain.aerifal.cx>
Return-Path: <linux@horizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@horizon.com
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

> How does a CPU lack an efficient ffs/ctz anyway? There are all sorts
> of ways to implement it without a native insn, some of which are
> almost or just as fast as the native insn on cpus that have the
> latter. On anything with a fast multiply, the de Bruijn sequence
> approach is near-optimal, and otherwise one of the binary-search type
> approaches (possibly branchless) can be used. If the compiler doesn't
> generate an appropriate one for __builtin_ctz, that's arguably a
> compiler bug.

What's wanted here is something faster than any of those.
Yes, there's a simple constant-time branch-free implementation:

unsigned inline __attribute__((const))
hweight32(uint32_t x)
{
	x -= (x >> 1) & 0x55555555;
	x  = ((x >> 2) & 0x33333333) + (x & 0x33333333);
	x += x >> 4;
	x &= 0x0f0f0f0f;
	x += x >> 8;
	x += x >> 16;
	return x & 63;
}

unsigned inline __attribute__((const))
__ffs32(uint32_t x)
{
	return hweight(~x & (x-1));
}

but if you work it through, that's about 19 instructions; a few more on
platforms without 32-bit immediates.  The shift itself makes an even 20,
and there are a lot of sequential dependencies (I count a 17-op chain
including the shift) limiting execution time.

The de Bruijn hack reduces the length but adds a memory access for
the table lookup.  (http://supertech.csail.mit.edu/papers/debruijn.pdf)

In the GCD code, the number to normalize is basically random, so the
normalization loop shifts an average of 1 bit.  One bit half the time,
a second bit 1/4 of the time, etc.

(The posted code in the FAST_FFS case omits one guaranteed shift at the
end of the loop because the normalization code is constant-time.)

So "fast __ffs" basically means faster than *one* iteration of
"while (!(x & 1)) x >>= 1;".

In this case "fast" means cheaper than *one* unpredictable branch, which
is a very small handful of instructions.
