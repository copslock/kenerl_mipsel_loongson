Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 17:40:35 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:57857 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009616AbaIWPk2xvDnm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Sep 2014 17:40:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 1EB112E308;
        Tue, 23 Sep 2014 17:40:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DIPnl3fNFDFP; Tue, 23 Sep 2014 17:40:18 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id 7B2CA2E2E3;
        Tue, 23 Sep 2014 17:40:16 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 60CAACE7;
        Tue, 23 Sep 2014 17:40:16 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 486105DA;
        Tue, 23 Sep 2014 17:40:16 +0200 (CEST)
Received: from lnxjespern2.se.axis.com (lnxjespern2.se.axis.com [10.88.4.6])
        by seth.se.axis.com (Postfix) with ESMTP id 3EE0B3E048;
        Tue, 23 Sep 2014 17:40:16 +0200 (CEST)
Received: by lnxjespern2.se.axis.com (Postfix, from userid 363)
        id 3AF8DC069; Tue, 23 Sep 2014 17:40:16 +0200 (CEST)
Date:   Tue, 23 Sep 2014 17:40:16 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Pranith Kumar <bobby.prani@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
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
        linux-cris-kernel <linux-cris-kernel@axis.com>,
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
Message-ID: <20140923154016.GT18910@axis.com>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
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

On Tue, Sep 23, 2014 at 04:29:50PM +0200, Pranith Kumar wrote:
> Use the much reader friendly ACCESS_ONCE() instead of the cast to volatile. This
> is purely a style change.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/alpha/include/asm/atomic.h    | 4 ++--
>  arch/arm/include/asm/atomic.h      | 2 +-
>  arch/arm64/include/asm/atomic.h    | 4 ++--
>  arch/avr32/include/asm/atomic.h    | 2 +-
>  arch/cris/include/asm/atomic.h     | 2 +-

For the CRIS parts:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
