Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 14:49:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37162 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992155AbdCaMtRKH00Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Mar 2017 14:49:17 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2VCnG2D031556;
        Fri, 31 Mar 2017 14:49:16 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2VCnGNj031555;
        Fri, 31 Mar 2017 14:49:16 +0200
Date:   Fri, 31 Mar 2017 14:49:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: Malta: Fix i8259 irqchip setup
Message-ID: <20170331124916.GB26330@linux-mips.org>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
 <1490958332-31094-2-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490958332-31094-2-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Mar 31, 2017 at 12:05:31PM +0100, Matt Redfearn wrote:

> diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
> index cb675ec6f283..474b372e0dd9 100644
> --- a/arch/mips/mti-malta/malta-int.c
> +++ b/arch/mips/mti-malta/malta-int.c
> @@ -232,6 +232,19 @@ void __init arch_init_irq(void)
>  {
>  	int corehi_irq;
>  
> +#ifdef CONFIG_I8259
> +	/*
> +	 * Preallocate the i8259's expected virq's here. Since irqchip_init()
> +	 * will probe the irqchips in hierarchial order, i8259 is probed last.
> +	 * If anything allocates a virq before the i8259 is probed, it will
> +	 * be given one of the i8259's expected range and consequently setup
> +	 * of the i8259 will fail.
> +	 */
> +	WARN(irq_alloc_descs(I8259A_IRQ_BASE, I8259A_IRQ_BASE,
> +			    16, numa_node_id()) < 0,
> +		"Cannot reserve i8259 virqs at IRQ%d\n", I8259A_IRQ_BASE);
> +#endif /* CONFIG_I8259 */
> +
>  	i8259_set_poll(mips_pcibios_iack);

CONFIG_I8259 is always defined on Malta so the #ifdef is pointless.

  Ralf
