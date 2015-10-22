Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2015 03:57:18 +0200 (CEST)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34676 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011312AbbJVB4xfScH5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2015 03:56:53 +0200
Received: by obbda8 with SMTP id da8so56303202obb.1;
        Wed, 21 Oct 2015 18:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=Ive2xvyvUqnCfNxJBnEmBqp51LCytxcFH92rHNoHTvA=;
        b=ENagHOmAm7aRA1IzjCfxYYHVm1VP8nUQjgrrKJ9DonfAjzRMDnx5tLAzmL+eR5Tmlf
         EhZy1hHukxU6dx55d6JMgBBPMC6dtmbek0j0B235CLmUNrJQOxZzuG6N78Pg+SRhss/C
         ZEb13RDwdjdoly7bmGbZiHblh+dAD153BQsHhwu1xrlRy3kJUi9VIbJ+f3nR+3qugD5Q
         7OeS2XTXSt+toiciR5lrwVBOKIYFUUPZBWqPAAToTV6TDeLLfoqesOU2+V+5fs0xLsoL
         nNCV/5Hr6/om33oNjyu7uM1mivz9SkboTyEydn/O3lpMWZvcwEuJ5YMZajbzcEyb5hdM
         B7EA==
X-Received: by 10.182.81.5 with SMTP id v5mr9075869obx.78.1445479006340;
        Wed, 21 Oct 2015 18:56:46 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:44a6:f084:5dfa:7bd0? ([2001:470:d:73f:44a6:f084:5dfa:7bd0])
        by smtp.googlemail.com with ESMTPSA id x2sm4878639oer.3.2015.10.21.18.56.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 18:56:45 -0700 (PDT)
Subject: Re: [PATCH 3/9] i2c: brcmstb: add missing parenthesis
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5628425C.5080104@gmail.com>
Date:   Wed, 21 Oct 2015 18:56:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49635
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
> Add the necessary parenthesis for NOACK condition.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 6b8bbf99880d..2d7d155029dc 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -305,7 +305,7 @@ static int brcmstb_send_i2c_cmd(struct brcmstb_i2c_dev *dev,
>  	}
>  
>  	if ((CMD_RD || CMD_WR) &&
> -	    bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
> +	    (bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK)) {
>  		rc = -EREMOTEIO;
>  		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
>  			cmd_string[cmd]);
> 


-- 
Florian
