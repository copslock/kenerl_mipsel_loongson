Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 10:50:03 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:33639 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025773AbcC3IuBOG5OR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 10:50:01 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1alBp0-0005yH-Kv; Wed, 30 Mar 2016 10:49:50 +0200
Date:   Wed, 30 Mar 2016 10:48:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Ioan Nicu <ioan.nicu.ext@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Uwe Duerr <uwe.duerr.ext@nokia.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: do not change affinity for disabled irqs
In-Reply-To: <56C3C9A4.1040109@gmail.com>
Message-ID: <alpine.DEB.2.11.1603301030270.3978@nanos>
References: <20160215154513.GF25050@ulegcpding.emea.nsn-net.net> <56C3C9A4.1040109@gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52734
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

On Tue, 16 Feb 2016, David Daney wrote:
> On 02/15/2016 07:45 AM, Ioan Nicu wrote:
> > Octeon sets the default irq affinity to value 1 in the early arch init
> > code, so by default all irqs get registered with their affinity set to
> > core 0.
> > 
> > When setting one CPU ofline, octeon_irq_cpu_offline_ciu() calls
> > irq_set_affinity_locked(), but this function sets the IRQD_AFFINITY_SET bit
> > in the irq descriptor. This has the side effect that if one irq is
> > requested later, after putting one CPU offline, the affinity of this irq
> > would not be the default anymore, but rather forced to "all cores - the
> > offline core".
> > 
> > This patch sets the IRQCHIP_ONOFFLINE_ENABLED flag in octeon irq
> > controllers, so that the kernel would call the irq_cpu_[on|off]line()
> > callbacks only for enabled irqs. If some other irq is requested after
> > setting one cpu offline, it would use the default irq affinity, same as it
> > would do in the normal case where there is no CPU hotplug operation.
> > 
> > Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
> > Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> In principle, I don't object.
> 
> I would like to see what tglx has to say about this though.  If we are
> worried about the IRQD_AFFINITY_SET bit, I am not convinced that this is the
> best place to be tweaking code.  Are we papering over something that should
> be handled in a more general manner?  I don't know.

Hmm. Good question. We probably should not set IRQD_AFFINITY_SET when called
from the offline code. The flag was originally meant to preserve user space
affinity settings across request/free_irq.

Though it gets set via irq_set_affinity() as well and therefor via
irq_set_affinity_locked().

Now we could move that IRQD_AFFINITY_SET flip to the user space interface, but
we have to look at all the kernel internal call sites of irq_set_affinity()
and irq_set_affinity_locked() whether any of those relies on affinity settings
being preserved. irq_set_affinity_locked() probably not, as the only non core
user is the octeon code, but you probably can answer that question :)

Thanks,

	tglx
