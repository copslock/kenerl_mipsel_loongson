Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2015 03:57:02 +0200 (CEST)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33946 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011169AbbJVB4ctHcr5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2015 03:56:32 +0200
Received: by oies66 with SMTP id s66so39922506oie.1;
        Wed, 21 Oct 2015 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=m7czvE7NhBJ8MFBKY0fCkTjgwWvCNjh7jd0u29WcpBg=;
        b=0kRHer8Lbm2786R6DtWHT8wYGxRx5nwSEyb3pg5qZLqxHanAjockNrFUN6P9mhN+/K
         isBKzMkQskKStMTdBU6IyeGXeakXHMbWlW3WwWKcI0V0zUkamCkQsKAXIfyW7IYDYwkI
         oOusSonE1WWTOQoONDGxQg0SaYYbG9EIds3TwmOI0ilh048QEo6XhuqfRwyPf9lUjif3
         /hO7wBxmPyPN1DQ1Zcfw7dDFT4r3xvH64o4W+sYqJ9By4uo/U9WvhoIiK9wkuo67R4be
         aPFakspBCBJBH4SX14Gbil7KBhvobvZyFhXtkmB9fsmioYUEYeRutGhDBKqVWD+g5/W0
         cZcg==
X-Received: by 10.202.55.212 with SMTP id e203mr8224764oia.23.1445478986920;
        Wed, 21 Oct 2015 18:56:26 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:44a6:f084:5dfa:7bd0? ([2001:470:d:73f:44a6:f084:5dfa:7bd0])
        by smtp.googlemail.com with ESMTPSA id w125sm4935336oib.22.2015.10.21.18.56.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 18:56:26 -0700 (PDT)
Subject: Re: [PATCH 2/9] i2c: brcmstb: fix typo in i2c-brcmstb
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-3-git-send-email-jaedon.shin@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56284248.7040603@gmail.com>
Date:   Wed, 21 Oct 2015 18:56:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445395021-4204-3-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49634
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

Le 20/10/2015 19:36, Jaedon Shin a écrit :
> Fixes the "definitions" where it is spelled "defintions".
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 8e9637eea512..6b8bbf99880d 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -41,7 +41,7 @@
>  #define BSC_CTL_REG_INT_EN_SHIFT			6
>  #define BSC_CTL_REG_DIV_CLK_MASK			0x00000080
>  
> -/* BSC_IIC_ENABLE r/w enable and interrupt field defintions */
> +/* BSC_IIC_ENABLE r/w enable and interrupt field definitions */
>  #define BSC_IIC_EN_RESTART_MASK				0x00000040
>  #define BSC_IIC_EN_NOSTART_MASK				0x00000020
>  #define BSC_IIC_EN_NOSTOP_MASK				0x00000010
> 


-- 
Florian
