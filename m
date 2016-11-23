Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 09:47:52 +0100 (CET)
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35724 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990778AbcKWIrod2BRS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 09:47:44 +0100
Received: by mail-qk0-f172.google.com with SMTP id n204so6937428qke.2
        for <linux-mips@linux-mips.org>; Wed, 23 Nov 2016 00:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DB5oKLqmLk58KJyVhPOBVg8Mk4j2wClp5EUu9Xric3c=;
        b=GxF0X515vcTuJy4bwRSX9pjKcnBQZeOVzqJNhHvjQ98JMsdL//BnatGLNWjQkVZDwR
         XM6Z90J06CdEoF0gJ+I0W63FexfS96y5WEM0PN1tqHcHXyzghJnctv4/KRBpd4zp078+
         OSVbOGWkerjMPW8adhFY5GoADuIhTLyKRYcwZ0u3NMmLW10i311qVA5kysB7yByiuHj/
         lv+oRQPQWsMpd9rM2H0j5kWOxbclStz1BkaQl3Q8XgiNiKgEk8m9lGCdU+J+E4cbYIl8
         OQ2eczVI2mtPsynLznFYPPixLN4JF01yS50VlM0nl/EkmQDRvFxIH0iN+6afRhZ1nSwS
         /RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DB5oKLqmLk58KJyVhPOBVg8Mk4j2wClp5EUu9Xric3c=;
        b=bUlZubxfT2gv5TvBrhQcUR/dr68lPR/LnXi+QzBAKRt/OdiAmRHKvGV5UU8+UbZZfM
         HCzCW632xTlobSNxK/9MOMGCBaeCwhZKr+YVZBUdcpNN5iy00DRdOspvPEh3bV1d9x2x
         yjqcZFoOUbpSzLGrHe+mjCdhdX6x7snfRBIjohkW5/DcTa4lShVhdjzMyTLxo2ywIjin
         kTU6T1ExGLm9x1ApfK547vElxek3/MVHHOCNQTZuA8SOUvEYvktpf4++bvdsGy6GpwNY
         zoerXvUMGB6mT/Do5Hwg8vWYa4ZWnNcc26yKOx9+JnBoSS66pyvgBqm5fy+q9RiadGve
         Ztrw==
X-Gm-Message-State: AKaTC018TcOMqzej0m8X8Cd5MgzXon+nwYwncluHnnKwIFRQptrP0PvywaXBKPwwgg20Og==
X-Received: by 10.46.7.10 with SMTP id 10mr636819ljh.60.1479890854939;
        Wed, 23 Nov 2016 00:47:34 -0800 (PST)
Received: from [192.168.4.126] ([31.173.81.17])
        by smtp.gmail.com with ESMTPSA id u204sm6964328lja.5.2016.11.23.00.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2016 00:47:34 -0800 (PST)
Subject: Re: [PATCH 2/2 v2] of: Add check to of_scan_flat_dt() before
 accessing initial_boot_params
To:     t.wolf@vplace.de
References: <3700342.djbc9u0nWG@loki> <2281020.GC1GkRyGht@loki>
 <a13d095d-cdc9-8deb-82e2-f19b15748a4a@cogentembedded.com>
 <6667110.cBpoIbUc5V@loki>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d6072e00-1ca4-d461-e15d-3b7b92a7b998@cogentembedded.com>
Date:   Wed, 23 Nov 2016 11:47:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <6667110.cBpoIbUc5V@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55866
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

On 11/23/2016 9:11 AM, Tobias Wolf wrote:

> An empty __dtb_start to __dtb_end section might result in initial_boot_params
> being null for arch/mips/ralink. This showed that the boot process hangs
> indefinitely in of_scan_flat_dt().
>
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
> ---
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -628,6 +628,9 @@
>  				     void *data),
>  			   void *data)
>  {
> +	if (!initial_boot_params)
> +		return 0;
> +
>  	const void *blob = initial_boot_params;
>  	const char *pathp;
>  	int offset, rc = 0, depth = -1;
> ---
>
> Dear Sergei,
>
> After checking the use of "of_scan_flat_dt()" I revised the patch to return 0
> as any other value would most likely break code in:

    It still causes a compiler warning -- you can't mix code and declarations 
in C90.

> Best regards
> Tobias

MBR, Sergei
