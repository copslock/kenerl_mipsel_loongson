Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 18:05:29 +0100 (CET)
Received: from mail-la0-f45.google.com ([209.85.215.45]:44950 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012578AbbBDRF1U4kOp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 18:05:27 +0100
Received: by mail-la0-f45.google.com with SMTP id gd6so2744204lab.4
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 09:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lKIAnjgCmONfEo9Fta6Mm+jlw/qlVDjsffRPSvoODp0=;
        b=ci9h0ikObhfS7eSSQuQH4vn8OYzjykZEe/3IPb9mBp5/NbPa/c6g98CZU0dWS+EmMv
         124k8+4FPteeNr/Y8jhR5TH8q/3+q+MDdegkUBv1CP1/zGeV0Ba4GSzAk/60CDiMlDZP
         aK6gb5nyf8j5GwgYsuSYLFA1FQxdSFwYXvaOa6Rt2Opex6+bsgUw/5f+lxQypUCOYdYc
         fQq7F0hBLhasuQniP23iaEJczDpJeTqGU+mAYNOIrtyPHlmcMqn/2Wgi2BjhbryNBXlc
         dr0P8HsnIyWcVGPVGghQ1IO9es27caa2/iouNRPgjSTx+p4x1joeexIDWWVJPC9fyvj3
         8pRQ==
X-Gm-Message-State: ALoCoQnQ+vFXdJeTzBnR3G5rt7PZpDeqg1PxmGeWA5Mdf98V+KOS9MRhY33+c+dEHjE+e+68Evth
X-Received: by 10.152.29.6 with SMTP id f6mr20553142lah.82.1423069522029;
        Wed, 04 Feb 2015 09:05:22 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp16-217.pppoe.mtu-net.ru. [81.195.16.217])
        by mx.google.com with ESMTPSA id rp6sm470631lbb.4.2015.02.04.09.05.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2015 09:05:20 -0800 (PST)
Message-ID: <54D2514E.3020409@cogentembedded.com>
Date:   Wed, 04 Feb 2015 20:05:18 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org
CC:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org,
        jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net,
        lars@metafoo.de, paul.burton@imgtec.com
Subject: Re: [PATCH_V2 04/34] MIPS: jz4740: probe CPU interrupt controller
 via DT
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-5-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1423063323-19419-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45694
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

On 02/04/2015 06:21 PM, Zubair Lutfullah Kakakhel wrote:

> From: Paul Burton <paul.burton@imgtec.com>

> Use the generic irqchip_init function to probe irqchip drivers using DT,
> and add the appropriate node to the jz4740 devicetree in place of the
> call to mips_cpu_irq_init.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   arch/mips/boot/dts/jz4740.dtsi | 7 +++++++
>   arch/mips/jz4740/irq.c         | 4 ++--
>   2 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
> index c538691f..2d64765c 100644
> --- a/arch/mips/boot/dts/jz4740.dtsi
> +++ b/arch/mips/boot/dts/jz4740.dtsi
> @@ -2,4 +2,11 @@
>   	#address-cells = <1>;
>   	#size-cells = <1>;
>   	compatible = "ingenic,jz4740";
> +
> +	cpuintc: cpuintc@0 {

    Please name it "interrupt-controller". And why there's <unit-address> if 
there's no "reg" prop?

> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		compatible = "mti,cpu-interrupt-controller";
> +	};
>   };
[...]

WBR, Sergei
