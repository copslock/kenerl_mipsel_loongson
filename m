Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 18:01:30 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51348 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904052Ab1KQRB0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 18:01:26 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAHH1Le0007072;
        Thu, 17 Nov 2011 17:01:22 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAHH1LNH007071;
        Thu, 17 Nov 2011 17:01:21 GMT
Date:   Thu, 17 Nov 2011 17:01:21 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Subject: Re: [PATCH V2 4/6] MIPS: lantiq: add basic support for FALC-ON
Message-ID: <20111117170121.GG26457@linux-mips.org>
References: <1321453698-2598-1-git-send-email-blogic@openwrt.org>
 <1321453698-2598-4-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321453698-2598-4-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14613

On Wed, Nov 16, 2011 at 03:28:16PM +0100, John Crispin wrote:

> +/* global register ranges */
> +extern __iomem void *ltq_ebu_membase;
> +extern __iomem void *ltq_sys1_membase;

extern void __iomem *ltq_ebu_membase;
extern void __iomem *ltq_sys1_membase;

> +#define ltq_ebu_w32(x, y)	ltq_w32((x), ltq_ebu_membase + (y))
> +#define ltq_ebu_r32(x)		ltq_r32(ltq_ebu_membase + (x))
> +#define ltq_ebu_w32_mask(clear, set, reg)   \
> +	ltq_ebu_w32((ltq_ebu_r32(reg) & ~(clear)) | (set), reg)
> +
> +#define ltq_sys1_w32(x, y)	ltq_w32((x), ltq_sys1_membase + (y))
> +#define ltq_sys1_r32(x)		ltq_r32(ltq_sys1_membase + (x))
> +#define ltq_sys1_w32_mask(clear, set, reg)   \
> +	ltq_sys1_w32((ltq_sys1_r32(reg) & ~(clear)) | (set), reg)
> +
> +/* gpio_request wrapper to help configure the pin */
> +extern int  ltq_gpio_request(unsigned int pin, unsigned int mux,
> +				unsigned int dir, const char *name);
> +extern int ltq_gpio_mux_set(unsigned int pin, unsigned int mux);
> +
> +/* to keep the irq code generic we need to define these to 0 as falcon
> +   has no EIU/EBU */
> +#define LTQ_EIU_BASE_ADDR	0
> +#define LTQ_EBU_PCC_ISTAT	0
> +
> +#define ltq_is_ar9()	0
> +#define ltq_is_vr9()	0

These days it is prefered to use inline functions rather than function-like
macro definitions such as these here.

Really, use inline functions unless you have a good reason not to.

  Ralf
