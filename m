Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 17:09:33 +0100 (CET)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36697 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012815AbbKYQJac3EB7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 17:09:30 +0100
Received: by oiww189 with SMTP id w189so31575675oiw.3;
        Wed, 25 Nov 2015 08:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LM2FRrr4zA3UUuZYAsTcfZTMfv2YNikkb4NIZV+FWh0=;
        b=CISgIV0k0iDxPh/R8OixO8SZj/tkHw4uPbho3GaLnA0uX07bHz/HAZpbBqVHw9Kq2L
         gQX5F6w8fQKcf1s5SCr3PBUCDzVXWLsSbUX5LMg1HRz1D3+gixAGdLDFZnb/3XBnXP2Y
         qvFI7hccTScDPVGv130wy8lwucmlXIW40j/rjReBmlAg8Q3ugV9ysZ/I3XQnq1wdmc+m
         mcmjL7Zrjs2Ig+hsflzxqc2gyBpZmFR9QGsdVpwNeYATJfUCWEznYcVMFILS3PLsi/vs
         vOnN+xlNT7c4KIv1Hllk2iornVhmcjSppN9O1THV5dWzLz84G0CNyg4Tfz5OZncZnums
         bShg==
X-Received: by 10.202.173.17 with SMTP id w17mr23623670oie.52.1448467764573;
        Wed, 25 Nov 2015 08:09:24 -0800 (PST)
Received: from rob-hp-laptop (mobile-166-176-123-126.mycingular.net. [166.176.123.126])
        by smtp.gmail.com with ESMTPSA id k136sm10775632oib.24.2015.11.25.08.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2015 08:09:23 -0800 (PST)
Date:   Wed, 25 Nov 2015 10:09:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 19/19] irqchip/mips-gic: Add new DT property to
 reserve IPIs
Message-ID: <20151125160849.GA21688@rob-hp-laptop>
References: <1448453217-3874-1-git-send-email-qais.yousef@imgtec.com>
 <1448453217-3874-20-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448453217-3874-20-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Nov 25, 2015 at 12:06:57PM +0000, Qais Yousef wrote:
> The new property will allow to specify the range of GIC hwirqs to use for IPIs.
> 
> This is an optinal property. We preserve the previous behaviour of allocating
> the last 2 * gic_vpes if it's not specified or DT is not supported.
> 
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: devicetree@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>

> 
> ---
>  .../devicetree/bindings/interrupt-controller/mips-gic.txt    |  7 +++++++
>  drivers/irqchip/irq-mips-gic.c                               | 12 ++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
> index aae4c384ee1f..173595305e26 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
> @@ -23,6 +23,12 @@ Optional properties:
>  - mti,reserved-cpu-vectors : Specifies the list of CPU interrupt vectors
>    to which the GIC may not route interrupts.  Valid values are 2 - 7.
>    This property is ignored if the CPU is started in EIC mode.
> +- mti,reserved-ipi-vectors : Specifies the range of GIC interrupts that are
> +  reserved for IPIs.
> +  It accepts 2 values, the 1st is the starting interrupt and the 2nd is the size
> +  of the reserved range.
> +  If not specified, the driver will allocate the last 2 * number of VPEs in the
> +  system.
>  
>  Required properties for timer sub-node:
>  - compatible : Should be "mti,gic-timer".
> @@ -44,6 +50,7 @@ Example:
>  		#interrupt-cells = <3>;
>  
>  		mti,reserved-cpu-vectors = <7>;
> +		mti,reserved-ipi-vectors = <40 8>;
>  
>  		timer {
>  			compatible = "mti,gic-timer";
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index c7043a15253b..659fe734d1b7 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -945,6 +945,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
>  			      struct device_node *node)
>  {
>  	unsigned int gicconfig;
> +	unsigned int v[2];
>  
>  	gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
>  
> @@ -1013,8 +1014,15 @@ static void __init __gic_init(unsigned long gic_base_addr,
>  
>  	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
>  
> -	/* Make the last 2 * NR_CPUS available for IPIs */
> -	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * gic_vpes, 2 * gic_vpes);
> +	if (node &&
> +	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", &v, 2)) {
> +		bitmap_set(ipi_resrv, v[0], v[1]);
> +	} else {
> +		/* Make the last 2 * gic_vpes available for IPIs */
> +		bitmap_set(ipi_resrv,
> +			   gic_shared_intrs - 2 * gic_vpes,
> +			   2 * gic_vpes);
> +	}
>  
>  	gic_basic_init();
>  }
> -- 
> 2.1.0
> 
