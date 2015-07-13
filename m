Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 23:07:19 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:57510 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011028AbbGMVHRuVPxV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 23:07:17 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkwV-000751-83; Mon, 13 Jul 2015 23:07:15 +0200
Date:   Mon, 13 Jul 2015 23:07:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Julia Lawall <julia.lawall@lip6.fr>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [patch 04/12] MIPS/pci-rt3883: Consolidate chained IRQ handler
 install/remove
In-Reply-To: <alpine.DEB.2.10.1507131650110.13108@hadrien>
Message-ID: <alpine.DEB.2.11.1507132304050.20072@nanos>
References: <20150713200602.799079101@linutronix.de> <20150713200714.765131309@linutronix.de> <alpine.DEB.2.10.1507131650110.13108@hadrien>
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
X-archive-position: 48246
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

On Mon, 13 Jul 2015, Julia Lawall wrote:
> On Mon, 13 Jul 2015, Thomas Gleixner wrote:
> 
> > Chained irq handlers usually set up handler data as well. We now have
> > a function to set both under irq_desc->lock. Replace the two calls
> > with one.
> 
> Are the original calls remaining?  If so, should there be a semantic patch
> in the kernel to check for this, in case people ut the two calls in teh
> future.

irq_set_handler_data() can be used in a different context as well.

irq_set_chained_handler() has to stay for now, but we probably can
replace it with irq_set_chained_handler_and_data(irq, handler, NULL).
Have not yet done the analysis.

But yes, a semantic check for this would be nice.

Thanks,

	tglx
