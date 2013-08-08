Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 12:58:38 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:47235 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865306Ab3HHK6aEPBGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 12:58:30 +0200
Received: by mail-la0-f44.google.com with SMTP id fo12so2008762lab.17
        for <linux-mips@linux-mips.org>; Thu, 08 Aug 2013 03:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aihUncchjRxSk7viXVWDwS/SFwmF0EPeEZjCDwXHZQQ=;
        b=efnI1Xl2ueCGoR05D1PS36pzCuBI95VCeZNBF3wYnQeyanNluuJ0TE/6wC2bOnN+RI
         9HCYFwhBKODn63EAVlUlH/1TO7AK4B3y3JUi1e3peGc2yQVhzMlZJ4Cwgj0VIlowmSBW
         9hikhcT+zrGTNcOdJtREHyRwb6E7UAkY3ZvP2Ji0rE6kvkn2cY3PqSX6FPVDD1hnPauf
         U4GYxsuSyq+YJ+1OUqulaTvQFA86nr2nwWGPQQAZQjLIMGuAiZCyP9dAXEI5Yizx9bcI
         zP6cEV6hhW/VT2u4hEZjgLho3uVL7cM/Q+aiOWi8P9aBncye6cdfPsO3+xBWMYnHJ/Cn
         Ne4g==
X-Gm-Message-State: ALoCoQl0WPV8OglptlKPctU9XSEkmr4sQPguHzg8fVTZJsCXJ8ZsLzv/aW69JYKr0dHITldMvPOs
X-Received: by 10.112.97.132 with SMTP id ea4mr2013395lbb.80.1375959504375;
        Thu, 08 Aug 2013 03:58:24 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-149-206.pppoe.mtu-net.ru. [91.76.149.206])
        by mx.google.com with ESMTPSA id p17sm4835857lbv.11.2013.08.08.03.58.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 03:58:23 -0700 (PDT)
Message-ID: <520379D4.9040903@cogentembedded.com>
Date:   Thu, 08 Aug 2013 14:58:28 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/4] MIPS: lantiq: adds minimal dcdc driver
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org> <1375952846-25812-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1375952846-25812-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37456
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

On 08-08-2013 13:07, John Crispin wrote:

> This driver so far only reads the core voltage.

> Signed-off-by: John Crispin <blogic@openwrt.org>
[...]

> diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
> new file mode 100644
> index 0000000..6361c30
> --- /dev/null
> +++ b/arch/mips/lantiq/xway/dcdc.c
> @@ -0,0 +1,75 @@
[...]
> +static int dcdc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get resource\n");
> +		return -ENOMEM;
> +	}

    You do not need to check this with devm_request_and_ioremap() or
devm_ioremap_resource().

> +
> +	/* remap dcdc register range */
> +	dcdc_membase = devm_request_and_ioremap(&pdev->dev, res);

    Use devm_ioremap_resource().

> +	if (!dcdc_membase) {
> +		dev_err(&pdev->dev, "Failed to remap resource\n");

    Error messages are already printed by devm_request_and_ioremap() 
ordevm_ioremap_resource().

> +		return -ENOMEM;

    -EADDRNOTAVAIL is the right code for devm_request_and_ioremap().

WBR, Sergei
