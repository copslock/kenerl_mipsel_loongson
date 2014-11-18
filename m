Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 22:50:20 +0100 (CET)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53719 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013857AbaKRVuS0rV76 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 22:50:18 +0100
Received: by mail-wg0-f44.google.com with SMTP id b13so2490443wgh.17
        for <linux-mips@linux-mips.org>; Tue, 18 Nov 2014 13:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=brK0isjVd3z/CKk7+xmahjB6PK2Z8t+g/vz9vpt4440=;
        b=aOsEP0/sjQ8/I5puVpFCd+gxSqb2iFZ2RIVaEksAh2iOr5ZeBCxvtiAobbGxpBo/6F
         /OxO60pq35CeXxh8O21UguPrLMP+K2LC1lxg/N/tsO0wx5gr5dZSShEKWpy1ZYLfMwCE
         sp5LHQEIj4wYZqKMXMei6DamKIRSHaFd6cV8EEmis6lM/2UtRshXkV55q2pCo1SJovQc
         r5k5m3O/B8V0Z+3yxY37TSwJ1wPmj4LReeZmd6eBYn11RkfTrsKWQC0Yc5swTCwmxSM+
         KCDeW5XEbFoydHSsUoPcEd02xEUCbxRgiODzZABbZzp2DWGR/yUajBXPBLW/d8xvo2Sv
         DJbg==
X-Gm-Message-State: ALoCoQlHqGuIqYArkXD6Gul0EFYyO6kS6coSKH3b9TRy4JDao1xecV0D3MTjlIDy/zFOKFz2zVB7
X-Received: by 10.194.175.67 with SMTP id by3mr50808044wjc.32.1416347411672;
        Tue, 18 Nov 2014 13:50:11 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-84-117.range86-166.btcentralplus.com. [86.166.84.117])
        by mx.google.com with ESMTPSA id fo12sm10722643wic.19.2014.11.18.13.50.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 13:50:10 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 7498FC40966; Tue, 18 Nov 2014 21:50:07 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 09/10] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1415825647-6024-10-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
        <1415825647-6024-10-git-send-email-cernekee@gmail.com>
Date:   Tue, 18 Nov 2014 21:50:07 +0000
Message-Id: <20141118215007.7498FC40966@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, 12 Nov 2014 12:54:06 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> If an earlycon (stdout-path) node is being used, check for "big-endian"
> or "native-endian" properties and pass the appropriate iotype to the
> driver.
> 
> Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
> big-endian property only really makes sense in the context of 32-bit
> registers, since 8-bit accesses never require data swapping.
> 
> At some point, the of_earlycon code may want to pass in the reg-io-width,
> reg-offset, and reg-shift parameters too.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/of/fdt.c              | 9 ++++++++-
>  drivers/tty/serial/earlycon.c | 4 ++--
>  include/linux/serial_core.h   | 2 +-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 30e97bc..15f80c9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/kconfig.h>
>  #include <linux/initrd.h>
>  #include <linux/memblock.h>
>  #include <linux/of.h>
> @@ -784,7 +785,13 @@ int __init early_init_dt_scan_chosen_serial(void)
>  		if (!addr)
>  			return -ENXIO;
>  
> -		of_setup_earlycon(addr, match->data);
> +		if (fdt_getprop(fdt, offset, "big-endian", NULL) ||
> +		    (fdt_getprop(fdt, offset, "native-endian", NULL) &&
> +		     IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))) {
> +			of_setup_earlycon(addr, UPIO_MEM32BE, match->data);
> +		} else {
> +			of_setup_earlycon(addr, UPIO_MEM, match->data);
> +		}

Perhaps also create an fdt_ version of the helper.

Otherwise looks good to me.

Acked-by: Grant Likely <grant.likely@linaro.org>

g.

>  		return 0;
>  	}
>  	return -ENODEV;
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a514ee6..548f7d7 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -148,13 +148,13 @@ int __init setup_earlycon(char *buf, const char *match,
>  	return 0;
>  }
>  
> -int __init of_setup_earlycon(unsigned long addr,
> +int __init of_setup_earlycon(unsigned long addr, unsigned char iotype,
>  			     int (*setup)(struct earlycon_device *, const char *))
>  {
>  	int err;
>  	struct uart_port *port = &early_console_dev.port;
>  
> -	port->iotype = UPIO_MEM;
> +	port->iotype = iotype;
>  	port->mapbase = addr;
>  	port->uartclk = BASE_BAUD * 16;
>  	port->membase = earlycon_map(addr, SZ_4K);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index d2d5bf6..0d60c64 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -310,7 +310,7 @@ struct earlycon_device {
>  int setup_earlycon(char *buf, const char *match,
>  		   int (*setup)(struct earlycon_device *, const char *));
>  
> -extern int of_setup_earlycon(unsigned long addr,
> +extern int of_setup_earlycon(unsigned long addr, unsigned char iotype,
>  			     int (*setup)(struct earlycon_device *, const char *));
>  
>  #define EARLYCON_DECLARE(name, func) \
> -- 
> 2.1.1
> 
