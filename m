Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Mar 2015 23:23:26 +0100 (CET)
Received: from mail-qc0-f171.google.com ([209.85.216.171]:44558 "EHLO
        mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007834AbbCAWXYjL0-a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Mar 2015 23:23:24 +0100
Received: by qcvs11 with SMTP id s11so21940014qcv.11
        for <linux-mips@linux-mips.org>; Sun, 01 Mar 2015 14:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=q3gWZI+qy72pli1Sj56hkejtSV5Y2T8oCgUXOhHHCEw=;
        b=e2WDSCru6EDCfaoAmUPOcrP9Mj6sVfIEoWuaBCpRgADBiPIgytKGc0z95uH4mRqaFd
         IGN0UYyAyuV811X3i2O0ZTE3sa++NvHDMdAnWnym06aJctEWrxCP4GkRKkYonH4pbaBC
         DsQvNg0ewL6xPaRTJnR2FrKHuD9eO2hLrsfOGlMabPeE7xigJrt0FeHyBaG9iL23G6oy
         4AfXasDUMicseMQbmfSrb4mRkd/4JFUEfHqLSlopwqtw9uGtGbo9cKSPGl/olOwWRnD0
         f7z7kmgbuLx9H14ONhtPjMJiiqG1t+fydHJtZXA52zw+svkP45dDMQ0/Eohex498RaBq
         +vYA==
X-Gm-Message-State: ALoCoQn+M30GpVH4ZLr2pgW3an249CmzgoYaz4q8gr8FxXcMV5/bT8mk9HoujzmftISLE3jdj+zn
X-Received: by 10.140.22.8 with SMTP id 8mr45075664qgm.72.1425248599190;
        Sun, 01 Mar 2015 14:23:19 -0800 (PST)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id t7sm7219211qag.27.2015.03.01.14.23.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2015 14:23:18 -0800 (PST)
Message-ID: <54F3914F.3080905@hurleysoftware.com>
Date:   Sun, 01 Mar 2015 17:23:11 -0500
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
CC:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com>
In-Reply-To: <1416872182-6440-6-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

Hi Kevin,

On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
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
>  drivers/of/fdt.c              | 7 ++++++-
>  drivers/tty/serial/earlycon.c | 4 ++--
>  include/linux/serial_core.h   | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 658656f..9d21472 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
>  
>  	while (match->compatible[0]) {
>  		unsigned long addr;
> +		unsigned char iotype = UPIO_MEM;
> +
>  		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>  			match++;
>  			continue;
> @@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
>  		if (!addr)
>  			return -ENXIO;
>  
> -		of_setup_earlycon(addr, match->data);
> +		if (of_fdt_is_big_endian(fdt, offset))
> +			iotype = UPIO_MEM32BE;
> +
> +		of_setup_earlycon(addr, iotype, match->data);

I know these got ACKs already but as you point out in the commit log,
earlycon _will_ need reg-io-width, reg-offset and reg-shift. Since the
distinction between early_init_dt_scan_chosen_serial() and
of_setup_earlycon() is arbitrary, I'd rather see of_setup_earlycon()
taught to properly decode of_serial driver bindings instead of a
stack of parameters to of_setup_earlycon().

In fact, this patch allows a mis-defined devicetree to bring up a
functioning earlycon because the 'big-endian' property is directly
associated with UPIO_MEM32BE, which will create incompatibility problems
when DT earlycon is fixed to decode the of_serial DT bindings.

[rant]
In general, the ability to query devicetree from all over the
kernel creates all kinds of compatibility issues which eventually
will cause unresolvable breakage.

The same rigor applied to ioctls is the analysis required for how
DT bindings are used in the kernel.

I realize that since this particular case only applies to earlycon, it's
no big deal, but if this same mistake had been made in the of_serial
driver, the serial core would be permanently stuck with the
'big-endian' property == UPIO_MEM32BE which could impact future designs.
[/rant]

Regards,
Peter Hurley

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
> 
