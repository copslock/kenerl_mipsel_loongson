Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 16:10:24 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:42089 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012743AbbKPPKT0B8ZR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 16:10:19 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZyLQ3-000425-SK; Mon, 16 Nov 2015 16:10:12 +0100
Date:   Mon, 16 Nov 2015 16:09:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 07/14] genirq: Add a new generic IPI reservation code to
 irq core
In-Reply-To: <56407055.6080602@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511161608250.3761@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-8-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1511071427370.4032@nanos> <56407055.6080602@imgtec.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Mon, 9 Nov 2015, Qais Yousef wrote:
> On 11/07/2015 01:31 PM, Thomas Gleixner wrote:
> > On Tue, 3 Nov 2015, Qais Yousef wrote:
> > > +
> > > +	/* always allocate a virq per cpu */
> > > +	nr_irqs = ipi_mask_weight(dest);
> > That's not really a good assumption. Not all architectures need
> > seperate interrupt numbers / descriptors because they can allocate
> > from a per cpu interrupt space. We really want to handle that here as
> > well. So we need a flag in the IPI domain which tells us whether that
> > allocation needs to be weight(desc) or 1.
> 
> OK. But is it bad to always allocate the weight? I thought allocating virqs is
> cheap, or maybe not?

It's wrong to allocate the descriptors in the case of per cpu
interrupts. Aside of wasting memory its not representing what the
hardware does.

Thanks,

	tglx
