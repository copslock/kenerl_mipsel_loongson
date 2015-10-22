Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2015 03:56:34 +0200 (CEST)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:32941 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011167AbbJVB4ZrRQY5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2015 03:56:25 +0200
Received: by oiad129 with SMTP id d129so39934884oia.0;
        Wed, 21 Oct 2015 18:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=byy70Ik+kRPNoE/aoSzqOL83n10Xb2/l0P8dK2w6Paw=;
        b=IPSiC9arSU5dut4e/bUKbUvkfQV9moGEZDB3eMO+lx9LRAQSGVsnvaqJIxfZfNpeqV
         Zxa6Kssjj0EYAA9kjMDgOBRdHadsWHoKqrJlqgb480n8KR8MRbLqZ7S4owQvzY2jMhbS
         qnNUTbmNGhu4EUKUFES+wm2lkebpgn9jSBdrPO5H02OScGAAm1bgwJhBeH7ijH3RuxCt
         5SMOUtaJ1QsdIwPDNQmnis+QPuqcFWR5NQDnm2mKCF5VvubEYEnbBpZh7y/MUBBKyEs8
         pSiS6Tokk6lbZBqYPHUyV718mjH6D95EkC9fQf1bO97n2yCQK5WBNuk34vMjevqbt5ir
         wGLQ==
X-Received: by 10.202.107.131 with SMTP id g125mr4209698oic.61.1445478979556;
        Wed, 21 Oct 2015 18:56:19 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:44a6:f084:5dfa:7bd0? ([2001:470:d:73f:44a6:f084:5dfa:7bd0])
        by smtp.googlemail.com with ESMTPSA id wf9sm4944984obc.11.2015.10.21.18.56.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 18:56:18 -0700 (PDT)
Subject: Re: [PATCH 1/9] i2c: brcmstb: make the driver buildable on
 BMIPS_GENERIC
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-2-git-send-email-jaedon.shin@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56284240.90405@gmail.com>
Date:   Wed, 21 Oct 2015 18:56:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445395021-4204-2-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49633
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
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for
> I2C.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 08b86178e8fb..fd983c5b36f2 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -394,7 +394,7 @@ config I2C_BCM_KONA
>  
>  config I2C_BRCMSTB
>  	tristate "BRCM Settop I2C controller"
> -	depends on ARCH_BRCMSTB || COMPILE_TEST
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>  	default y
>  	help
>  	  If you say yes to this option, support will be included for the
> 


-- 
Florian
