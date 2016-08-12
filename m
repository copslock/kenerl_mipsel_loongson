Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 01:17:39 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35965 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993501AbcHLXRcSvgIp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 01:17:32 +0200
Received: by mail-pf0-f194.google.com with SMTP id y134so44405pfg.3;
        Fri, 12 Aug 2016 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=928DpcKyZfnjXk4ciX3SVaOekloYiAypCfrsFCn+LcE=;
        b=T7gQGiu1f5+priIsG4InAt32lyB38S1KbrXa9vDklg7bpvifxXKu6rvz44tJNKTFGu
         tChdNeFJ1D9JLQZf3+LLgaAxW1bcF5YS/xqsVHEe/R82t9nb9kWntJO0n/z+LwFSTumm
         5SZXZlctlCA0zodl6k6A07qJJZ1Xhmhn1JXiLJYqp/GSNjBvqDPF+3c+t6RtxQWls8MY
         prx+FKEAVvAmOR2rjB+x+CCnLXcFp+csiYVJgGyMkK+pqd+gd2ymVhVF6YzDtrKT14Kl
         XNoMGEpqodVGCikTtdzma0jbbP6JMEfwVDKxy6uRZM4u12RMkUNMZxCtqEWULZsZYYC2
         uDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=928DpcKyZfnjXk4ciX3SVaOekloYiAypCfrsFCn+LcE=;
        b=cSMHaBcjVILOygnY8kDppBluo9PqNyX2KAZS1QRNITr6LSlZumTA3J1D2V4H6GczJa
         5N+Y9sXdb45/lTlhdQT7KTvyTKFEUk2v4ZMYnMTsC2hVYyVWy4N1RiwnHQBmKdbhnYy2
         GTc/oh2dLHvDyh7EQ4UkC4otWep5gATa/bYqTqmE8owmo3g1AggAUFGLKrP2XPL7RDSW
         /SkYI8767KhBBMACstWgkcESL++HRDpR+840NUp8wKj+Z5ObKGJEyBPpLwfbCBYtKQps
         EYgI23xA2P/hbeYJgs4//FR12PoF8+d3jY8qPP2Lqm2rxMCStZuJtY4rvQeHKggcdRYe
         xlfg==
X-Gm-Message-State: AEkoouv7ItrPZzc/Zw/uVrK65ISEPZJGEKrv4IS+wUFhMDoI/HdFrxtKiosrpIu7Qm8jvw==
X-Received: by 10.98.16.75 with SMTP id y72mr31514299pfi.50.1471043846415;
        Fri, 12 Aug 2016 16:17:26 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id h125sm15496130pfg.54.2016.08.12.16.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 16:17:25 -0700 (PDT)
Subject: Re: [v3 4/5] MIPS: BMIPS: Add support NAND device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160812085231.53290-1-jaedon.shin@gmail.com>
 <20160812085231.53290-5-jaedon.shin@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <947152ab-0a28-365d-4fd9-eb84cdfd2147@gmail.com>
Date:   Fri, 12 Aug 2016 16:17:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812085231.53290-5-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 08/12/2016 01:52 AM, Jaedon Shin wrote:
> Adds NAND device nodes to BCM7xxx MIPS based SoCs.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---

I did not check all the reference boards, but for 7425 and 7435 here is
what you should have:

> diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
> index 1c6b74daef56..3b917cac7efe 100644
> --- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
> +++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
> @@ -1,6 +1,7 @@
>  /dts-v1/;
>  
>  /include/ "bcm7425.dtsi"
> +/include/ "bcm97xxx-nand-cs1-bch8.dtsi"
>  
>  / {
>  	compatible = "brcm,bcm97425svmb", "brcm,bcm7425";
> @@ -95,6 +96,10 @@
>  	status = "okay";
>  };
>  
> +&nand {
> +	status = "okay";
> +};

Here are the correct properties for our BCM97425SVMB board:

&nand {
        status = "okay";

        nandcs@1 {
                #size-cells = <0x2>;
                #address-cells = <0x2>;
                compatible = "brcm,nandcs";
                reg = <0x1>;
                nand-on-flash-bbt;

                nand-ecc-strength = <24>;
                nand-ecc-step-size = <1024>;
                brcm,nand-oob-sector-size = <27>;

> +
>  &sdhci0 {
>  	status = "okay";
>  };
> diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
> index 64bb1988dbc8..54351e54ff68 100644
> --- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
> +++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
> @@ -1,6 +1,7 @@
>  /dts-v1/;
>  
>  /include/ "bcm7435.dtsi"
> +/include/ "bcm97xxx-nand-cs1-bch8.dtsi"

And here are those for the BCM97435SVMB:

&nand {
        status = "okay";

        nandcs@1 {
                #size-cells = <0x2>;
                #address-cells = <0x2>;
                compatible = "brcm,nandcs";
                reg = <0x1>;
                nand-on-flash-bbt;

                nand-ecc-strength = <24>;
                nand-ecc-step-size = <1024>;
                brcm,nand-oob-sector-size = <27>;

-- 
Florian
