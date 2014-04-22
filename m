Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 15:13:26 +0200 (CEST)
Received: from mail-ee0-f48.google.com ([74.125.83.48]:64837 "EHLO
        mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815784AbaDVNNWvz0oV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 15:13:22 +0200
Received: by mail-ee0-f48.google.com with SMTP id b57so4593952eek.35
        for <linux-mips@linux-mips.org>; Tue, 22 Apr 2014 06:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=lOWFkcvTYAUt1eTUFBdmh4AP3kKaeDk4rOQ/K14FW3w=;
        b=S05jaoXs3QU0XSngmbavt4yIz0tN4PbnbrOwdfhKpVbcVchQto6Vms2dP+/zw5Ff1h
         44ImkWSAMMyJinp43nBTDE/8yVdabdgKqzWQnUKCjdGheR/U5RBbaUzZvXGpEM8gjX3w
         c/txp3rDPF/rMM/7dmJ4/SRHGBjnMCtyXQILy3ZQBagO5SSEWvCrd8fP7ux44GQcZ9Vw
         kgURO2mrJ4Mu1xACkju9RJw7xfkMYUrzUD9mxULtifHzVdYa/uyIdTlDhLZ9xdULd2cQ
         yHKnUCyNYXT6CPKZEWgQZgIswSGiYdRUbtqhT255TSgutu8WyiZRMblsmlF8boqonxwB
         rhHg==
X-Gm-Message-State: ALoCoQmVg4DwBs9ZGr7wUeoaNDyy7Ssy8D1f/aXJeTkpL3YF3NzB4jqgQu3VTwcCcAUxzf3qoUJK
X-Received: by 10.15.22.201 with SMTP id f49mr55999693eeu.18.1398172397490;
        Tue, 22 Apr 2014 06:13:17 -0700 (PDT)
Received: from trevor.secretlab.ca (host31-50-108-136.range31-50.btcentralplus.com. [31.50.108.136])
        by mx.google.com with ESMTPSA id o4sm112969622eef.20.2014.04.22.06.13.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 06:13:16 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 9E6E1C40754; Tue, 22 Apr 2014 15:13:09 +0200 (CEST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] mips: dts: add device_type="memory" where missing
To:     Leif Lindholm <leif.lindholm@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     patches@linaro.org, Leif Lindholm <leif.lindholm@linaro.org>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>
In-Reply-To: <1397756521-29387-3-git-send-email-leif.lindholm@linaro.org>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
        <1397756521-29387-3-git-send-email-leif.lindholm@linaro.org>
Date:   Tue, 22 Apr 2014 14:13:09 +0100
Message-Id: <20140422131309.9E6E1C40754@trevor.secretlab.ca>
Return-Path: <grant.likely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Thu, 17 Apr 2014 18:42:00 +0100, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> A few platforms lack a 'device_type = "memory"' for their memory
> nodes, relying on an old ppc quirk in order to discover its memory.
> Add this, to permit that quirk to be made ppc only.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Mark Rutland <mark.rutland@arm.com>

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>  arch/mips/lantiq/dts/easy50712.dts    |    1 +
>  arch/mips/ralink/dts/mt7620a_eval.dts |    1 +
>  arch/mips/ralink/dts/rt2880_eval.dts  |    1 +
>  arch/mips/ralink/dts/rt3052_eval.dts  |    1 +
>  arch/mips/ralink/dts/rt3883_eval.dts  |    1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
> index fac1f5b..143b8a3 100644
> --- a/arch/mips/lantiq/dts/easy50712.dts
> +++ b/arch/mips/lantiq/dts/easy50712.dts
> @@ -8,6 +8,7 @@
>  	};
>  
>  	memory@0 {
> +		device_type = "memory";
>  		reg = <0x0 0x2000000>;
>  	};
>  
> diff --git a/arch/mips/ralink/dts/mt7620a_eval.dts b/arch/mips/ralink/dts/mt7620a_eval.dts
> index 35eb874..709f581 100644
> --- a/arch/mips/ralink/dts/mt7620a_eval.dts
> +++ b/arch/mips/ralink/dts/mt7620a_eval.dts
> @@ -7,6 +7,7 @@
>  	model = "Ralink MT7620A evaluation board";
>  
>  	memory@0 {
> +		device_type = "memory";
>  		reg = <0x0 0x2000000>;
>  	};
>  
> diff --git a/arch/mips/ralink/dts/rt2880_eval.dts b/arch/mips/ralink/dts/rt2880_eval.dts
> index 322d700..0a685db 100644
> --- a/arch/mips/ralink/dts/rt2880_eval.dts
> +++ b/arch/mips/ralink/dts/rt2880_eval.dts
> @@ -7,6 +7,7 @@
>  	model = "Ralink RT2880 evaluation board";
>  
>  	memory@0 {
> +		device_type = "memory";
>  		reg = <0x8000000 0x2000000>;
>  	};
>  
> diff --git a/arch/mips/ralink/dts/rt3052_eval.dts b/arch/mips/ralink/dts/rt3052_eval.dts
> index 0ac73ea..ec9e9a0 100644
> --- a/arch/mips/ralink/dts/rt3052_eval.dts
> +++ b/arch/mips/ralink/dts/rt3052_eval.dts
> @@ -7,6 +7,7 @@
>  	model = "Ralink RT3052 evaluation board";
>  
>  	memory@0 {
> +		device_type = "memory";
>  		reg = <0x0 0x2000000>;
>  	};
>  
> diff --git a/arch/mips/ralink/dts/rt3883_eval.dts b/arch/mips/ralink/dts/rt3883_eval.dts
> index 2fa6b33..e8df21a 100644
> --- a/arch/mips/ralink/dts/rt3883_eval.dts
> +++ b/arch/mips/ralink/dts/rt3883_eval.dts
> @@ -7,6 +7,7 @@
>  	model = "Ralink RT3883 evaluation board";
>  
>  	memory@0 {
> +		device_type = "memory";
>  		reg = <0x0 0x2000000>;
>  	};
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
