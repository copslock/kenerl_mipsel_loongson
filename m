Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Sep 2015 16:03:47 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:38051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009069AbbI3ODnAEKAK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Sep 2015 16:03:43 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZhHyr-0002D6-L3; Wed, 30 Sep 2015 16:03:37 +0200
Date:   Wed, 30 Sep 2015 16:03:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qais Yousef <qais.yousef@imgtec.com>
cc:     Jiang Liu <jiang.liu@linux.intel.com>,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] Implement generic IPI support mechanism
In-Reply-To: <560BE4F3.7060607@imgtec.com>
Message-ID: <alpine.DEB.2.11.1509301602160.4500@nanos>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com> <5602D958.6000003@linux.intel.com> <5603B6CA.7050601@imgtec.com> <alpine.DEB.2.11.1509292101420.4500@nanos> <560BE4F3.7060607@imgtec.com>
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
X-archive-position: 49406
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

On Wed, 30 Sep 2015, Qais Yousef wrote:

> On 09/29/2015 09:48 PM, Thomas Gleixner wrote:
> > 
> > 	 Now how these hwirqs are allocated is a domain/architecture
> > 	 specific issue.
> > 
> > 	 x86 will just find a vector which is available on all target
> > 	 cpus and mark it as used. That's a single hw irq number.
> > 
> > 	 mips and others, which implement IPIs as regular hw interrupt
> > 	 numbers, will allocate a these (consecutive) hw interrupt
> > 	 numbers either from a reserved region or just from the
> > 	 regular space. That's a bunch of hw irq numbers and we need
> > 	 to come up with a proper storage format in the irqdata for
> > 	 that. That might be
> > 
> > 	       struct ipi_mapping {
> > 		      unsigned int	nr_hwirqs;
> > 		      unsigned int	cpumap[NR_CPUS];
> > 	       };
> 
> Can we use NR_CPUS here? If we run in UP configuration for instance, this will
> be one. The coprocessor could be outside the NR_CPUS range in general, no?
> 
> How about
> 
>                         struct ipi_mapping {
>                                 unsigned int        nr_hwirqs;
>                                 unsigned int        nr_cpus;
>                                 unsigned int        *cpumap;
>                         }
> 
> where cpumap is dynamically allocated by the controller which has better
> knowledge about the supported cpu range it can talk to?

Sure. As I said: 'That might be' ....
 
Thanks,

	tglx
