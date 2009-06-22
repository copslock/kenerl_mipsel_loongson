Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2009 16:34:40 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60325 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492818AbZFVOec (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Jun 2009 16:34:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5MEVKUG025689;
	Mon, 22 Jun 2009 15:31:20 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5MEVJhe025686;
	Mon, 22 Jun 2009 15:31:19 +0100
Date:	Mon, 22 Jun 2009 15:31:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/2] octeon: flash_setup blows on !MTD_COMPLEX_MAPPINGS
	and !MTD_MAP_BANK_WIDTH_1
Message-ID: <20090622143119.GB25289@linux-mips.org>
References: <200906221115.23628.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906221115.23628.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 22, 2009 at 11:15:23AM +0200, Florian Fainelli wrote:

> diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
> index 008f657..894edbb 100644
> --- a/arch/mips/cavium-octeon/flash_setup.c
> +++ b/arch/mips/cavium-octeon/flash_setup.c
> @@ -41,6 +41,7 @@ static int __init flash_init(void)
>  	 */
>  	union cvmx_mio_boot_reg_cfgx region_cfg;
>  	region_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(0));
> +#if defined (CONFIG_MTD_COMPLEX_MAPPINGS) && (CONFIG_MTD_MAP_BANK_WIDTH_1)
              ^
              no space
                                                ^^^
                                  This should be defined(CONFIG_MTD_...)

Or bad things may happen.

The parenthesis in this expression are unnecessary.

>  	if (region_cfg.s.en) {
>  		/*
>  		 * The bootloader always takes the flash and sets its
> @@ -78,6 +79,7 @@ static int __init flash_init(void)
>  			pr_err("Failed to register MTD device for flash\n");
>  		}
>  	}
> +#endif /* (CONFIG_MTD_COMPLEX_MAPPINGS) && (CONFIG_MTD_MAP_BANK_WIDTH_1) */
>  	return 0;
>  }

  Ralf
