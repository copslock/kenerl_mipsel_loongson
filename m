Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 19:38:48 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:42370
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990765AbdKWSilwxw7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 19:38:41 +0100
Received: by mail-lf0-x244.google.com with SMTP id m1so22948492lfj.9
        for <linux-mips@linux-mips.org>; Thu, 23 Nov 2017 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgwGG4HljnyiUE3cEYRRUQT8H9qw9aBMwi72y8sADmk=;
        b=QUnNi34Ig+5fUIFk0bMWahSK+dgqiIM4itghvMg3vEwW1fO72mrUKLHi2/j2tN+cRX
         VKN60rQMkOfLoXptc2B4oGTa50TYTpTSpZ3JyNuWVNeCXlmE+BDvH54/faoCplmJEdBT
         m864yGURa9Ere9DzjBSCfWySz4TVxi3TUBhWi24k+i1T9YILE/I16jQDNgggIOTpKCih
         AxvPR7g9mZ8EgtXmpQd6lg3ag3FecdJF2Vd3oIBwuOf7STQvHGo4KFnhOG6JM278Fdyh
         6tVZ6Q20OYp5LM9l9hw3XazwR++A/gbN1HqgqFHLA9U1HTszfBusEyQbhRvpXbZZ8gZ8
         AX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UgwGG4HljnyiUE3cEYRRUQT8H9qw9aBMwi72y8sADmk=;
        b=NiLugiLnipVBB5JrS+erhstjG69+RfBQcMOP+VozidmrlRgCwIcxzgd+XkVapWVMS7
         xP65NqHMI980hVbAs+Gl6iDxdJ5ldrGhTusDZIOU2eMkG+z8R18YZS2qkV7k7WuI67rB
         Tv990HWez/FpAcSNbEcnCdVrLL+1HgHA+D3ZqeesDL2vGP96uBru/GfYZipDFx2TAvn6
         j4OA6AlkWWIkbtbbsM6ww4wuDCqDCXyWi8fyBWUhJFRTB2Hv3vkm3Jsx8FxcA0i232WQ
         BqHoXXbNq8+GiPgICtn9gBKtuvs/XWwZcJjDsc5+TRuOfHuTr9LxbZtbtPVoScKn+3T5
         Uq2w==
X-Gm-Message-State: AJaThX4dyEGlvfGW34H5la8fzSGa5hQ/bAVOBCRugR5DGKE1EMf1tKfg
        pH3nEBjqBbCItTDvU6CvByKbdlk3s/g=
X-Google-Smtp-Source: AGs4zMah9q6Wnn2os8Y975oA9cMTIvdAx2m8MZNgIetW9klyMRx2lFCEZC/h45KX4YinkRz06jf23w==
X-Received: by 10.46.2.17 with SMTP id 17mr10518773ljc.67.1511462316221;
        Thu, 23 Nov 2017 10:38:36 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.76])
        by smtp.gmail.com with ESMTPSA id x27sm3432947lfb.23.2017.11.23.10.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 10:38:35 -0800 (PST)
Subject: Re: [PATCH v2] MIPS: ralink: Fix platform_get_irq's error checking
To:     Arvind Yadav <arvind.yadav.cs@gmail.com>, john@phrozen.org,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <4b30004af37521b2102a4eda7c15f7257437ac85.1511451615.git.arvind.yadav.cs@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bd7daee7-9858-be6e-d640-23c889b7e337@cogentembedded.com>
Date:   Thu, 23 Nov 2017 21:38:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4b30004af37521b2102a4eda7c15f7257437ac85.1511451615.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61069
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

On 11/23/2017 06:45 PM, Arvind Yadav wrote:

> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2: Subject spelling was not correct. change FIX in place
>                 of 'ix'.
> 
>   arch/mips/ralink/timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
> index d4469b2..913dc84b 100644
> --- a/arch/mips/ralink/timer.c
> +++ b/arch/mips/ralink/timer.c
> @@ -109,7 +109,7 @@ static int rt_timer_probe(struct platform_device *pdev)
>   	}
>   
>   	rt->irq = platform_get_irq(pdev, 0);
> -	if (!rt->irq) {
> +	if (rt->irq < 0) {
>   		dev_err(&pdev->dev, "failed to load irq\n");
>   		return -ENOENT;

    Also makes sense to propagate the error instead of -ENOENT...

[...]

MBR, Sergei
