Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 18:02:36 +0200 (CEST)
Received: from vps0.lunn.ch ([178.209.37.122]:53362 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010711AbaJGQCeJHW5E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Oct 2014 18:02:34 +0200
Received: from lunn by vps0.lunn.ch with local (Exim 4.80)
        (envelope-from <andrew@lunn.ch>)
        id 1XbXDE-00052e-Ge; Tue, 07 Oct 2014 18:02:08 +0200
Date:   Tue, 7 Oct 2014 18:02:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-c6x-dev@linux-c6x.org,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devicetree@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-pm@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
        linux-tegra@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        David Woodhouse <dwmw2@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 23/44] power/reset: qnap-poweroff: Register with kernel
 poweroff handler
Message-ID: <20141007160208.GD19005@lunn.ch>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-24-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412659726-29957-24-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

On Mon, Oct 06, 2014 at 10:28:25PM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with default priority value of 128 to reflect that
> the original code generates an error if another poweroff handler has
> already been registered when the driver is loaded.
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> ---
>  drivers/power/reset/qnap-poweroff.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
> index a75db7f..c474980 100644
> --- a/drivers/power/reset/qnap-poweroff.c
> +++ b/drivers/power/reset/qnap-poweroff.c
> @@ -16,7 +16,9 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/serial_reg.h>
>  #include <linux/kallsyms.h>
>  #include <linux/of.h>
> @@ -55,7 +57,8 @@ static void __iomem *base;
>  static unsigned long tclk;
>  static const struct power_off_cfg *cfg;
>  
> -static void qnap_power_off(void)
> +static int qnap_power_off(struct notifier_block *this, unsigned long unused1,
> +			  void *unused2)
>  {
>  	const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
>  
> @@ -72,14 +75,20 @@ static void qnap_power_off(void)
>  
>  	/* send the power-off command to PIC */
>  	writel(cfg->cmd, UART1_REG(TX));
> +
> +	return NOTIFY_DONE;
>  }
>  
> +static struct notifier_block qnap_poweroff_nb = {
> +	.notifier_call = qnap_power_off,
> +	.priority = 128,
> +};
> +
>  static int qnap_power_off_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct resource *res;
>  	struct clk *clk;
> -	char symname[KSYM_NAME_LEN];
>  
>  	const struct of_device_id *match =
>  		of_match_node(qnap_power_off_of_match_table, np);
> @@ -106,22 +115,13 @@ static int qnap_power_off_probe(struct platform_device *pdev)
>  
>  	tclk = clk_get_rate(clk);
>  
> -	/* Check that nothing else has already setup a handler */
> -	if (pm_power_off) {
> -		lookup_symbol_name((ulong)pm_power_off, symname);
> -		dev_err(&pdev->dev,
> -			"pm_power_off already claimed %p %s",
> -			pm_power_off, symname);
> -		return -EBUSY;
> -	}
> -	pm_power_off = qnap_power_off;
> -
> -	return 0;
> +	return register_poweroff_handler(&qnap_poweroff_nb);
>  }
>  
>  static int qnap_power_off_remove(struct platform_device *pdev)
>  {
> -	pm_power_off = NULL;
> +	unregister_poweroff_handler(&qnap_poweroff_nb);
> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
