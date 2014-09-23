Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 01:56:48 +0200 (CEST)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:41750 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008877AbaIWX4qFlyQq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 01:56:46 +0200
Received: by mail-oi0-f41.google.com with SMTP id u20so5416942oif.14
        for <multiple recipients>; Tue, 23 Sep 2014 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IiESKKAOfEPzw1Oxz82a8AbV2yIceR7E9uGLcZGx1hw=;
        b=fmILcF//HR/aPGDjiCDN0TxakDCAOnYOSOmf6gUNnBrhtUdGYqTXLl+IM9C9C3vSzo
         wBLp8ix6zbwIrjdzYJvrDvddqRb53VvOcW8IgE0blhF15GDpdrvV98cl77C5eZs31Tvl
         ttNaR2kYwp/0LiaYxD3tq11jptcxu6V+Vou5yDo54uIOOVGVlMnl302KlJgi9nWGUdSi
         3HNDM/wnTaOr39XR/4CkZA6TFAnSS0HgqhUwFpxX60T8UOwcKHV0xKLFfHVfC/k10YbK
         RSZcX1EaG1cgzwNgC39r0Aw1NmkTvyr2HC8qbz6C7WjIP7vuu2xPnw/5lZBdAIdqxoLf
         DjKA==
MIME-Version: 1.0
X-Received: by 10.60.134.17 with SMTP id pg17mr578672oeb.55.1411516599676;
 Tue, 23 Sep 2014 16:56:39 -0700 (PDT)
Received: by 10.76.156.70 with HTTP; Tue, 23 Sep 2014 16:56:39 -0700 (PDT)
In-Reply-To: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
References: <1411482607-20948-1-git-send-email-bobby.prani@gmail.com>
Date:   Wed, 24 Sep 2014 03:56:39 +0400
Message-ID: <CAMo8BfKxwq=pc5Lym7X0Qdgmr37jJ-OK_dCmzukkHxtCxz8_7A@mail.gmail.com>
Subject: Re: [PATCH] atomic_read: Use ACCESS_ONCE() instead of cast to volatile
From:   Max Filippov <jcmvbkbc@gmail.com>
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
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
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
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

On Tue, Sep 23, 2014 at 6:29 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
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

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
