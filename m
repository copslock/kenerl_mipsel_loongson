Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 11:31:33 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47347 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011355AbbKQKbbd8bS- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2015 11:31:31 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZydXq-0006lF-FL; Tue, 17 Nov 2015 11:31:26 +0100
Date:   Tue, 17 Nov 2015 11:30:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
In-Reply-To: <564B0064.1060202@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511171130290.3761@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1511071323471.4032@nanos> <5644AC66.2070508@imgtec.com> <alpine.DEB.2.11.1511161817400.3761@nanos>
 <564B0064.1060202@imgtec.com>
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
X-archive-position: 49966
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

On Tue, 17 Nov 2015, Qais Yousef wrote:
> On 11/16/2015 05:24 PM, Thomas Gleixner wrote:
> > 
> > int ipi_get_hw_irq(int irq)
> > {
> > 	struct irq_data *d = irq_get_irq_data(irq);
> > 	return d ? irqd_to_hwirq(d);
> > }
> >   Hmm?
> > 
> 
> We need cpu as an argument too.

Indeed.
 
