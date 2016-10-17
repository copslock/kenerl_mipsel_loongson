Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 15:48:12 +0200 (CEST)
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33061 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991759AbcJQNsD7W7tO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 15:48:03 +0200
Received: by mail-lf0-f41.google.com with SMTP id x79so295911377lff.0
        for <linux-mips@linux-mips.org>; Mon, 17 Oct 2016 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=mel/72jWiG94xGZi7qe90+bUCPNL59KxIZC0mb4S00g=;
        b=HFI9p/Egl9me2u5Qs0Q5yF0Zqnl7/yxuTtlfaUv7eZpz0RQ2YibZjafwIJU1lFzOQ8
         kHWNh/+0Lxi8BWeEGtwzVeN4FUgRceWe+CQO8/AGDV5pW7S8Yvp4SBKWNczQehYOKd9s
         pETWAZkfwc+fwugLdQuSjYWI0/te1eGANX5qwYJmhmMXAGwq/NNVYwB5NFFlO2269zEW
         Bl+SONLGMij92NiQx9norikBbYma/K5MBF0lveKJ6L5zC6lma0HpZr1Xpx6FuFbEdxtA
         BCxK6UdctEJDmZf5vNLCvjdIS6kWLYZ9UjFUoOgmaUW6q7xOxCn8m/gOUu3bclGKlB4q
         WhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=mel/72jWiG94xGZi7qe90+bUCPNL59KxIZC0mb4S00g=;
        b=W2blGJPVTiMSuuvvokQxHDd4nn+ndqzotc6tsUIe/cJ1TeTNzX9bomSm3dzjFsol8Z
         4D9EEKZXerCqaOL5QNC0xXQMddCRnG6/MuFJ1lND8ogOFf6CVGBC54Atb8wWfR22dKlU
         1yGrEhHfZQ0LLDKZwnSESa8sFSAC6X6MitjMjwQndz+fA8rQ2cGGK7YM8E4/W3louGGb
         72Euu4+POmbyPPBKphwr/gWQBTWl2YLlws5K0j+hd6wB63d1BBfvWN8ZTlxMrZwOk8Pc
         7pLcF+lMgmVDfwBnml7uFBLv3lIIwEYrPK/uIt8CMcZqzhSETUl0gp0ubrPU4m0ZEGT+
         KYDQ==
X-Gm-Message-State: AA6/9RlUdoejc6XFnoSl28eucGrqR8V3bCRDaUgUcOLqXtPRIu/TS9Kfr3xxdnZdGJ4q/g==
X-Received: by 10.25.196.193 with SMTP id u184mr13494713lff.32.1476712078415;
        Mon, 17 Oct 2016 06:47:58 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.174])
        by smtp.gmail.com with ESMTPSA id 24sm7910974lfr.49.2016.10.17.06.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2016 06:47:57 -0700 (PDT)
Subject: Re: [PATCH] MIPS: KASLR: Fix handling of NULL FDT
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1476698694-6685-1-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, "# 4 . 7+" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <02ddfa7e-62a5-8ef2-393f-cdd9b5f76bb8@cogentembedded.com>
Date:   Mon, 17 Oct 2016 16:47:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1476698694-6685-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55453
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

On 10/17/2016 01:04 PM, Matt Redfearn wrote:

> If platform code returns a NULL pointer to the FDT, initial_boot_params
> will not get set to a valid pointer and attempting to find the /chosen
> node in it will cause a NULL pointer dereference and the kernel to crash
> immediately on startup - with no output to the console.
>
> Fix this by checking that initial_boot_params is valid before using it.
>
> Fixes: 405bc8fd12f5 ("MIPS: Kernel: Implement KASLR using CONFIG_RELOCATABLE")
> Cc: <stable@vger.kernel.org> # 4.7+
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>
>  arch/mips/kernel/relocate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
> index ca1cc30c0891..8810183840ca 100644
> --- a/arch/mips/kernel/relocate.c
> +++ b/arch/mips/kernel/relocate.c
> @@ -200,6 +200,7 @@ static inline __init unsigned long get_random_boot(void)
>
>  #if defined(CONFIG_USE_OF)
>  	/* Get any additional entropy passed in device tree */
> +	if (initial_boot_params)
>  	{

    CodingStyle: *if* and { should be on the same line.

[...]

MBR, Sergei
