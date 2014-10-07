Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 09:52:53 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:51667 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010668AbaJGHwwbWZvU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 09:52:52 +0200
Received: by mail-ig0-f173.google.com with SMTP id h18so3771727igc.6
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 00:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+auz6WJ8RkQR71wTNzglwUDDFzMINOhPs6uufeylVyU=;
        b=Y6oUTtfxoTsPKtxLpWJUrchxGr8d7BV0kpkpePoiz/0hVHuSRQmNOnCOzcQ1lV5oWj
         sBvdQ1uvnIru561NSryFW6SHFePg0Z92wTPomQtifFUez+PUwik09C3ZAp5fzw1wLgAQ
         7zOdK+hevUsDztwlRwYXZqS0M1rHB5FuhF+aRZryOaO+O8X796iAbF4swE9eR9OEHLnV
         Vs94A1O99ZJNJEwJu2OVDuNRce5Jji1DP0CV5Kv3BVc1+iTlkpm8T+X+DjaMhbEdgm5w
         cPEX5QeLIMOiK2N3NQAyLyK42XRdRHyDDWUK8hoeAowOLEHiHQp9OA8d4N6vWgb2zxgi
         cTrQ==
X-Gm-Message-State: ALoCoQmZlrK9MveUKIOYX+dktczeK8CjTnayuZDw/2lj3San7Cek28ybDU7K8i8GGHg4107Ykdld
X-Received: by 10.50.30.102 with SMTP id r6mr2943915igh.18.1412668366477;
        Tue, 07 Oct 2014 00:52:46 -0700 (PDT)
Received: from lee--X1 (host109-148-233-9.range109-148.btcentralplus.com. [109.148.233.9])
        by mx.google.com with ESMTPSA id m7sm1922290igj.18.2014.10.07.00.52.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 00:52:45 -0700 (PDT)
Date:   Tue, 7 Oct 2014 08:52:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 18/44] mfd: twl4030-power: Register with kernel poweroff
 handler
Message-ID: <20141007075238.GA25331@lee--X1>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-19-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1412659726-29957-19-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Mon, 06 Oct 2014, Guenter Roeck wrote:

> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with a low priority value of 64 to reflect that
> the original code only sets pm_power_off if it was not already set.
> 
> Make twl4030_power_off static as it is only called from the twl4030-power
> driver.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mfd/twl4030-power.c | 25 +++++++++++++++++++++----
>  include/linux/i2c/twl.h     |  1 -
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 4d3ff37..bd6b830 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -25,9 +25,10 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/pm.h>
> +#include <linux/notifier.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> @@ -611,7 +612,8 @@ twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
>   * After a successful execution, TWL shuts down the power to the SoC
>   * and all peripherals connected to it.
>   */
> -void twl4030_power_off(void)
> +static int twl4030_power_off(struct notifier_block *this, unsigned long unused1,
> +			     void *unused2)
>  {
>  	int err;
>  
> @@ -619,8 +621,15 @@ void twl4030_power_off(void)
>  			       TWL4030_PM_MASTER_P1_SW_EVENTS);
>  	if (err)
>  		pr_err("TWL4030 Unable to power off\n");
> +
> +	return NOTIFY_DONE;
>  }
>  
> +static struct notifier_block twl4030_poweroff_nb = {
> +	.notifier_call = twl4030_power_off,
> +	.priority = 64,

64 out of what?  How is this calculated?  Wouldn't it be better to
define these?

> +};
> +
>  static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
>  					struct device_node *node)
>  {
> @@ -836,7 +845,7 @@ static int twl4030_power_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Board has to be wired properly to use this feature */
> -	if (twl4030_power_use_poweroff(pdata, node) && !pm_power_off) {
> +	if (twl4030_power_use_poweroff(pdata, node)) {
>  		/* Default for SEQ_OFFSYNC is set, lets ensure this */
>  		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
>  				      TWL4030_PM_MASTER_CFG_P123_TRANSITION);
> @@ -853,7 +862,13 @@ static int twl4030_power_probe(struct platform_device *pdev)
>  			}
>  		}
>  
> -		pm_power_off = twl4030_power_off;
> +		err = register_poweroff_handler(&twl4030_poweroff_nb);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Failed to register poweroff handler\n");

If this is not fatal, you should issue a dev_warn() instead.

> +			/* Not a fatal error */
> +			err = 0;

How about using your own variable for this?  Then you don't have to
worry about resetting it.

> +		}
>  	}
>  
>  relock:
> @@ -869,6 +884,8 @@ relock:
>  
>  static int twl4030_power_remove(struct platform_device *pdev)
>  {
> +	unregister_poweroff_handler(&twl4030_poweroff_nb);

Perhaps a naive question, but is there any way you can do this using
devres (devm_* managed resources)?

>  	return 0;
>  }
>  
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 8cfb50f..f8544f1 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -680,7 +680,6 @@ struct twl4030_power_data {
>  };
>  
>  extern int twl4030_remove_script(u8 flags);
> -extern void twl4030_power_off(void);
>  
>  struct twl4030_codec_data {
>  	unsigned int digimic_delay; /* in ms */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
