Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:50:46 +0200 (CEST)
Received: from mail-lf1-x142.google.com ([IPv6:2a00:1450:4864:20::142]:35042
        "EHLO mail-lf1-x142.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994565AbeIEJulmBnEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:50:41 +0200
Received: by mail-lf1-x142.google.com with SMTP id q13-v6so5463068lfc.2
        for <linux-mips@linux-mips.org>; Wed, 05 Sep 2018 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hyZ1ZqaNSOw/sfTdmu1feA1eLA/fYJh1fUZJik/j0kY=;
        b=GiIcQk3aBW4y0yc+9aROgNah18ycCw/fl45C7ma6a31UJhjzxajM8WoTdTb7f7XyEo
         bCXGAh4jlirR0GesptXcQwntN05zrJLT5pgHlxSGwcWd24RzOQwdi5HSJZ4+ybNzfQFh
         eeWkAqDZ+x6d4amqXK74Ph319ERMMlUak8Gm6HNp9Do3/7sIvx2ZtD2u8wjuRV4G66s3
         i1yAb3XJjIgu9ckszJM129SIiuXB7IfbXsxU52KSa4H0v3WS1L+ob+xYDYfZJlT2775M
         XGGHVTScOYMfGhvkJXR8EAUnfi7OcLH1UGHyDIvitp1dpMDGs+/oYygp5wNPwXCm349h
         KNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hyZ1ZqaNSOw/sfTdmu1feA1eLA/fYJh1fUZJik/j0kY=;
        b=JjfUcXo8iRsnzfY2N7GGPKe9lgxaoS65S1CBYtygiJVSq76sKYH0xBxHi4F+SigbaE
         r/wU96rhtuG5FcbrgciV2P8raqRYC998LlDLnHZbmZRD63VOhnyU/SrgM1OOUB3uCvT1
         9hTwloxDL7hVK+iofGRUqeqKUFUffCmnuxCsNYZYKqfGr5/UILwwndda2R0EKfd776vv
         cL7wH8cASrId3H9ZqDbMYDgT+qKFrTuLhYDAlPLoqdPVujJdZXFJojl8euPLwH+hx9cv
         DiVX0JBKJ+3U30uAkO8GysTGt0rcMq03vZx4O1qXpgTUIYJEFISI+K37GVGR+nPmnFLp
         pDaA==
X-Gm-Message-State: APzg51Dakse2uSEA6r1ccQ8OB4ogy8I/OdQaPqVj+ImBkq7OIYh2OXRk
        oXAO+77HhBCwCvBCpDvKCdBGHg==
X-Google-Smtp-Source: ANB0VdbkLHN/8iCPhfrpgibn10r4z0/rLoAVtcxyeT2GKa0efljixBC/NuyF78PBJydGg1rXb/gzag==
X-Received: by 2002:a19:18d8:: with SMTP id 85-v6mr24071438lfy.133.1536141036042;
        Wed, 05 Sep 2018 02:50:36 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.82.30])
        by smtp.gmail.com with ESMTPSA id f74-v6sm232212lfg.61.2018.09.05.02.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:50:34 -0700 (PDT)
Subject: Re: [PATCH] mips: txx9: fix resource leak after register fail
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <1536133287-21110-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <19c418d6-229c-59e5-ee8e-5dfd12a0355b@cogentembedded.com>
Date:   Wed, 5 Sep 2018 12:50:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536133287-21110-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65949
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

Hello!

On 9/5/2018 10:41 AM, Ding Xiang wrote:

> the memory allocated and ioremap address need free after
> device_register return error.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>   arch/mips/txx9/generic/setup.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> index f6d9182..7f4fd2b 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -961,11 +961,13 @@ void __init txx9_sramc_init(struct resource *r)
>   	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
>   	if (err) {
>   		device_unregister(&dev->dev);
> -		iounmap(dev->base);
> -		kfree(dev);
> +		goto exit_free;
>   	}
>   	return;
>   exit_put:
>   	put_device(&dev->dev);
> +exit_free:
> +	iounmap(dev->base);
> +	kfree(dev);
>   	return;

    *return* not needed here, never was needed.

>   }

MBR, Sergei
