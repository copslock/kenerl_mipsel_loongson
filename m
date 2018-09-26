Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 04:53:21 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:34820
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeIZCxPYwmmU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 04:53:15 +0200
Received: by mail-pg1-x544.google.com with SMTP id v133-v6so5466765pgb.2;
        Tue, 25 Sep 2018 19:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wminz0EzTH1jInvRsoX9C8RhecCOV4esJ2yXhMEfIQk=;
        b=GstQsTkLYXCLzOAcmZjqM1DPvp7LG2cWUnzycLDoDQHXUUDa9om0wHB10MYg+5pfDv
         bfeKUcFIoapK1q0G6uGe5Qt4K0Obu9Aly1DHatesddOHIH8BV+VVdghPsIP1ZdoM3I0D
         qfUCCs99HREtiD4fNHlQ7AmI/lYNU+xtuFcZKAV4zM6p6IkO2qo0eujP6MxdH7yg9mDJ
         ZSC1tVBSHjfyRZP+vnLbNtcxlzVT0ko6gcqJu+vDe0S9ZihwNRWGeHPARuhFWyNKaZjT
         K1dxy1VgH8cQ0vhftZNvym9G0qUXZWMzMbGlNaGgfBoU7ou7DdYMAMe1d3RcGgPeeyNL
         L2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wminz0EzTH1jInvRsoX9C8RhecCOV4esJ2yXhMEfIQk=;
        b=EnZpUV810F5YpnlqLSRw5YOGByCc41jez2HAAd5zREy4825YlQkG8o65XNTj2WDbGq
         fHbjZUmlWDvFLRZDRyD+mo0VkW6mQ7klVRno5o1Nqpa5Bgdqv3Mo8fH907whuzvw/Fsz
         LqStbUxb9teFI2Syg4HUguKjfTBQRyn0Uh/MYN0v0ZIcMs7ClYKu7BdvWRk7+1wU+NvW
         iLqUx8crbux+t4s5nLlk/jDRB8yi3TWzHItQ7tLn3Zl6osSNnEDt3+ZUjK45hbeq6rJs
         /lVn6I2ReC/BQ3kbEeuJU+3RYhw0/GxFLbOBUeZ9s2VIlOD4Xog+2kYJNolpXnzYxgK2
         k4hA==
X-Gm-Message-State: ABuFfohAQj7P8awJXRK1mkmpkk4h5AtVgxuaH5ohee7j22f8vwrbyKeI
        DjcAUQUg9X1gzBmpW6KgaY0=
X-Google-Smtp-Source: ACcGV63UHsGd9cH5AaiqJeeD+pBMDtZKsumrgqNsw1qdSpTBTb6F1xUJfonRedipYFT4yRHLSTCYLA==
X-Received: by 2002:a17:902:758f:: with SMTP id j15-v6mr3908872pll.160.1537930388571;
        Tue, 25 Sep 2018 19:53:08 -0700 (PDT)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id k71-v6sm5582068pge.44.2018.09.25.19.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 19:53:07 -0700 (PDT)
Subject: Re: [PATCH 3/4] MIPS: BMIPS: Remove special handling of
 CONFIG_MIPS_ELF_APPENDED_DTB=y
To:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-kernel@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
 <20180925180825.24659-4-yasha.che3@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <27cf7925-71a1-42f1-db52-7598663edd65@gmail.com>
Date:   Tue, 25 Sep 2018 19:52:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925180825.24659-4-yasha.che3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66563
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



On 9/25/2018 11:08 AM, Yasha Cherikovsky wrote:
> The ELF appended dtb can be accessed now via 'fw_passed_dtb'.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/mips/bmips/setup.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index 3b6f687f177c..b71b6eaaf7ed 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -153,8 +153,6 @@ void __init plat_time_init(void)
>   	mips_hpt_frequency = freq;
>   }
>   
> -extern const char __appended_dtb;
> -
>   void __init plat_mem_setup(void)
>   {
>   	void *dtb;
> @@ -164,15 +162,10 @@ void __init plat_mem_setup(void)
>   	ioport_resource.start = 0;
>   	ioport_resource.end = ~0;
>   
> -#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
> -	if (!fdt_check_header(&__appended_dtb))
> -		dtb = (void *)&__appended_dtb;
> -	else
> -#endif
>   	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
>   	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
>   		dtb = phys_to_virt(fw_arg2);
> -	else if (fw_passed_dtb) /* UHI interface */
> +	else if (fw_passed_dtb) /* UHI interface or appended dtb */
>   		dtb = (void *)fw_passed_dtb;
>   	else if (__dtb_start != __dtb_end)
>   		dtb = (void *)__dtb_start;
> 

-- 
Florian
