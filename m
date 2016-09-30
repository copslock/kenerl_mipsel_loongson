Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2016 20:43:47 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:53176 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993014AbcI3Snj4P7hY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2016 20:43:39 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1bq2mG-00020V-UG; Fri, 30 Sep 2016 20:43:21 +0200
Date:   Fri, 30 Sep 2016 20:41:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] irqchip: i8259: Add domain before mapping parent
 irq
In-Reply-To: <7469373.vRGg21xy4h@np-p-burton>
Message-ID: <alpine.DEB.2.20.1609302040500.5508@nanos>
References: <20160919212132.28893-1-paul.burton@imgtec.com> <20160919212132.28893-2-paul.burton@imgtec.com> <7469373.vRGg21xy4h@np-p-burton>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55306
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

On Fri, 30 Sep 2016, Paul Burton wrote:

> On Monday, 19 September 2016 22:21:18 BST Paul Burton wrote:
> > Mapping the parent IRQ will use a virq number which may conflict with
> > the hardcoded I8259A_IRQ_BASE..I8259A_IRQ_BASE+15 range that the i8259
> > driver expects to be free. If this occurs then we'll hit errors when
> > adding the i8259 IRQ domain, since one of its virq numbers will already
> > be in use.
> > 
> > Avoid this by adding the i8259 domain before mapping the parent IRQ,
> > such that the i8259 virq numbers become used before the parent interrupt
> > controller gets a chance to use any of them.
> 
> Hello,
> 
> Any chance of getting reviews/acks on this & the following 2 patches in the 
> series so Ralf can take them through the MIPS tree? The lack of these (well, 
> patches 1 & 2 anyway) blocks applying many of the Malta patches later in the 
> series.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
