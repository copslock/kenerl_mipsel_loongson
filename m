Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 14:47:36 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:65081 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861309AbaGQMresqcR4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 14:47:34 +0200
Received: by mail-la0-f42.google.com with SMTP id pv20so1192583lab.15
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 05:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9oZ8VVe4hxGAoZCGyyCRPau+i51+fcDetLPyYhK7v50=;
        b=fwYdjFDdarsKui5npeafTq/HIKPpou+FtRhym6JkIjqqK6L4ELTwdMec/JTBSG3lua
         uUIqe2lzUvLETVJrZfz1yF83aNbWhaziZinsrGtChrXWaM5xEvi8ZOe2sXZLNcQRC8es
         kSgQNRYzx9ao/vOXzo1llRB4w6FCf/IsifS6AaSO8dUj4QpccUs8o5ZXaJo46oDCO6Nx
         E8ri8wmz8eGbMEo1zkRdQ5aG9Kuj5vevEt1kC4QQN1ZN7uDR6QzxiPXtcyUPaMN5MH1y
         rAb+dubcNABux/hwKun8b5wThf3a7mx/4cypEFTWlK4DtqM+/BnAhnEqKia1Ov++Ohyz
         mVSw==
X-Gm-Message-State: ALoCoQnedkGMkPLFuJJYrFa4kX5Kfj4Nip/Br0ttaiKYOW/ZRHvcOhn6MmfkZ+CdUxeBi81gBjY3
X-Received: by 10.152.115.229 with SMTP id jr5mr3389344lab.94.1405601249069;
        Thu, 17 Jul 2014 05:47:29 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-250-78.pppoe.mtu-net.ru. [83.237.250.78])
        by mx.google.com with ESMTPSA id yr11sm3289221lbb.5.2014.07.17.05.47.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 05:47:28 -0700 (PDT)
Message-ID: <53C7C5E2.1020307@cogentembedded.com>
Date:   Thu, 17 Jul 2014 16:47:30 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>
Subject: Re: [PATCH 7/7] MIPS: GIC: Fix GICBIS macro
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com> <1405585259-24941-8-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1405585259-24941-8-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41272
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

On 07/17/2014 12:20 PM, Markos Chandras wrote:

> From: Jeffrey Deans <jeffrey.deans@imgtec.com>

> The GICBIS macro could update the GIC registers incorrectly, depending
> on the data value passed in:

> * Bits were only OR'd into the register data, so register fields could
>    not be cleared.

> * Bits were OR'd into the register data without masking the data to the
>    correct field width, corrupting adjacent bits.

> Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/asm/gic.h | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
> index 8b30befd99d6..3f20b2111d56 100644
> --- a/arch/mips/include/asm/gic.h
> +++ b/arch/mips/include/asm/gic.h
> @@ -43,18 +43,17 @@
>   #ifdef GICISBYTELITTLEENDIAN
>   #define GICREAD(reg, data)	((data) = (reg), (data) = le32_to_cpu(data))
>   #define GICWRITE(reg, data)	((reg) = cpu_to_le32(data))
> -#define GICBIS(reg, bits)			\
> -	({unsigned int data;			\
> -		GICREAD(reg, data);		\
> -		data |= bits;			\
> -		GICWRITE(reg, data);		\
> -	})
> -
>   #else
>   #define GICREAD(reg, data)	((data) = (reg))
>   #define GICWRITE(reg, data)	((reg) = (data))
> -#define GICBIS(reg, bits)	((reg) |= (bits))
>   #endif
> +#define GICBIS(reg, mask, bits)			\
> +	do { u32 data;				\
> +		GICREAD((reg), data);		\

    Why () only around 'reg', not around 'data'?

> +		data &= ~(mask);		\
> +		data |= ((bits) & (mask));	\

    Outer () not needed.

> +		GICWRITE((reg), data);		\

    Again, why no () around 'data'?

> +	} while (0)

WBR, Sergei
