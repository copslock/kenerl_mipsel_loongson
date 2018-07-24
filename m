Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 15:23:17 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994272AbeGXNXOimv-7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 15:23:14 +0200
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F8F20852;
        Tue, 24 Jul 2018 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532438588;
        bh=5gMAuvLfwZnQAzioqK7tm85OE6ffyBDtYnpSQyDE6O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQL/j7yHmAr7DiGBY3/zN/coXs8/82ng1Lzyi5zEAAuScUHcEWE+iM0NmJKwLT6RR
         45cYEZcJWx2uFb1TgwXR0YOMvkQnLD0wgD21/FZL0Z1PxMedlinyB6HQ2XmvvGlqSd
         3YX7Dcl2XnUbuxx+hhClPiuERVtn0vC7CT6+Zd6U=
Date:   Tue, 24 Jul 2018 18:52:59 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 03/18] dmaengine: dma-jz4780: Avoid hardcoding number
 of channels
Message-ID: <20180724132259.GF3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721110643.19624-4-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vkoul@kernel.org
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

On 21-07-18, 13:06, Paul Cercueil wrote:

> +static const struct jz4780_dma_soc_data jz4780_dma_soc_data[] = {
> +	[ID_JZ4780] = { .nb_channels = 32, },

why the array of structs?

> +};
> +
> +static const struct of_device_id jz4780_dma_dt_match[] = {
> +	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },

the data should be jz4780_dma_soc_data? as you would add more data
later.. and not the enum..

> -	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
> +	version = (enum jz_version)of_id->data;
> +	soc_data = &jz4780_dma_soc_data[version];

this can be simplified if we do:

        soc_data = device_get_match_data(pdev);

with:

static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
        .nb_channels = 32,
};

and
        { .compatible = "ingenic,jz4780-dma", .data = (void *)jz4780_dma_soc_data },

You add more parameters in future patches and store soc_data in driver
object and use as is..

> +	jzdma = devm_kzalloc(dev, sizeof(*jzdma)
> +				+ sizeof(*jzdma->chan) * soc_data->nb_channels,
> +				GFP_KERNEL);
>  	if (!jzdma)
>  		return -ENOMEM;
>  
> +	jzdma->soc_data = soc_data;
> +	jzdma->version = version;

why do you need to store version, driver should handle values and not
versions..

-- 
~Vinod
