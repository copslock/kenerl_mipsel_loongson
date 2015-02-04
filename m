Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 18:09:48 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:45881 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012582AbbBDRJqvV6lU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 18:09:46 +0100
Received: by mail-lb0-f182.google.com with SMTP id l4so2619121lbv.13
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 09:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iLDZfnFlIjbHJuLBVE0wr6Iw5XAaWsAGYkK9f7KbtOU=;
        b=WbrdIXJfRHJhQq7zkEM9TKaboqbyQZ/UdSLu/xsZRcFEWwe8EIIdelMnUlYr0IGtvC
         sxghh1vY6WIv/PO8P/80GcTKfU2Es4NHoXS0dxLtzpi2/yLxN5dPjqeGc9z8t1lIwlFW
         B4HvqsYI1vuQ8tbPQXTRB7v4zIzKRSrtl33CbkR2/4AI6g+YeoHjaAKrWRkzrkamruc8
         lqYDhzASJxxJTuH9+obDIcQj/NYlFUDoxSza749V04aPIthTBGkMTgoLkJoNls7f0jhU
         EQkwlrGqClLtZqiO9gdUeVfL/Z3//SEu+86u7QBQqXPg1shwi5EoCk5iGuVhG4N0W79x
         Nn9Q==
X-Gm-Message-State: ALoCoQnQhbS9Gf8U8QRkYchvHDUZoSyUoVjOgMOnZ/KxV8T4UVA4FxUDclVzWurXGdp163N9XAon
X-Received: by 10.112.150.98 with SMTP id uh2mr32047037lbb.92.1423069781616;
        Wed, 04 Feb 2015 09:09:41 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp16-217.pppoe.mtu-net.ru. [81.195.16.217])
        by mx.google.com with ESMTPSA id ao10sm465053lbc.42.2015.02.04.09.09.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2015 09:09:40 -0800 (PST)
Message-ID: <54D25252.2010406@cogentembedded.com>
Date:   Wed, 04 Feb 2015 20:09:38 +0300
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
Subject: Re: [PATCH_V2 09/34] MIPS: jz4740: probe interrupt controller via
 DT
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-10-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1423063323-19419-10-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45697
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

On 02/04/2015 06:21 PM, Zubair Lutfullah Kakakhel wrote:

> From: Paul Burton <paul.burton@imgtec.com>

> Add the appropriate DT node to probe the interrupt controller driver
> using the devicetree, and remove the call to jz4740_intc_init.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   arch/mips/boot/dts/jz4740.dtsi | 11 +++++++++++
>   arch/mips/jz4740/setup.c       |  2 --
>   2 files changed, 11 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
> index 2d64765c..3841024 100644
> --- a/arch/mips/boot/dts/jz4740.dtsi
> +++ b/arch/mips/boot/dts/jz4740.dtsi
> @@ -9,4 +9,15 @@
>   		interrupt-controller;
>   		compatible = "mti,cpu-interrupt-controller";
>   	};
> +
> +	intc: intc@10001000 {

    Name it "interrupt-controller@10001000", please. I have faint memories of 
already telling you to do this...

> +		compatible = "ingenic,jz4740-intc";
> +		reg = <0x10001000 0x14>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		interrupt-parent = <&cpuintc>;
> +		interrupts = <2>;
> +	};
>   };
[...]

WBR, Sergei
