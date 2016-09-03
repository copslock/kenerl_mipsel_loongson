Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2016 14:15:50 +0200 (CEST)
Received: from mail-lf0-f45.google.com ([209.85.215.45]:32851 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbcICMPnDvzPV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Sep 2016 14:15:43 +0200
Received: by mail-lf0-f45.google.com with SMTP id b199so100243354lfe.0
        for <linux-mips@linux-mips.org>; Sat, 03 Sep 2016 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3bH3rddpLFBPSEA33bgR11olP4wMcWbj41ilJmDQHhA=;
        b=K0En2RiA94xLCxsgG4UpughoqA7Em7VKiZ7y9uewHt6vBWOXdZTdYfXloKw/CTfwNq
         946R3RqS8foicfVUzoH/A3v8nVBSp4pQU6zr4dpKAsQgIxpQ4umubL+pnlUvbC+JwJBe
         ZpgXUhyS8Vm8kl1c6b+QY4S2jgBbuMesS0gkNb6BnNZwcmDdoOKNBVNO+zYHhtgo7yb8
         yTNLU/3fq7bixNvTwjkAoOSSeEaPSQz3lol/z4NFqn2vNPszfhbmokkJTvebIA3qY1bb
         1+MOCIDyMAyvkq/IJ/smGN4zwTu61EU0if7Cobxk+zXCdFC0yVx/Ft5MXMz33hOYO/ia
         NgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3bH3rddpLFBPSEA33bgR11olP4wMcWbj41ilJmDQHhA=;
        b=Akzm441HJyPa/1Lvm+sb9KuAlOhrJW8SlawhCIlQK5n8zdMGTzafzWJo3FbVG+ItL0
         xNNrcPh5EWDuqjdkKgTB0RPNPUygOAZ3Mwsee7d/0NltRgYmqcMejwkp4gvfMR5mbi31
         OE6g4iG3Y1lj5kxCO4+VrzO+RiohoGZZzUANrujjsqxbu4IW0KP/jZxUSY+OOXNw61HZ
         ajFqOKiBV1Mjwx6IEzvOva1bcbStCStgFhLoTngpQwGYmGN1z2rqDuSG05QJ8xef7/6H
         HkmhzjGJU9hu99KByvAnpDOI+B/Ghjizbv0pqDbCDLdM9eHiLU3F5y/pjQwwutFXHdaO
         Osdg==
X-Gm-Message-State: AE9vXwMIto63X9BMOsSPxRjjM4MRVBWSo+3LOX0FsD31o9MASvOjwkiTwVlJy2bo2sI11w==
X-Received: by 10.46.1.69 with SMTP id 66mr7931720ljb.27.1472904937634;
        Sat, 03 Sep 2016 05:15:37 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.103])
        by smtp.gmail.com with ESMTPSA id t78sm205910lfi.43.2016.09.03.05.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Sep 2016 05:15:36 -0700 (PDT)
Subject: Re: [PATCH 07/12] MIPS: Malta: Probe RTC via DT
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
 <20160902154859.24269-8-paul.burton@imgtec.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8cc3d8af-8851-2f66-fb6d-d3ba35eb66b4@cogentembedded.com>
Date:   Sat, 3 Sep 2016 15:15:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160902154859.24269-8-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55033
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

On 9/2/2016 6:48 PM, Paul Burton wrote:

> Add the DT node required to probe the RTC, and remove the platform code
> that was previously doing it.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>  arch/mips/boot/dts/mti/malta.dts     | 15 +++++++++++++++
>  arch/mips/mti-malta/malta-platform.c | 21 ---------------------
>  2 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
> index af765af..ee43296 100644
> --- a/arch/mips/boot/dts/mti/malta.dts
> +++ b/arch/mips/boot/dts/mti/malta.dts
> @@ -49,4 +49,19 @@
>  		interrupt-parent = <&gic>;
>  		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +	isa {
> +		compatible = "isa";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <1 0 0 0x1000>;
> +
> +		rtc: mc146818@70 {

    Should be the other way around: you can use the chip name as a label, but 
you have to use the device class as a node name.

> +			compatible = "motorola,mc146818";
> +			reg = <1 0x70 0x8>;
> +
> +			interrupt-parent = <&i8259>;
> +			interrupts = <8>;
> +		};
> +	};
>  };
[...]

MBR, Sergei
