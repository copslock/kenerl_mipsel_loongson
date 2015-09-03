Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2015 12:24:18 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:49884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007425AbbICKYPxjsDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Sep 2015 12:24:15 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29CC875;
        Thu,  3 Sep 2015 03:24:14 -0700 (PDT)
Received: from leverpostej (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C361E3F23A;
        Thu,  3 Sep 2015 03:24:07 -0700 (PDT)
Date:   Thu, 3 Sep 2015 11:23:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Couzens <lynxis@fe80.eu>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: ath79: add irq chip ar7240-misc-intc
Message-ID: <20150903102355.GA10583@leverpostej>
References: <1441251262-13335-1-git-send-email-lynxis@fe80.eu>
 <1441251262-13335-3-git-send-email-lynxis@fe80.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441251262-13335-3-git-send-email-lynxis@fe80.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mark.rutland@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.rutland@arm.com
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

On Thu, Sep 03, 2015 at 04:34:22AM +0100, Alexander Couzens wrote:
> The ar7240 misc irq chip use ack handler
> instead of ack_mask handler. All new ath79 chips use
> the ar7240 misc irq chip
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> ---
>  .../interrupt-controller/qca,ath79-misc-intc.txt       | 18 +++++++++++++++++-
>  arch/mips/ath79/irq.c                                  | 10 ++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-misc-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-misc-intc.txt
> index 391717a..56ccaf3 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-misc-intc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-misc-intc.txt
> @@ -4,7 +4,7 @@ The MISC interrupt controller is a secondary controller for lower priority
>  interrupt.
>  
>  Required Properties:
> -- compatible: has to be "qca,<soctype>-cpu-intc", "qca,ar7100-misc-intc"
> +- compatible: has to be "qca,<soctype>-cpu-intc", "qca,ar{7100,7240}-misc-intc"

Please list those strings separately, in full, such that they can be
searched for. Otherwise the addition looks fine to me.

Mark.

>    as fallback
>  - reg: Base address and size of the controllers memory area
>  - interrupt-parent: phandle of the parent interrupt controller.
> @@ -13,6 +13,9 @@ Required Properties:
>  - #interrupt-cells : Specifies the number of cells needed to encode interrupt
>  		     source, should be 1
>  
> +Compatible fallback depends on the SoC. Use ar7100 for ar71xx and ar913x,
> +use ar7240 for all other SoCs.
> +
>  Please refer to interrupts.txt in this directory for details of the common
>  Interrupt Controllers bindings used by client devices.
>  
> @@ -28,3 +31,16 @@ Example:
>  		interrupt-controller;
>  		#interrupt-cells = <1>;
>  	};
> +
> +Another example:
> +
> +	interrupt-controller@18060010 {
> +		compatible = "qca,ar9331-misc-intc", qca,ar7240-misc-intc";
> +		reg = <0x18060010 0x4>;
> +
> +		interrupt-parent = <&cpuintc>;
> +		interrupts = <6>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
> index 1917f55..7b38958 100644
> --- a/arch/mips/ath79/irq.c
> +++ b/arch/mips/ath79/irq.c
> @@ -320,6 +320,16 @@ static int __init ar7100_misc_intc_of_init(
>  IRQCHIP_DECLARE(ar7100_misc_intc, "qca,ar7100-misc-intc",
>  		ar7100_misc_intc_of_init);
>  
> +static int __init ar7240_misc_intc_of_init(
> +	struct device_node *node, struct device_node *parent)
> +{
> +	ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
> +	return ath79_misc_intc_of_init(node, parent);
> +}
> +
> +IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
> +		ar7240_misc_intc_of_init);
> +
>  static int __init ar79_cpu_intc_of_init(
>  	struct device_node *node, struct device_node *parent)
>  {
> -- 
> 2.4.0
> 
