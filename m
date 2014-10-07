Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 18:07:08 +0200 (CEST)
Received: from vps0.lunn.ch ([178.209.37.122]:53381 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010711AbaJGQHGJgjYN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Oct 2014 18:07:06 +0200
Received: from lunn by vps0.lunn.ch with local (Exim 4.80)
        (envelope-from <andrew@lunn.ch>)
        id 1XbXHa-000548-Ti; Tue, 07 Oct 2014 18:06:38 +0200
Date:   Tue, 7 Oct 2014 18:06:38 +0200
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
Subject: Re: [PATCH 20/44] power/reset: restart-poweroff: Register with
 kernel poweroff handler
Message-ID: <20141007160638.GE19005@lunn.ch>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-21-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412659726-29957-21-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43064
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

On Mon, Oct 06, 2014 at 10:28:22PM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of seting pm_power_off
> directly.  Register as poweroff handler of last resort since the driver
> does not really power off the system but executes a restart.

I would not say last resort, this is how it is designed to work. There
is no way to turn the power off from with linux, it is designed that
u-boot will put the hardware into minimal power consumption until the
"power" button is pressed.

Other than that, 

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/power/reset/restart-poweroff.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
> index edd707e..5437697 100644
> --- a/drivers/power/reset/restart-poweroff.c
> +++ b/drivers/power/reset/restart-poweroff.c
> @@ -12,35 +12,34 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
> -#include <asm/system_misc.h>
>  
> -static void restart_poweroff_do_poweroff(void)
> +static int restart_poweroff_do_poweroff(struct notifier_block *this,
> +					unsigned long unused1, void *unused2)
>  {
>  	reboot_mode = REBOOT_HARD;
>  	machine_restart(NULL);
> +
> +	return NOTIFY_DONE;
>  }
>  
> +static struct notifier_block restart_poweroff_handler = {
> +	.notifier_call = restart_poweroff_do_poweroff,
> +};
> +
>  static int restart_poweroff_probe(struct platform_device *pdev)
>  {
> -	/* If a pm_power_off function has already been added, leave it alone */
> -	if (pm_power_off != NULL) {
> -		dev_err(&pdev->dev,
> -			"pm_power_off function already registered");
> -		return -EBUSY;
> -	}
> -
> -	pm_power_off = &restart_poweroff_do_poweroff;
> -	return 0;
> +	return register_poweroff_handler(&restart_poweroff_handler);
>  }
>  
>  static int restart_poweroff_remove(struct platform_device *pdev)
>  {
> -	if (pm_power_off == &restart_poweroff_do_poweroff)
> -		pm_power_off = NULL;
> +	unregister_poweroff_handler(&restart_poweroff_handler);
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
