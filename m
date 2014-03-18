Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 15:59:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60876 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6867486AbaCRO7Se92M0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Mar 2014 15:59:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2IExCkf025172;
        Tue, 18 Mar 2014 15:59:12 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2IExBKS025171;
        Tue, 18 Mar 2014 15:59:11 +0100
Date:   Tue, 18 Mar 2014 15:59:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V19 07/13] MIPS: Loongson 3: Add IRQ init and dispatch
 support
Message-ID: <20140318145911.GE17197@linux-mips.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
 <1392537690-5961-8-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392537690-5961-8-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39495
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

On Sun, Feb 16, 2014 at 04:01:24PM +0800, Huacai Chen wrote:

> +#define LOONGSON_HT1_INT_VECTOR_BASE	(LOONGSON_HT1_CFG_BASE + 0x80)
> +#define LOONGSON_HT1_INT_EN_BASE	(LOONGSON_HT1_CFG_BASE + 0xa0)
> +#define LOONGSON_HT1_INT_VECTOR(n)	\
> +		LOONGSON3_REG32(LOONGSON_HT1_INT_VECTOR_BASE, 4 * n)
> +#define LOONGSON_HT1_INTN_EN(n)		\
> +		LOONGSON3_REG32(LOONGSON_HT1_INT_EN_BASE, 4 * n)

Doing math on macro arguments without parenthesis is dangerous,  please
use (n) instead.

> +
> +#define LOONGSON_INT_ROUTER_OFFSET	0x1400
> +#define LOONGSON_INT_ROUTER_INTEN	\
> +	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x24)
> +#define LOONGSON_INT_ROUTER_INTENSET	\
> +	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x28)
> +#define LOONGSON_INT_ROUTER_INTENCLR	\
> +	  LOONGSON3_REG32(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + 0x2c)
> +#define LOONGSON_INT_ROUTER_ENTRY(n)	\
> +	  LOONGSON3_REG8(LOONGSON3_REG_BASE, LOONGSON_INT_ROUTER_OFFSET + n)
> +#define LOONGSON_INT_ROUTER_LPC		LOONGSON_INT_ROUTER_ENTRY(0x0a)
> +#define LOONGSON_INT_ROUTER_HT1(n)	LOONGSON_INT_ROUTER_ENTRY(n + 0x18)

These two also.

> +static void ht_irqdispatch(void)
> +{
> +	unsigned int i, irq;
> +	unsigned int ht_irq[] = {1, 3, 4, 5, 6, 7, 8, 12, 14, 15};
> +
> +	irq = LOONGSON_HT1_INT_VECTOR(0);
> +	LOONGSON_HT1_INT_VECTOR(0) = irq; /* Acknowledge the IRQs */
> +
> +	for (i = 0; i < ARRAY_SIZE(ht_irq); i++) {
> +		if (irq & (0x1 << ht_irq[i]))
> +			do_IRQ(ht_irq[i]);
> +	}
> +}

Ouch.

Initializing an array like this in C will generate code which at runtime
initializes the ht_irq[] array each time ht_irqdispatch is invoked
and slowing this function to a crawl.

You want to make either move the definition of this array out of the
function body or make it "static const unsigned int ht_irq[] ..." to
avoid this.

  Ralf
