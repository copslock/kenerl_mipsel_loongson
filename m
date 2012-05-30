Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 10:49:00 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:54571 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903550Ab2E3Isz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 May 2012 10:48:55 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4U8msTE009708;
        Wed, 30 May 2012 09:48:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4U8mqUG009707;
        Wed, 30 May 2012 09:48:52 +0100
Date:   Wed, 30 May 2012 09:48:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, sjhill@realitydiluted.com
Subject: Re: [PATCH 2/5] MIPS: Clean-up GIC and vectored interrupts.
Message-ID: <20120530084852.GA9324@linux-mips.org>
References: <1333735140-15719-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1333735140-15719-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33481
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Apr 06, 2012 at 12:59:00PM -0500, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> This change adds macros for routing of GIC interrupts for EIC and
> non-EIC hardware modes. Also added Malta GIC macros having to do
> with performance and timer interrupts.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
> index fb698dc..78dbb8a 100644
> --- a/arch/mips/include/asm/irq.h
> +++ b/arch/mips/include/asm/irq.h
> @@ -136,6 +136,7 @@ extern void free_irqno(unsigned int irq);
>   * IE7.  Since R2 their number has to be read from the c0_intctl register.
>   */
>  #define CP0_LEGACY_COMPARE_IRQ 7
> +#define CP0_LEGACY_PERFCNT_IRQ 7
>  
>  extern int cp0_compare_irq;
>  extern int cp0_compare_irq_shift;

I split of this segment into a separate commit because it appeared to
be unrelated to the rest of the patch and also made use of the symbol
in traps.c.

Thanks,

  Ralf
