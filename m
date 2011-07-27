Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 10:41:15 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43124 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491093Ab1G0IlL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2011 10:41:11 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6R8f9dD024917;
        Wed, 27 Jul 2011 09:41:09 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6R8f9hq024915;
        Wed, 27 Jul 2011 09:41:09 +0100
Date:   Wed, 27 Jul 2011 09:41:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [patch 1/7] mips: sibyte: Add missing irq_mask function
Message-ID: <20110727084109.GC23769@linux-mips.org>
References: <20110723123948.573545817@linutronix.de>
 <20110723124015.978127007@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110723124015.978127007@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19491

On Sat, Jul 23, 2011 at 12:41:22PM -0000, Thomas Gleixner wrote:

> Crashes on free_irq() otherwise.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/sibyte/sb1250/irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/mips/sibyte/sb1250/irq.c
> ===================================================================
> --- linux-2.6.orig/arch/mips/sibyte/sb1250/irq.c
> +++ linux-2.6/arch/mips/sibyte/sb1250/irq.c
> @@ -178,7 +178,7 @@ static void ack_sb1250_irq(struct irq_da
>  
>  static struct irq_chip sb1250_irq_type = {
>  	.name = "SB1250-IMR",
> -	.irq_mask_ack = ack_sb1250_irq,
> +	.irq_mask = ack_sb1250_irq,

This conflicts with 1544129da2de9fa276429deed8fac3fbc45634be [MIPS: SB1250:
Restore dropped irq_mask function] which does:

@@ -180,6 +187,7 @@ static struct irq_chip sb1250_irq_type = {
        .name = "SB1250-IMR",
        .irq_mask_ack = ack_sb1250_irq,
        .irq_unmask = enable_sb1250_irq,
+       .irq_mask = disable_sb1250_irq,
 #ifdef CONFIG_SMP
        .irq_set_affinity = sb1250_set_affinity
 #endif

  Ralf
