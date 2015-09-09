Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2015 15:54:09 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:4264 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007048AbbIINyH3JC0S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Sep 2015 15:54:07 +0200
Received: from avionic-0020 (unknown [91.60.5.193])
        (Authenticated sender: albeu@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id AC3084C8032;
        Wed,  9 Sep 2015 15:53:57 +0200 (CEST)
Date:   Wed, 9 Sep 2015 15:53:55 +0200
From:   Alban <albeu@free.fr>
To:     Alexander Couzens <lynxis@fe80.eu>
Cc:     Alban <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: ath79: set missing irq ack handler for
 ar7100-misc-intc irq chip
Message-ID: <20150909155355.7e4b1c76@avionic-0020>
In-Reply-To: <1441790178-9573-2-git-send-email-lynxis@fe80.eu>
References: <1441790178-9573-1-git-send-email-lynxis@fe80.eu>
        <1441790178-9573-2-git-send-email-lynxis@fe80.eu>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49148
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

On Wed,  9 Sep 2015 11:16:17 +0200
Alexander Couzens <lynxis@fe80.eu> wrote:

> The irq ack handler was forgotten while introducing OF support.
> Only ar71xx and ar933x based devices require it.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> ---
>  arch/mips/ath79/irq.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
> index afb0096..c9c0124 100644
> --- a/arch/mips/ath79/irq.c
> +++ b/arch/mips/ath79/irq.c
> @@ -308,8 +308,16 @@ static int __init ath79_misc_intc_of_init(
>  
>  	return 0;
>  }
> -IRQCHIP_DECLARE(ath79_misc_intc, "qca,ar7100-misc-intc",
> -		ath79_misc_intc_of_init);
> +
> +static int __init ar7100_misc_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
> +	return ath79_misc_intc_of_init(node, parent);
> +}
> +
> +IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
> +		ar7100_misc_intc_of_init);
>  
>  static int __init ar79_cpu_intc_of_init(
>  	struct device_node *node, struct device_node *parent)

Acked-by: Alban Bedel <albeu@free.fr>
