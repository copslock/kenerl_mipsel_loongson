Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 09:34:11 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:34452
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeCCIeDklrU7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 09:34:03 +0100
Received: by mail-lf0-x244.google.com with SMTP id l191so16474874lfe.1
        for <linux-mips@linux-mips.org>; Sat, 03 Mar 2018 00:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o3/CBO8SJPWQ9B5lTHrSUTGsnd0SF1jYHa7QW6L2yaY=;
        b=lBd++Z5gw7q7vxz5PqPixC713PK11Yp1Izwv3lfiHJ48lunFwXrnZZvm858v0fZhzT
         Mq0C+ccC0DFaojiMtm1ZmahtUrKmp5UvwDZ80QDr+g7mdEa7rYQwbbgIBjksj8yc5Tsn
         FCy6X/22vV8jRtLVqEwSeDHN3EtaLk3UUelWjvz+hpYVfqWr6p5l6cSJMWpdu01lqH1c
         ZbRg3pWA2Ncv2QsX9nFAMZ3ym+41hZbHsV6yQm6f72qSOHZw2dv5e8g/v2RtLyR5QwMG
         ZGR5HTs4vSj5QD+NjghlPMu/n1knULd8hBeYQ1WKvZIoyimWfC1Wl35DX9UdHjkxe76g
         0z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3/CBO8SJPWQ9B5lTHrSUTGsnd0SF1jYHa7QW6L2yaY=;
        b=ACLQ8EEA4m5d3GET/mcJNiZT161B2+CvTNl6/seCA4spdrAiVQG2wYH5Tb9ImfgVDE
         r3mcfdLBHQuezyO3Wq+EGOcLz5eSOl+SLbm2V9hHiHrWtKxO8a5W5ip/Z7HZRzKCZ8jS
         FCcqum17OWXbCc9IT/qprLfXGSeN200d5YyKA4LyDHKNo8uaNANBdICxZFFGQ5LdY40Z
         qTdATMb+MQl0Ej7qM+6IeWRcsXjMUCW+1dXYJvU2+zRFW63TgjUnGMFlx0KWZNgGydOv
         BgH4iGZaQaYaxCd3RDQAjio2sX2XimkcUEaPn7aTt2llgx8bMnadqf2TRfoLu7I0Nr1y
         xUwA==
X-Gm-Message-State: APf1xPC1bqUnULRslLfKzM+draSdzI2xBOp+N6azRDmeeJHM7E5wlUGI
        FeEQJEB68M3SbV9Grsy6ry43+A==
X-Google-Smtp-Source: AG47ELs1k1VcltROPAENsIYO9Vyuj/HgbHfu5LWLEJDKFmqqZOMG53TW1Pc/xZ9Ly/kfwSojtDoPmQ==
X-Received: by 10.46.118.5 with SMTP id r5mr5282187ljc.11.1520066035955;
        Sat, 03 Mar 2018 00:33:55 -0800 (PST)
Received: from [192.168.4.126] ([31.173.82.98])
        by smtp.gmail.com with ESMTPSA id h71sm1699576ljh.77.2018.03.03.00.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 00:33:55 -0800 (PST)
Subject: Re: [PATCH v4 4/6] MIPS: mscc: add ocelot PCB123 device tree
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
 <20180302224811.26840-5-alexandre.belloni@bootlin.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <39189775-0c56-93b6-21e5-ac4d814d1879@cogentembedded.com>
Date:   Sat, 3 Mar 2018 11:33:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302224811.26840-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62788
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

Hello!

On 3/3/2018 1:48 AM, Alexandre Belloni wrote:

> Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[...]
> diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> new file mode 100644
> index 000000000000..42bd404471f6
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2017 Microsemi Corporation */
> +
> +/dts-v1/;
> +
> +#include "ocelot.dtsi"
> +
> +/ {
> +	compatible = "mscc,ocelot-pcb123", "mscc,ocelot";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {

    Needs to be "memory@0" as you have the "regs" prop.

> +		device_type = "memory";
> +		reg = <0x0 0x0e000000>;
> +	};
> +};
[...]

MBR, Sergei
