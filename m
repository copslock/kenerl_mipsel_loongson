Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 12:21:31 +0200 (CEST)
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33512 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992161AbcITKVXmbfxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 12:21:23 +0200
Received: by mail-lf0-f54.google.com with SMTP id h127so9446229lfh.0
        for <linux-mips@linux-mips.org>; Tue, 20 Sep 2016 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0fzHjv868ZwmWk9SP+jSuagQk79taDSQsOw4MHTBAkc=;
        b=S/qvY2dTiRs+nRqhdwej6bpMKU+lYmirmjbixO1G2v5appUgu/eB9BFXnMipr1vM8K
         xxTLEy6haKszKdL8W5B6umu/U2lEKonPlT+Hp8li1OIofr+JVawwYY4LM4jeQsKMrBuB
         xnqMgRajpH1vuOy5vZOodV6T+Y2B+KaCAMugkLLWQ3IxWtW2HE62aR1rTco2AJlEX2Kw
         KwXRQm4b14nA4CLAmRr2iDPubpWargnyxoo4ujWYWmG5tj8QfxkRq3pd/xiTUIN0wF3H
         MlygidnURqfW7f6Fbc5K6J2y+vBaWOntuyjPqNOQj475UwAc5eZd7sIjt2z4s1BbJIUl
         iUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0fzHjv868ZwmWk9SP+jSuagQk79taDSQsOw4MHTBAkc=;
        b=dz37t4nYWrX6PA4FCYoVGISaZcXZ8zR5Av3ZqpHW3EK4+ZW6lg5PkCmmiPRoQeXhOc
         BGObNefHjHUToPU7Oha+WDUhaqdJXQT2UfDRWxn2uRxbauC952gAPjoyJOtXzkEw0s1B
         HeOetQ+J1EHWpPrfjk0NeQxRVn+RPP+Gn1JhKCUYyuQPtT6aSgXMjKOFRxrK48nt/MyH
         P7I/S+RtlsESvLl8Xj2E0O3nt3E2A60uagApc9FsstGf+F7/ois40Jq3sJqOlRQ5VAxo
         Vx/L0o83t5FADOLxBb6YcpJNTpY9gvueGIAcpVjJtA5+0LXs43oD5VeDB1wma9BZl776
         JNFw==
X-Gm-Message-State: AE9vXwNj1InVrlYuVDojEWJdPoJjYgIJsn/sJrMpwlI/P/70WzxtzGRkLFnXMc8a2qEoTQ==
X-Received: by 10.25.33.72 with SMTP id h69mr10491493lfh.8.1474366878110;
        Tue, 20 Sep 2016 03:21:18 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.85.178])
        by smtp.gmail.com with ESMTPSA id 78sm2859774ljj.4.2016.09.20.03.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2016 03:21:17 -0700 (PDT)
Subject: Re: [PATCH v2 09/14] MIPS: Malta: Probe RTC via DT
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <20160919212132.28893-1-paul.burton@imgtec.com>
 <20160919212132.28893-10-paul.burton@imgtec.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55c977d1-21dd-4cf8-d0f9-10d96b452573@cogentembedded.com>
Date:   Tue, 20 Sep 2016 13:21:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160919212132.28893-10-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55202
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

On 9/20/2016 12:21 AM, Paul Burton wrote:

> Add the DT node required to probe the RTC, and remove the platform code
> that was previously doing it.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>
> ---
>
> Changes in v2:
> - Remove rtc DT node label

    Haven't you also renamed the node?

>  arch/mips/boot/dts/mti/malta.dts     | 15 +++++++++++++++
>  arch/mips/mti-malta/malta-platform.c | 21 ---------------------
>  2 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
> index af765af..fecbca8 100644
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
> +		rtc@70 {
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
