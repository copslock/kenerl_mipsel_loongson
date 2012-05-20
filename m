Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2012 08:14:54 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:43757 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2ETGOu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2012 08:14:50 +0200
Received: by pbbrq13 with SMTP id rq13so6427830pbb.36
        for <linux-mips@linux-mips.org>; Sat, 19 May 2012 23:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=UksB2gkdRA8RXmIF8v0rmt2ZKgjWqezA3VP7NeobPTs=;
        b=niN8e/GRZYerC9D2KwrZbUydPiRhs9fv9jCbvMOTKNl+zFHnUz6s18giMOQVjqTQLm
         JpXBmV41I8ayiKEFJ5NpZPZofbZlFGfhfHBFVeiLbE6Ff0I0Eiaq6pDZNn5+HVY9mwxA
         gQm0ho7AdbflcqhnqZdQ+DjPl/G22x/6faFPoIw1wjCBgkSJyUonak248CDBCmIEu+KW
         UejcBVPw6deQEvmObyLPWgopDnHcCZ56ji4G6jbCiBZtDfkbcmX2ZnsL/GY1laf8uyxD
         eCnqkmj7YirBY8BUfsrnOuvJJZSZWtSPGFLkHVeo8kgydp9KAOgOesHRFQCoay4oWAZ+
         id5w==
Received: by 10.68.240.99 with SMTP id vz3mr55388811pbc.60.1337494483495;
        Sat, 19 May 2012 23:14:43 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id po10sm6748993pbb.21.2012.05.19.23.14.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 23:14:42 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id D5C9B3E03B8; Sun, 20 May 2012 00:14:41 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] eeprom/of: Add device tree bindings to at25.
To:     David Daney <ddaney.cavm@gmail.com>,
        devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Lin <axel.lin@gmail.com>
In-Reply-To: <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com> <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
Date:   Sun, 20 May 2012 00:14:41 -0600
Message-Id: <20120520061441.D5C9B3E03B8@localhost>
X-Gm-Message-State: ALoCoQkI2MX6z6qtNZNptcole45n8fvxoxdNfgd38akZ4SkvXYZdyXeatUi32ZrLhPZAxkYmC7f0
X-archive-position: 33383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 11 May 2012 15:05:23 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> We can extract the "pagesize", "size" and "address-width" from the
> device tree so that SPI eeproms can be fully specified in the device
> tree.
> 
> Also add a MODULE_DEVICE_TABLE so the drivers can be automatically bound.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/misc/eeprom/at25.c |   61 +++++++++++++++++++++++++++++++++++++++++---

Documentation on binding?  It needs to be there before merging.

g.

>  1 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 01ab3c9..609ee72 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/sched.h>
> +#include <linux/of.h>
>  
>  #include <linux/spi/spi.h>
>  #include <linux/spi/eeprom.h>
> @@ -293,6 +294,9 @@ static int at25_probe(struct spi_device *spi)
>  {
>  	struct at25_data	*at25 = NULL;
>  	const struct spi_eeprom *chip;
> +#ifdef CONFIG_OF
> +	struct spi_eeprom of_chip;
> +#endif
>  	int			err;
>  	int			sr;
>  	int			addrlen;
> @@ -300,9 +304,51 @@ static int at25_probe(struct spi_device *spi)
>  	/* Chip description */
>  	chip = spi->dev.platform_data;
>  	if (!chip) {
> -		dev_dbg(&spi->dev, "no chip description\n");
> -		err = -ENODEV;
> -		goto fail;
> +#ifdef CONFIG_OF
> +		if (spi->dev.of_node) {
> +			u32 val;
> +			memset(&of_chip, 0, sizeof(of_chip));
> +			if (of_property_read_u32(spi->dev.of_node, "pagesize", &val)) {
> +				dev_dbg(&spi->dev, "no \"pagesize\" property\n");
> +				err = -ENODEV;
> +				goto fail;
> +			}
> +			of_chip.page_size = val;
> +			if (of_property_read_u32(spi->dev.of_node, "size", &val)) {
> +				dev_dbg(&spi->dev, "no \"size\" property\n");
> +				err = -ENODEV;
> +				goto fail;
> +			}
> +			of_chip.byte_len = val;
> +			if (of_property_read_u32(spi->dev.of_node, "address-width", &val)) {
> +				dev_dbg(&spi->dev, "no \"address-width\" property\n");
> +				err = -ENODEV;
> +				goto fail;
> +			}
> +			switch (val) {
> +			case 8:
> +				of_chip.flags |= EE_ADDR1;
> +				break;
> +			case 16:
> +				of_chip.flags |= EE_ADDR2;
> +				break;
> +			case 24:
> +				of_chip.flags |= EE_ADDR3;
> +				break;
> +			default:
> +				dev_dbg(&spi->dev, "bad \"address-width\" property: %u\n", val);
> +				err = -EINVAL;
> +				goto fail;
> +			}
> +			strlcpy(of_chip.name, spi->dev.of_node->name, sizeof(of_chip.name));
> +			chip = &of_chip;
> +		} else
> +#endif
> +		{
> +			dev_dbg(&spi->dev, "no chip description\n");
> +			err = -ENODEV;
> +			goto fail;
> +		}
>  	}
>  
>  	/* For now we only support 8/16/24 bit addressing */
> @@ -396,11 +442,19 @@ static int __devexit at25_remove(struct spi_device *spi)
>  
>  /*-------------------------------------------------------------------------*/
>  
> +static const struct spi_device_id at25_id[] = {
> +	{"at25", 0},
> +	{"m95256", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, at25_id);
> +
>  static struct spi_driver at25_driver = {
>  	.driver = {
>  		.name		= "at25",
>  		.owner		= THIS_MODULE,
>  	},
> +	.id_table	= at25_id,
>  	.probe		= at25_probe,
>  	.remove		= __devexit_p(at25_remove),
>  };
> @@ -410,4 +464,3 @@ module_spi_driver(at25_driver);
>  MODULE_DESCRIPTION("Driver for most SPI EEPROMs");
>  MODULE_AUTHOR("David Brownell");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("spi:at25");
> -- 
> 1.7.2.3
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
