Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2015 12:17:01 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:44778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009330AbbJLKQ43PMUT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Oct 2015 12:16:56 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZlaA3-0001fE-B1; Mon, 12 Oct 2015 12:16:55 +0200
Date:   Mon, 12 Oct 2015 12:16:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Alex Smith <alex.smith@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] irqchip: irq-mips-gic: Provide function to map
 GIC user section
In-Reply-To: <561B82BA.30809@arm.com>
Message-ID: <alpine.DEB.2.11.1510121155490.6097@nanos>
References: <1443435117-17144-1-git-send-email-markos.chandras@imgtec.com> <1444642843-16375-1-git-send-email-markos.chandras@imgtec.com> <561B82BA.30809@arm.com>
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
X-archive-position: 49488
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

On Mon, 12 Oct 2015, Marc Zyngier wrote:
> On 12/10/15 10:40, Markos Chandras wrote:
> > From: Alex Smith <alex.smith@imgtec.com>
> > 
> > The GIC provides a "user-mode visible" section containing a mirror of
> > the counter registers which can be mapped into user memory. This will
> > be used by the VDSO time function implementations, so provide a
> > function to map it in.

<SNIP>
 
> 
> This looks much better than the previous version (though I cannot find
> the two other patches on LKML just yet).

Yes, it looks better. But I really have to ask the question why we are
trying to pack the world and somemore into an irq chip driver. We
already have the completely misplaced gic_read_count() there.

While I understand that all of this is in the GIC block at least
according to the documentation, technically it's different hardware
blocks. And logically its different as well.

So why not describe the various blocks (interrupt controller, timer,
shadow timer) as separate entities in the device tree and let each
subsystem look them up on their own. This cross subsystem hackery is
just horrible and does not buy anything except merge dependencies and
other avoidable hassle.

Thoughts?

Thanks,

	tglx
