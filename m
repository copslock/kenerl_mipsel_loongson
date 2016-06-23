Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 20:11:37 +0200 (CEST)
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:30897 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27040905AbcFWSL2p3mEw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 20:11:28 +0200
X-MHO-User: e7c38997-396d-11e6-ac92-3142cfe117f2
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.99.78.160
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.99.78.160])
        by outbound1.eu.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Thu, 23 Jun 2016 18:11:27 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 9224C8002F;
        Thu, 23 Jun 2016 18:11:17 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 9224C8002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1466705477;
        bh=mzLTI3WtTMiwS0kl26tClhLoXeHSyi0xE8U99BxhSl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=vRWPLhbwBx341u+Mu2PX2Pw8YaWrwHdvDjMmzSVKR3NCwPt6KaeUqUee37tpJAugt
         65qoyKi+ysABi96/HQUDoMYSasPObbXQu2kGsPKXr130e9jCeHwnUuJ+pRdKgHxfiN
         u285Urbqrn3TVgeUje300x6mQA+Muqd8xM9tpua3qfn8Pb5gWbWl+0lC1VOtuOex/3
         5vru1Uoma7d117nWWFa+LsxHROxtYk4vw7Cj/WqMUcEa45vke6I1Lxsr9tMbdefzve
         RNrYrQl2+Tu0C9WudyUgSIX02ES3m3ka5ocA8rGVDms7GUMKWRFU50G+OSlJXB5ib0
         MC3nIUgOi165Q==
Date:   Thu, 23 Jun 2016 18:11:17 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Qais Yousef <qsyousef@gmail.com>, g@io.lakedaemon.net
Cc:     Harvey Hunt <harvey.hunt@imgtec.com>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com
Subject: Re: [PATCH] irqchip/mips-gic: Fix IRQs in gic_dev_domain
Message-ID: <20160623181117.GH9922@io.lakedaemon.net>
References: <1464001552-31174-1-git-send-email-harvey.hunt@imgtec.com>
 <CA+mqd+7mh3v-1mk4xpxBjxtt4_JjycisWj6VnV7AaOH=i=y3Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+mqd+7mh3v-1mk4xpxBjxtt4_JjycisWj6VnV7AaOH=i=y3Qw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Qais,

On Tue, May 24, 2016 at 11:43:07AM +0100, Qais Yousef wrote:
> Hmm I certainly did test this on real hardware with GIC. Are you using the
> new dev domain? The idea is that GIC is logically divided and shouldn't be
> used directly. Sorry I'm travelling and can't check the code.

Any update on this patch?  Should I stop tracking it?

thx,

Jason.

> On 23 May 2016 12:06, "Harvey Hunt" <harvey.hunt@imgtec.com> wrote:
> 
> > When allocating a new device IRQ, gic_dev_domain_alloc() correctly calls
> > irq_domain_set_hwirq_and_chip(), but gic_irq_domain_alloc() does not. This
> > means that gic_irq_domain believes all IRQs from the dev domain have an
> > hwirq of 0 and creates incorrect mappings in the linear_revmap. As
> > gic_irq_domain is a parent of the gic_dev_domain, this leads to an
> > inability to boot on devices with a GIC. Excerpt of the error:
> >
> > [    2.297649] irq 0: nobody cared (try booting with the "irqpoll" option)
> > ...
> > [    2.436963] handlers:
> > [    2.439492] Disabling IRQ #0
> >
> > Fix this by calling irq_domain_set_hwirq_and_chip() for both the dev and
> > irq domain.
> >
> > Now that we are modifying the parent domain, be sure to clear it up in
> > case of an allocation error.
> >
> > Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
> > Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
> > Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> > Tested-by: Govindraj Raja <Govindraj.Raja@imgtec.com> # On Pistachio SoC
> > Reviewed-by: Matt Redfearn <matt.redfearn@imgtec.com>
> > Cc: <linux-mips@linux-mips.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > Cc: Qais Yousef <qsyousef@gmail.com>
> > ---
> >  drivers/irqchip/irq-mips-gic.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-mips-gic.c
> > b/drivers/irqchip/irq-mips-gic.c
> > index 4dffccf..40fb120 100644
> > --- a/drivers/irqchip/irq-mips-gic.c
> > +++ b/drivers/irqchip/irq-mips-gic.c
> > @@ -734,6 +734,12 @@ static int gic_irq_domain_alloc(struct irq_domain *d,
> > unsigned int virq,
> >                 /* verify that it doesn't conflict with an IPI irq */
> >                 if (test_bit(spec->hwirq, ipi_resrv))
> >                         return -EBUSY;
> > +
> > +               hwirq = GIC_SHARED_TO_HWIRQ(spec->hwirq);
> > +
> > +               return irq_domain_set_hwirq_and_chip(d, virq, hwirq,
> > +
> > &gic_level_irq_controller,
> > +                                                    NULL);
> >         } else {
> >                 base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
> >                 if (base_hwirq == gic_shared_intrs) {
> > @@ -855,10 +861,14 @@ static int gic_dev_domain_alloc(struct irq_domain
> > *d, unsigned int virq,
> >
> > &gic_level_irq_controller,
> >                                                     NULL);
> >                 if (ret)
> > -                       return ret;
> > +                       goto error;
> >         }
> >
> >         return 0;
> > +
> > +error:
> > +       irq_domain_free_irqs_parent(d, virq, nr_irqs);
> > +       return ret;
> >  }
> >
> >  void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
> > --
> > 2.8.2
> >
> >
