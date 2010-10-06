Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2010 13:21:19 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1490948Ab0JFLVQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Oct 2010 13:21:16 +0200
Date:   Wed, 6 Oct 2010 12:21:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mips: irq: add stackoverflow detection
Message-ID: <20101006112114.GA19856@linux-mips.org>
References: <1286361676-10743-1-git-send-email-jiang.adam@gmail.com>
 <4CAC5537.9040904@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CAC5537.9040904@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 06, 2010 at 02:53:43PM +0400, Sergei Shtylyov wrote:

> >Add stackoverflow detection to mips arch
> 
>    There's no such word: stackoverflow. Space is needed.
> 
> >This is the 3rd version of the smiple patch. 2K is too big for many
> >system, so I Modified the warning line by following Ralf's suggestion.
> 
> >Signed-off-by: Adam Jiang<jiang.adam@gmail.com>
> [...]
> 
> >diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> >index c6345f5..b43edb7 100644
> >--- a/arch/mips/kernel/irq.c
> >+++ b/arch/mips/kernel/irq.c
> >@@ -151,6 +151,28 @@ void __init init_IRQ(void)
> >  #endif
> >  }
> >
> >+#ifdef CONFIG_DEBUG_STACKOVERFLOW
> >+static inline void check_stack_overflow(void)
> >+{
> >+	unsigned long sp;
> >+
> >+	asm volatile("move %0, $sp" : "=r" (sp));
> >+	sp = sp & THREAD_MASK;
> 
>    Why not:
> 
> 	sp &= THREAD_MASK;
> 
>    It's C, after all! :-)

I already had accepted his previous version with minor changes so I've
combined the two.

Thanks Adam!

  Ralf
