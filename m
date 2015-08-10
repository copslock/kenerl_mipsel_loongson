Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2015 20:22:19 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:26750 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010825AbbHJSWRor5CK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Aug 2015 20:22:17 +0200
Received: from tock (unknown [85.176.44.210])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 2676482260;
        Mon, 10 Aug 2015 20:15:47 +0200 (CEST)
Date:   Mon, 10 Aug 2015 20:22:01 +0200
From:   Alban <albeu@free.fr>
To:     Alexander Couzens <lynxis@fe80.eu>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: ath79: add irq chip ar7240-misc-intc
Message-ID: <20150810202201.5e813285@tock>
In-Reply-To: <1438857805-18443-2-git-send-email-lynxis@fe80.eu>
References: <1438857805-18443-1-git-send-email-lynxis@fe80.eu>
        <1438857805-18443-2-git-send-email-lynxis@fe80.eu>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48749
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

On Thu,  6 Aug 2015 12:43:25 +0200
Alexander Couzens <lynxis@fe80.eu> wrote:

> The ar7240 misc irq chip use ack handler instead of ack_mask handler.
> All new ath79 SoCs use the ar7240 misc irq chip

except the ar913x family according to the later documentation.

[...]

> --- a/arch/mips/ath79/irq.c
> +++ b/arch/mips/ath79/irq.c
> @@ -315,8 +315,17 @@ static int __init ar7100_misc_intc_of_init(
>  	return ath79_misc_intc_of_init(node, parent);
>  }
>  
> +static int __init ar7240_misc_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
> +	return ath79_misc_intc_of_init(node, parent);
> +}
> +
>  IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
>  		ar7100_misc_intc_of_init);
> +IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
> +		ar7240_misc_intc_of_init);

It would be better to keep the same formatting as the surrounding code.
Could you keep the IRQCHIP_DECLARE() together with the init function
and remove the extra blank line?

Alban
