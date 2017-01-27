Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2017 18:33:24 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40656 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdA0RdRRqQc3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jan 2017 18:33:17 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 172BD20DE9; Fri, 27 Jan 2017 18:33:16 +0100 (CET)
Received: from bbrezillon (LStLambert-657-1-97-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9A79820DE5;
        Fri, 27 Jan 2017 18:33:15 +0100 (CET)
Date:   Fri, 27 Jan 2017 18:33:11 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH 10/13] mtd: nand: jz4740: Let the pinctrl driver
 configure the pins
Message-ID: <20170127183311.132b5661@bbrezillon>
In-Reply-To: <20170117231421.16310-11-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
        <20170117231421.16310-11-paul@crapouillou.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

On Wed, 18 Jan 2017 00:14:18 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Before, this NAND driver would set itself the configuration of the
> chip-select pins for the various NAND banks.
> 
> Now that the JZ4740 and similar SoCs have a pinctrl driver, we rely on
> the pins being properly configured before the driver probes.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/mtd/nand/jz4740_nand.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
> index 5551c36adbdf..0d06a1f07d82 100644
> --- a/drivers/mtd/nand/jz4740_nand.c
> +++ b/drivers/mtd/nand/jz4740_nand.c
> @@ -25,7 +25,6 @@
>  
>  #include <linux/gpio.h>
>  
> -#include <asm/mach-jz4740/gpio.h>
>  #include <asm/mach-jz4740/jz4740_nand.h>
>  
>  #define JZ_REG_NAND_CTRL	0x50
> @@ -310,34 +309,20 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
>  			       uint8_t *nand_dev_id)
>  {
>  	int ret;
> -	int gpio;
> -	char gpio_name[9];
>  	char res_name[6];
>  	uint32_t ctrl;
>  	struct nand_chip *chip = &nand->chip;
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  
> -	/* Request GPIO port. */
> -	gpio = JZ_GPIO_MEM_CS0 + bank - 1;
> -	sprintf(gpio_name, "NAND CS%d", bank);
> -	ret = gpio_request(gpio, gpio_name);
> -	if (ret) {
> -		dev_warn(&pdev->dev,
> -			"Failed to request %s gpio %d: %d\n",
> -			gpio_name, gpio, ret);
> -		goto notfound_gpio;
> -	}
> -
>  	/* Request I/O resource. */
>  	sprintf(res_name, "bank%d", bank);
>  	ret = jz_nand_ioremap_resource(pdev, res_name,
>  					&nand->bank_mem[bank - 1],
>  					&nand->bank_base[bank - 1]);
>  	if (ret)
> -		goto notfound_resource;
> +		return ret;
>  
>  	/* Enable chip in bank. */
> -	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_MEM_CS0);
>  	ctrl = readl(nand->base + JZ_REG_NAND_CTRL);
>  	ctrl |= JZ_NAND_CTRL_ENABLE_CHIP(bank - 1);
>  	writel(ctrl, nand->base + JZ_REG_NAND_CTRL);
> @@ -377,12 +362,8 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
>  	dev_info(&pdev->dev, "No chip found on bank %i\n", bank);
>  	ctrl &= ~(JZ_NAND_CTRL_ENABLE_CHIP(bank - 1));
>  	writel(ctrl, nand->base + JZ_REG_NAND_CTRL);
> -	jz_gpio_set_function(gpio, JZ_GPIO_FUNC_NONE);
>  	jz_nand_iounmap_resource(nand->bank_mem[bank - 1],
>  				 nand->bank_base[bank - 1]);
> -notfound_resource:
> -	gpio_free(gpio);
> -notfound_gpio:
>  	return ret;
>  }
>  
> @@ -503,7 +484,6 @@ static int jz_nand_probe(struct platform_device *pdev)
>  err_unclaim_banks:
>  	while (chipnr--) {
>  		unsigned char bank = nand->banks[chipnr];
> -		gpio_free(JZ_GPIO_MEM_CS0 + bank - 1);
>  		jz_nand_iounmap_resource(nand->bank_mem[bank - 1],
>  					 nand->bank_base[bank - 1]);
>  	}
> @@ -530,7 +510,6 @@ static int jz_nand_remove(struct platform_device *pdev)
>  		if (bank != 0) {
>  			jz_nand_iounmap_resource(nand->bank_mem[bank - 1],
>  						 nand->bank_base[bank - 1]);
> -			gpio_free(JZ_GPIO_MEM_CS0 + bank - 1);
>  		}
>  	}
>  
