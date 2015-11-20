Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 21:40:10 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:54430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012873AbbKTUkJSTWuB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2015 21:40:09 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZzsTS-000550-N9; Fri, 20 Nov 2015 21:40:02 +0100
Date:   Fri, 20 Nov 2015 21:39:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, jiang.liu@linux.intel.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 10/14] irqchip/mips-gic: Add a IPI hierarchy domaind
In-Reply-To: <564EFA74.90606@imgtec.com>
Message-ID: <alpine.DEB.2.11.1511202113010.3931@nanos>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com> <1446549181-31788-11-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1511071323471.4032@nanos> <56407F3C.4060404@imgtec.com> <alpine.DEB.2.11.1511161610070.3761@nanos>
 <564EFA74.90606@imgtec.com>
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
X-archive-position: 50006
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

Qais,

On Fri, 20 Nov 2015, Qais Yousef wrote:
> On 11/16/2015 05:17 PM, Thomas Gleixner wrote:
> > 1) IPI as per_cpu interrupts
> > 
> >     Single hwirq represented by a single irq descriptor
> > 
> > 2) IPI with consecutive mapping space
> > 
> >     No extra mapping from virq base to target cpu required as its just
> >     linear. Everything can be handled via the base virq.
> > 
> 
> 
> I think I am seeing a major issue with this approach.
> 
> Take the case where we reserve an IPI with ipi_mask that has cpu 5 and 6 set
> only. When allocating a per_cpu or consectuve mapping, we will require 2
> consecutive virqs and hwirqs. But since the cpu location is not starting from
> 0, we can't use the cpu as an offset anymore.
> 
> So when a user wants to send an IPI to cpu 6 only, the code can't easily tell
> what's the correct offset from base virq or hwirq to use.

Well, you can store the start offset easily and subtract it. It's 0
for most of the cases.

> Same applies when doing the reverse mapping.
> 
> In other words, the ipi_mask won't always necessarily be linear to facilitate
> the 1:1 mapping that this approach assumes.
> 
> It is a solvable problem, but I think we're losing the elegance that promoted
> going into this direction and I think sticking to using struct ipi_mapping
> (with some enhancements to how it's exposed an integrated by/into generic
> code) is a better approach.

The only reason to use the ipi_mapping thing is if we need non
consecutive masks, i.e. cpu 5 and 9.

I really don't want to have it mandatory as it does not make any sense
for systems where the IPI is a single per_cpu interrupt. For the
linear consecutive space it is just adding memory and cache footprint
for no benefit. Think about machines with 4k and more cpus ....

If you make ipi_mapping in a way that it can express the per_cpu,
linear and scattered mappings, then we should be fine. The extra
conditional you need in send_ipi() is not a problem.

Thanks,

	tglx
