Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:51:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:26808
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011028AbbGMUvDzCi8V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:51:03 +0200
X-IronPort-AV: E=Sophos;i="5.15,465,1432591200"; 
   d="scan'208";a="139912912"
Received: from ip-65-111-68-50.unsi.net (HELO hadrien.local) ([65.111.68.50])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Jul 2015 22:50:57 +0200
Date:   Mon, 13 Jul 2015 16:50:49 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [patch 04/12] MIPS/pci-rt3883: Consolidate chained IRQ handler
 install/remove
In-Reply-To: <20150713200714.765131309@linutronix.de>
Message-ID: <alpine.DEB.2.10.1507131650110.13108@hadrien>
References: <20150713200602.799079101@linutronix.de> <20150713200714.765131309@linutronix.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia.lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia.lawall@lip6.fr
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



On Mon, 13 Jul 2015, Thomas Gleixner wrote:

> Chained irq handlers usually set up handler data as well. We now have
> a function to set both under irq_desc->lock. Replace the two calls
> with one.

Are the original calls remaining?  If so, should there be a semantic patch
in the kernel to check for this, in case people ut the two calls in teh
future.

julia

>
> Search and conversion was done with coccinelle.
>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/pci/pci-rt3883.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: tip/arch/mips/pci/pci-rt3883.c
> ===================================================================
> --- tip.orig/arch/mips/pci/pci-rt3883.c
> +++ tip/arch/mips/pci/pci-rt3883.c
> @@ -225,8 +225,7 @@ static int rt3883_pci_irq_init(struct de
>  		return -ENODEV;
>  	}
>
> -	irq_set_handler_data(irq, rpc);
> -	irq_set_chained_handler(irq, rt3883_pci_irq_handler);
> +	irq_set_chained_handler_and_data(irq, rt3883_pci_irq_handler, rpc);
>
>  	return 0;
>  }
>
>
>
