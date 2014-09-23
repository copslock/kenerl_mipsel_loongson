Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 21:47:14 +0200 (CEST)
Received: from cassarossa.samfundet.no ([193.35.52.29]:53905 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009414AbaIWTrLvpZzQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 21:47:11 +0200
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.80)
        (envelope-from <egtvedt@samfundet.no>)
        id 1XWVzj-0007wo-Um; Tue, 23 Sep 2014 21:43:27 +0200
Date:   Tue, 23 Sep 2014 21:43:27 +0200
From:   Hans-Christian Egtvedt <egtvedt@samfundet.no>
To:     Pranith Kumar <bobby.prani@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        David Howells <dhowells@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chen Gang <gang.chen@asianux.com>,
        Victor Kamensky <victor.kamensky@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:CRIS PORT" <linux-cris-kernel@axis.com>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        "moderated list:M32R ARCHITECTURE" <linux-m32r@ml.linux-m32r.org>,
        "open list:M32R ARCHITECTURE" <linux-m32r-ja@ml.linux-m32r.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>,
        "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] atomic_read: Use ACCESS_ONCE() instead of cast to
 volatile
Message-ID: <20140923194327.GA5940@samfundet.no>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <egtvedt@samfundet.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: egtvedt@samfundet.no
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

Around Tue 23 Sep 2014 10:29:50 -0400 or thereabout, Pranith Kumar wrote:
> Use the much reader friendly ACCESS_ONCE() instead of the cast to volatile. This
> is purely a style change.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/alpha/include/asm/atomic.h    | 4 ++--
>  arch/arm/include/asm/atomic.h      | 2 +-
>  arch/arm64/include/asm/atomic.h    | 4 ++--
>  arch/avr32/include/asm/atomic.h    | 2 +-

For the AVR32 related part.

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

>  arch/cris/include/asm/atomic.h     | 2 +-
>  arch/frv/include/asm/atomic.h      | 2 +-
>  arch/ia64/include/asm/atomic.h     | 4 ++--
>  arch/m32r/include/asm/atomic.h     | 2 +-
>  arch/m68k/include/asm/atomic.h     | 2 +-
>  arch/mips/include/asm/atomic.h     | 4 ++--
>  arch/parisc/include/asm/atomic.h   | 4 ++--
>  arch/sh/include/asm/atomic.h       | 2 +-
>  arch/sparc/include/asm/atomic_32.h | 2 +-
>  arch/sparc/include/asm/atomic_64.h | 4 ++--
>  arch/x86/include/asm/atomic.h      | 2 +-
>  arch/x86/include/asm/atomic64_64.h | 2 +-
>  arch/xtensa/include/asm/atomic.h   | 2 +-
>  include/asm-generic/atomic.h       | 2 +-
>  18 files changed, 24 insertions(+), 24 deletions(-)

<snipp diff>

-- 
BR, HcE
