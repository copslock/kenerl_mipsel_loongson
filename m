Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 16:29:27 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:54271 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007599AbbLDP3Zwd3L7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 16:29:25 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FC73ABA3;
        Fri,  4 Dec 2015 15:29:25 +0000 (UTC)
Date:   Fri, 4 Dec 2015 16:29:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, linux-cris-kernel@axis.com,
        linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in
 NMI
Message-ID: <20151204152924.GB20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <1449024316.11810.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449024316.11810.6.camel@ellerman.id.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50338
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

On Wed 2015-12-02 13:45:16, Michael Ellerman wrote:
> On Fri, 2015-11-27 at 12:09 +0100, Petr Mladek wrote:
> 
> > printk() takes some locks and could not be used a safe way in NMI
> > context.
> > 
> > The chance of a deadlock is real especially when printing
> > stacks from all CPUs. This particular problem has been addressed
> > on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> > trace on all CPUs").
> 
> ...
> 
> > diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> > new file mode 100644
> > index 000000000000..3989e13a0021
> > --- /dev/null
> > +++ b/kernel/printk/nmi.c
> > @@ -0,0 +1,200 @@
> 
> ...
> 
> > +
> > +struct nmi_seq_buf {
> > +	atomic_t		len;	/* length of written data */
> > +	struct irq_work		work;	/* IRQ work that flushes the buffer */
> > +	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> > +				       sizeof(struct irq_work)];
> > +};
> > +static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
> 
> 
> PAGE_SIZE isn't always 4K.
> 
> On typical powerpc systems this will give you 128K, and on some 512K, which is
> probably not what we wanted.

Good point!

> The existing code just did:
> 
> #define NMI_BUF_SIZE           4096

I will change this to 8192. The 4kB were not enough in some cases.

Best Regards,
Petr
