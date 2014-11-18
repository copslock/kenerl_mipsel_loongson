Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 22:47:56 +0100 (CET)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37078 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013959AbaKRVryrpNHJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 22:47:54 +0100
Received: by mail-wg0-f43.google.com with SMTP id l18so7617305wgh.2
        for <linux-mips@linux-mips.org>; Tue, 18 Nov 2014 13:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=J312EawI9dNmyBCB4Rda9g9rwH2isE5bIk7zr2YGq3g=;
        b=Bwm1XUx+KQcn5bFjT06K2sP28qxYUJSnYLUprGqhjJrXcjReAzdjMIeLVF/xTbOf1t
         7PC3ZTuj4uF3AWFYUTEnEpy+TtoElfA22NWHPg+uJNpPmYo4RbNu65aIt9LdpciebT/P
         uZXEgB4aKkWisMvfR/k1fMitUvKQF9xlTF41bOYJJqjR4bHGlfZAmuQzrZ958guVTkMt
         VlzrvAq8mU2fO7ueULIcrMl7H54hb6MjKDW/puZKuSs9R0LUvX5IndVmRM9LztBJBX/9
         EelAJkUhmANE3OilyQB1t4KcU+3W/N4GqpMUea8glOcwehwxuneA7LQMpZPYC/7DPCyi
         MTxQ==
X-Gm-Message-State: ALoCoQnwEHC8xmuKszdQfVdct258vrERyjLMqZTZYGcUghnwWiwlsAzKgEDD0eWhRtx8SbhLoHwd
X-Received: by 10.180.14.226 with SMTP id s2mr42426927wic.61.1416347269358;
        Tue, 18 Nov 2014 13:47:49 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-84-117.range86-166.btcentralplus.com. [86.166.84.117])
        by mx.google.com with ESMTPSA id ll2sm44683258wjb.11.2014.11.18.13.47.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 13:47:48 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 251BBC40966; Tue, 18 Nov 2014 21:47:45 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 05/10] of: Add helper function to check MMIO register
 endianness
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1415825647-6024-6-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
        <1415825647-6024-6-git-send-email-cernekee@gmail.com>
Date:   Tue, 18 Nov 2014 21:47:45 +0000
Message-Id: <20141118214745.251BBC40966@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44277
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

On Wed, 12 Nov 2014 12:54:02 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> SoC peripherals can come in several different flavors:
> 
>  - little-endian: registers always need to be accessed in LE mode (so the
>    kernel should perform a swap if the CPU is running BE)
> 
>  - big-endian: registers always need to be accessed in BE mode (so the
>    kernel should perform a swap if the CPU is running LE)
> 
>  - native-endian: the bus will automatically swap accesses, so the kernel
>    should never swap
> Introduce a function that checks an OF device node to see whether it
> contains a "big-endian" or "native-endian" property.  For the former case,
> always return true.  For the latter case, return true iff the kernel was
> built for BE (implying that the BE MMIO accessors do not perform a swap).
> Otherwise return false, assuming LE registers.
> 
> LE registers are assumed by default because most existing drivers (libahci,
> serial8250, usb) always use readl/writel in the absence of instructions
> to the contrary, so that will be our fallback.

This is proposing a new binding, or at least a common pattern to be used
by other bindings. It should be documented under
Documentation/devicetree/bindings/. I suggest creating a new file under
bindings/common-properties.txt

Otherwise looks fine to me. We'll give it a week to see if there are any
other comments, but I think this looks fine.

g.

> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/of/base.c  | 23 +++++++++++++++++++++++
>  include/linux/of.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 81c095f..35d95a1 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -552,6 +552,29 @@ bool of_device_is_available(const struct device_node *device)
>  EXPORT_SYMBOL(of_device_is_available);
>  
>  /**
> + *  of_device_is_big_endian - check if a device has BE registers
> + *
> + *  @device: Node to check for endianness
> + *
> + *  Returns true if the device has a "big-endian" property, or if the kernel
> + *  was compiled for BE *and* the device has a "native-endian" property.
> + *  Returns false otherwise.
> + *
> + *  Callers would nominally use ioread32be/iowrite32be if
> + *  of_device_is_big_endian() == true, or readl/writel otherwise.
> + */
> +bool of_device_is_big_endian(const struct device_node *device)
> +{
> +	if (of_property_read_bool(device, "big-endian"))
> +		return true;
> +	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
> +	    of_property_read_bool(device, "native-endian"))
> +		return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(of_device_is_big_endian);
> +
> +/**
>   *	of_get_parent - Get a node's parent if any
>   *	@node:	Node to get parent
>   *
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 7aaaa59..fc70b01 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -276,6 +276,7 @@ extern int of_property_read_string_helper(struct device_node *np,
>  extern int of_device_is_compatible(const struct device_node *device,
>  				   const char *);
>  extern bool of_device_is_available(const struct device_node *device);
> +extern bool of_device_is_big_endian(const struct device_node *device);
>  extern const void *of_get_property(const struct device_node *node,
>  				const char *name,
>  				int *lenp);
> @@ -431,6 +432,11 @@ static inline bool of_device_is_available(const struct device_node *device)
>  	return false;
>  }
>  
> +static inline bool of_device_is_big_endian(const struct device_node *device)
> +{
> +	return false;
> +}
> +
>  static inline struct property *of_find_property(const struct device_node *np,
>  						const char *name,
>  						int *lenp)
> -- 
> 2.1.1
> 
