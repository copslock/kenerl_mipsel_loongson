Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 17:15:24 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:57873 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009616AbaIWPPWVLYun (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 17:15:22 +0200
Received: from 178-85-85-44.dynamic.upc.nl ([178.85.85.44] helo=worktop)
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1XWRo6-0006ft-V2; Tue, 23 Sep 2014 15:15:11 +0000
Received: by worktop (Postfix, from userid 1000)
        id 0F7036E0B72; Tue, 23 Sep 2014 17:15:09 +0200 (CEST)
Date:   Tue, 23 Sep 2014 17:15:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20140923151509.GI3312@worktop.programming.kicks-ass.net>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Tue, Sep 23, 2014 at 10:29:50AM -0400, Pranith Kumar wrote:
> Use the much reader friendly ACCESS_ONCE() instead of the cast to volatile. This
> is purely a style change.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Looks good to me; I can route it through the locking tree if there's no
objections.
