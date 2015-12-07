Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 15:16:52 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:53503 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010130AbbLGOQuFoLvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Dec 2015 15:16:50 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A927E75015;
        Mon,  7 Dec 2015 14:16:48 +0000 (UTC)
Date:   Mon, 7 Dec 2015 15:16:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     yalin wang <yalin.wang2010@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
Message-ID: <20151207141646.GF20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
 <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

On Mon 2015-11-30 08:42:04, yalin wang wrote:
> 
> > On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> > 
> > Testing has shown that the backtrace sometimes does not fit
> > into the 4kB temporary buffer that is used in NMI context.
> > 
> > The warnings are gone when I double the temporary buffer size.
> > 
> > Note that this problem existed even in the x86-specific
> > implementation that was added by the commit a9edc8809328
> > ("x86/nmi: Perform a safe NMI stack trace on all CPUs").
> > Nobody noticed it because it did not print any warnings.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> > kernel/printk/nmi.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> > index 8af1e4016719..6111644d5f01 100644
> > --- a/kernel/printk/nmi.c
> > +++ b/kernel/printk/nmi.c
> > @@ -42,7 +42,7 @@ atomic_t nmi_message_lost;
> > struct nmi_seq_buf {
> > 	atomic_t		len;	/* length of written data */
> > 	struct irq_work		work;	/* IRQ work that flushes the buffer */
> > -	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> > +	unsigned char		buffer[2 * PAGE_SIZE - sizeof(atomic_t) -
> > 				       sizeof(struct irq_work)];
> > };
> > 
> 
> why not define like this:
> 
> union {
> struct {atomic_t		len;	
> 	struct irq_work		work;
> }
> unsigned char		buffer[PAGE_SIZE * 2] ;
> }
> 
> we can make sure the union is 2 PAGE_SIZE .

IMHO, this would add more confusion. It would just move the
computation somewhere else. The union will have 2*PAGE_SIZE
but the beginning of "buffer" will be shared with "len"
and "work". Therefore, we would need to skip the beginning
of the buffer when storing the data. By other words, we still
will be able to use only (sizeof(buffer) - sizeof(atomic_t) -
sizeof(struct irq_work)] of the "buffer".

Or did I miss something, please?

Best Regards,
Petr
