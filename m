Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Oct 2017 17:27:10 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:48572
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990484AbdJVP1CMdbE0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Oct 2017 17:27:02 +0200
Received: by mail-pf0-x244.google.com with SMTP id b79so15341094pfk.5;
        Sun, 22 Oct 2017 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ODeL8Wnu9+qFoqvVBZPYGz2Sx8PnDWuy5gU8XoGbKao=;
        b=QvArhwOih4sjFnfgocDBE693iFvFMJsD+5WXH4KO8XHmh7vlZfCEwl97wpqn55AbW7
         AYQVFOCvqX04nZMpB1+wrlMPA+KzMpTwSuuGdpVSSepgN8JB0a2HY6XpaITVo67ySoy5
         wzqN/iJxsrGoGX+ey8beaEkmRZKTQIYgpru/aANBsfCww47fNUZdPD9j5zLjtrUsTl2Z
         LlwoSUVAvtZ2kaHtiqvyPgVTplAVCqK9XaXNfqebHDsrVQpu73Qo6hCP78XTJu9SXv0R
         4VmmWaerJQUqc028LPi4/6DDDPsIxHRrGFNzEp53p1qLVwp726gZPRTjMlQjWCoGS/24
         vrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ODeL8Wnu9+qFoqvVBZPYGz2Sx8PnDWuy5gU8XoGbKao=;
        b=g90FSrDbQTqJYzOoEPpx5VsU1E+xYd629BOr70VWVxVef/y0Q8KqDo8PUqfSFrqkhh
         sXNXX+hPe7Pa/HUcbk8M0hCxbotf3hJt9yWUWLPs8RiBd/cMfDglAoDL0NzVLypY+y1p
         +xSA9qTaNAaLplLvTWvY5PlGkOuqeR0AZzXbpmDWXSjXaga1I32J4EoN7OKMx/bijWJj
         k0vpdWbWpqVeKgYJJu3XRpuCKWybkjFNKo2+hOLc854DwPj0AkQbPhfXE4pbJa2Q7KGy
         kEwX+H8ythJHpvkSnMjGdeX4S468spOP0DFPEFj+rImkUlA0WymZsMXTusihkGTGvT7+
         W9/Q==
X-Gm-Message-State: AMCzsaXOcVloPNHxSuQL1QdXRSR3grdIGXlIgCHVTuP6QQIXya1wL8fU
        3GhDJPfCiwyyx1xZFikel9M=
X-Google-Smtp-Source: ABhQp+SLQzAFOAwWW53NsThJFEn1MIBNCwm+aFy9/jrqZqETegjD1EgY74cAeXbYAN3JuEoP9gPoNA==
X-Received: by 10.101.67.196 with SMTP id n4mr9185880pgp.395.1508686015629;
        Sun, 22 Oct 2017 08:26:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t63sm8710177pgc.19.2017.10.22.08.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Oct 2017 08:26:54 -0700 (PDT)
Date:   Sun, 22 Oct 2017 08:26:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     no To-header on input <;, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [3/3] MIPS: jz4780: DTS: Probe the jz4740-watchdog driver from
 devicetree
Message-ID: <20171022152653.GA11714@roeck-us.net>
References: <20170908183558.1537-3-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908183558.1537-3-malat@debian.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Sep 08, 2017 at 08:35:55PM +0200, Mathieu Malaterre wrote:
> The jz4740-watchdog driver supports both jz4740 & jz4780.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index 4853ef67b3ab..33d7f49186d6 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -207,6 +207,11 @@
>  		status = "disabled";
>  	};
>  
> +	watchdog: jz4780-watchdog@10002000 {
> +		compatible = "ingenic,jz4740-watchdog";
> +		reg = <0x10002000 0x100>;
> +	};
> +
>  	nemc: nemc@13410000 {
>  		compatible = "ingenic,jz4780-nemc";
>  		reg = <0x13410000 0x10000>;
