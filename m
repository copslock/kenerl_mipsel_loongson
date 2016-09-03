Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2016 14:10:13 +0200 (CEST)
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34233 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992126AbcICMKFbWQNV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Sep 2016 14:10:05 +0200
Received: by mail-lf0-f45.google.com with SMTP id p41so81443451lfi.1
        for <linux-mips@linux-mips.org>; Sat, 03 Sep 2016 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=koiSsN+X6ALJ93eneVRvWb9O3oVPXUYsMydQZaZogyQ=;
        b=iExgFyjAKFcJTWJpsxkDq0uo6ByJfBp9txHVgNYvML9fwtHEM1R6RMRBo5017OTKo3
         6jJQCayOq5ylCW/X8tpEaMmlIt+ht+AzmbFXc0EZSRNbqV/QwxhFDmZ2dvWz7aIXnn30
         xLjI19hgonNMy4/WDMD6jlFrhcOYSJBRrH2jeDwkDq7NWhpVapgAm3TFetNAN7hWB6KM
         fo5mo5MI1T7o268eHdj3wqBhw5yV7HJwAWv/dTcVIG+jWYzEavANrawnhYaFxq+wzAcJ
         8GFmLSrkQlLzwv2fKVFKOPFkWPh7l5JnlH7JWNEE/8GQj9xQN2QLd0AhH0ukfZVW64EP
         KNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=koiSsN+X6ALJ93eneVRvWb9O3oVPXUYsMydQZaZogyQ=;
        b=hEYH9fcW09XLaS2Y0GslHN8xmliOhZjz29VcRD2PVZUS/JvaI/h8deSpcAlhrWbp3S
         LFdiySqUG86ud02gFQQgM/5xdl3p0pvhdbAyEpMjzuUaAPQFStFXKhQ/atvQFP8A3RWP
         QUC1SDEkm9AFdU9u6mp+aPmrrkIgVGBlgWJu3+o1HnpXJ2NIxQ9Ep6Wr8T3mo7Zba82d
         yKgmfCPFr7IoLw0zo6IzNNu5YBMXegI4OFKR0Whgk9KndwR3cL4tgg31baO86bcb7z4r
         PoogMIO3hfr3PvFVwISNwI9NTWGpooFQQ8PWabUFjekPpqNwagdFSOyJmtGcusXbGmkl
         lReA==
X-Gm-Message-State: AE9vXwPxXQ+b5OPT5uPPTbbm4SW4lEdkEAbDjSJLePGm7TaSye4RlGvLws1+2iWtesEAWQ==
X-Received: by 10.25.25.69 with SMTP id 66mr8283918lfz.14.1472904599632;
        Sat, 03 Sep 2016 05:09:59 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.103])
        by smtp.gmail.com with ESMTPSA id f71sm2688683lfg.36.2016.09.03.05.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Sep 2016 05:09:58 -0700 (PDT)
Subject: Re: [PATCH 2/3] MIPS: OCTEON: add DTS for D-Link DSR-500N
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20160902211136.8610-1-aaro.koskinen@iki.fi>
 <20160902211136.8610-3-aaro.koskinen@iki.fi>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <51b74b54-a624-f85e-55bf-a99c4188cd44@cogentembedded.com>
Date:   Sat, 3 Sep 2016 15:09:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160902211136.8610-3-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 9/3/2016 12:11 AM, Aaro Koskinen wrote:

> Add DTS for D-Link DSR-500N.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  .../mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
>
> diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
> new file mode 100644
> index 0000000..6cacabb
> --- /dev/null
> +++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
> @@ -0,0 +1,42 @@
> +/*
> + * Device tree source for D-Link DSR-500N.
> + *
> + * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/include/ "dlink_dsr-500n-1000n.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "dlink,dsr-500n";
> +	compatible = "dlink,dsr-500n", "cavium,octeon-3860";
> +
> +	soc@0 {
> +		uart0: serial@1180000000800 {
> +			clock-frequency = <300000000>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		usb {
> +			label = "usb";
> +			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		wps {
> +			label = "wps";

    You don't need LED labels when the are identical to the node names.

[...]

MBR, Sergei
