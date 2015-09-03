Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2015 10:33:01 +0200 (CEST)
Received: from smtp3-g21.free.fr ([212.27.42.3]:29664 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007414AbbICIc7b7KeR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Sep 2015 10:32:59 +0200
Received: from avionic-0020 (unknown [91.60.10.250])
        (Authenticated sender: albeu@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id D3DCCA624F;
        Thu,  3 Sep 2015 10:32:48 +0200 (CEST)
Date:   Thu, 3 Sep 2015 10:32:45 +0200
From:   Alban <albeu@free.fr>
To:     Alexander Couzens <lynxis@fe80.eu>
Cc:     Alban <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: ath79: set missing irq ack handler for
 ar7100-misc-intc irq chip
Message-ID: <20150903103245.21dc9dd7@avionic-0020>
In-Reply-To: <1441251262-13335-2-git-send-email-lynxis@fe80.eu>
References: <1441251262-13335-1-git-send-email-lynxis@fe80.eu>
        <1441251262-13335-2-git-send-email-lynxis@fe80.eu>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Thu,  3 Sep 2015 05:34:21 +0200
Alexander Couzens <lynxis@fe80.eu> wrote:

> The irq ack handler was forgotten while introducing OF support.
> Only ar71xx and ar933x based devices require it.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> ---
>  arch/mips/ath79/irq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
> index afb0096..1917f55 100644
> --- a/arch/mips/ath79/irq.c
> +++ b/arch/mips/ath79/irq.c
> @@ -308,8 +308,17 @@ static int __init ath79_misc_intc_of_init(
>  
>  	return 0;
>  }
> -IRQCHIP_DECLARE(ath79_misc_intc, "qca,ar7100-misc-intc",
> -		ath79_misc_intc_of_init);
> +
> +static int __init ar7100_misc_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	pr_info("IRQ: Setup ar7100 misc IRQ controller from devicetree.\n");

Debug left over?

> +	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
> +	return ath79_misc_intc_of_init(node, parent);
> +}
> +
> +IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
> +		ar7100_misc_intc_of_init);
>  
>  static int __init ar79_cpu_intc_of_init(
>  	struct device_node *node, struct device_node *parent)

Otherwise that looks good.

Alban
