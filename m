Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 10:49:46 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:38279 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011282AbaJVItoGr9X9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 10:49:44 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id BF11628BB4A;
        Wed, 22 Oct 2014 10:48:38 +0200 (CEST)
Received: from dicker-alter.lan (p548C87DD.dip0.t-ipconnect.de [84.140.135.221])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 22 Oct 2014 10:48:38 +0200 (CEST)
Message-ID: <54476FA4.4040303@openwrt.org>
Date:   Wed, 22 Oct 2014 10:49:40 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 04/13] MIPS: ath25: add interrupts handling routines
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com> <1413932631-12866-5-git-send-email-ryazanov.s.a@gmail.com>
In-Reply-To: <1413932631-12866-5-git-send-email-ryazanov.s.a@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi,

just stumbled across this aswell ->

On 22/10/2014 01:03, Sergey Ryazanov wrote:
> +static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc
> *desc) +{ +	u32 pending = ath25_read_reg(AR2315_ISR) &
> ath25_read_reg(AR2315_IMR); +	unsigned base =
> ar2315_misc_irq_base; + +	if (pending & AR2315_ISR_SPI) +
> generic_handle_irq(base + AR2315_MISC_IRQ_SPI); +	else if (pending
> & AR2315_ISR_TIMER) +		generic_handle_irq(base +
> AR2315_MISC_IRQ_TIMER); +	else if (pending & AR2315_ISR_AHB) +
> generic_handle_irq(base + AR2315_MISC_IRQ_AHB); +	else if (pending
> & AR2315_ISR_GPIO) { +		ath25_write_reg(AR2315_ISR,
> AR2315_ISR_GPIO); +		generic_handle_irq(base +
> AR2315_MISC_IRQ_GPIO); +	} else if (pending & AR2315_ISR_UART0) +
> generic_handle_irq(base + AR2315_MISC_IRQ_UART0); +	else if
> (pending & AR2315_ISR_WD) { +		ath25_write_reg(AR2315_ISR,
> AR2315_ISR_WD); +		generic_handle_irq(base +
> AR2315_MISC_IRQ_WATCHDOG); +	} else +		spurious_interrupt(); +} +

please use {} for all or none of the blocks. in this case it needs to
be for all as there are 2 multi-line blocks

looking forward to V3, i think we are getting close now and i can
already see this in 3.19 :)

	John
