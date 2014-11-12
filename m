Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:50:53 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57503 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013493AbaKLIuwO6ddS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:50:52 +0100
Received: by mail-wg0-f45.google.com with SMTP id x12so13712307wgg.18
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Pg+adVEBH8tHj1FRTSHHLsETGmPSkMNxs66UASOx2xw=;
        b=TevkoCktN8AI5e17ZkDLSXXR6cQlyb8/uN/LwN3G1uiY679EJ5UmFH1qBM4OU+aIUt
         fubxBVIu1QPSST8q33WmEQcEV8tfjxpl0fIooIA70Vl2MUMhEMf5d2HAaTbOx4hsLR/4
         /olP56XVD6AReApsj9PDjBY4tZVOxcbbBmpQeEXorQM8hcq80dMJIWcdLhvLfB8EnSQ+
         uj+bJZqeXfVjOgfGx0wuZgnxHjynplLQH5DOZ5ALls8ZHSegQJ1Gs1UVDMoMB2IUcGf9
         KN/8DNToLtYEkz5hPW7D2HfbJeh3+RRZz0tqIB5qvs0Z+3Ya3DbuU7cwyEOCy01sS4z/
         3UkA==
X-Received: by 10.180.82.170 with SMTP id j10mr4267536wiy.35.1415782246953;
        Wed, 12 Nov 2014 00:50:46 -0800 (PST)
Received: from ?IPv6:2a01:4240:53f0:43fb::cbb? ([2a01:4240:53f0:43fb::cbb])
        by mx.google.com with ESMTPSA id f7sm20722828wiz.13.2014.11.12.00.50.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 00:50:46 -0800 (PST)
Message-ID: <54631F64.8080009@suse.cz>
Date:   Wed, 12 Nov 2014 09:50:44 +0100
From:   Jiri Slaby <jslaby@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        robh@kernel.org
CC:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH/RFC 3/8] of: Add helper function to check MMIO register
 endianness
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-4-git-send-email-cernekee@gmail.com>
In-Reply-To: <1415781993-7755-4-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 11/12/2014, 09:46 AM, Kevin Cernekee wrote:
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
> 
> Introduce a function that checks an OF device node to see whether it
> contains a "big-endian" or "native-endian" property.  For the former case,
> always return 1.  For the latter case, return 1 iff the kernel was built
> for BE (implying that the BE MMIO accessors do not perform a swap).
> Otherwise return 0, assuming LE registers.
> 
> LE registers are assumed by default because most existing drivers (libahci,
> serial8250, usb) always use readl/writel in the absence of instructions
> to the contrary, so that will be our fallback.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/of/base.c  | 23 +++++++++++++++++++++++
>  include/linux/of.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 3823edf..9dd494a 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -552,6 +552,29 @@ int of_device_is_available(const struct device_node *device)
>  EXPORT_SYMBOL(of_device_is_available);
>  
>  /**
> + *  of_device_is_big_endian - check if a device has BE registers
> + *
> + *  @device: Node to check for availability
> + *
> + *  Returns 1 if the device has a "big-endian" property, or if the kernel
> + *  was compiled for BE *and* the device has a "native-endian" property.
> + *  Returns 0 otherwise.
> + *
> + *  Callers would nominally use ioread32be/iowrite32be if
> + *  of_device_is_big_endian() == 1, or readl/writel otherwise.
> + */
> +int of_device_is_big_endian(const struct device_node *device)
> +{
> +	if (of_property_read_bool(device, "big-endian"))
> +		return 1;
> +	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
> +	    of_property_read_bool(device, "native-endian"))
> +		return 1;
> +	return 0;
> +}

This should actually return bool and use true/false.

-- 
js
suse labs
