Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 11:12:36 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013910AbbKQKMdw2Ekr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2015 11:12:33 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZydFQ-0006Tw-NQ; Tue, 17 Nov 2015 11:12:24 +0100
Date:   Tue, 17 Nov 2015 11:11:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domain
In-Reply-To: <564AFC9A.9080505@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511171108500.3761@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1511071323471.4032@nanos> <56407F3C.4060404@imgtec.com> <alpine.DEB.2.11.1511161610070.3761@nanos>
 <564AFC9A.9080505@imgtec.com>
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
X-archive-position: 49963
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
> On 11/16/2015 05:17 PM, Thomas Gleixner wrote:
> > On Mon, 9 Nov 2015, Qais Yousef wrote:
> > > On 11/07/2015 02:51 PM, Thomas Gleixner wrote:
> > > Generally it's hard to know whether a real device is connected to a hwirq
> > > or
> > > not. I am saving a patch where we get a set of free hwirqs from DT as only
> > > the
> > > SoC designer knows what hwirq are actually free and safe to use for IPI.
> > > I'll
> > > send this patch with the DT IPI changes or the rproc driver that I will be
> > > send once these changes are merged.
> > > 
> > > The current code assumes that the last 2 * NR_CPUs hwirqs are always free
> > > to
> > > use for Linux SMP.
> > So what you're saying is that you cannot rely on the last X hwirqs
> > being available for IPIs. That's insane and to my knowledge there is
> > no hardware out there which does not reserve a consecutive IPI space.
> 
> If I read the code you were suggesting correctly, you were trying to fit the
> IPIs in any available non allocated area in the GIC space. What I am trying to
> say is that we can only work on a limited subset of this space that we are
> told explicitly it's safe to use for IPIs. Most likely it's consecutive, but I
> don't feel brave enough to make this assumption personally - maybe I'm over
> paranoid.. I'm more keen on anything that would simplify this patch series now
> though.

Right, I was assuming a consecutive available space and your hardware
folks should really avoid to break that assumption.

Now you still need some DT support to describe the space which is
available for IPIs and that should be part of that series.

> I'll do my best with the next series but maybe we'd need to iterate
> this more than once till I get it right.

Thanks for being patient and persistant on that!

       tglx
