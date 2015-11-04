Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 12:26:59 +0100 (CET)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36309 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011208AbbKDL05HGK2c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2015 12:26:57 +0100
Received: by lbjm5 with SMTP id m5so14052657lbj.3
        for <linux-mips@linux-mips.org>; Wed, 04 Nov 2015 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=C2u6wksnP2XOBMOhTm1Co0qfWZ7kvZGooWoqKq+zA3Q=;
        b=Tc2sFCRKl8zZg1T2Q21cq40b+r2lV8bNdKBc/RofVFCi8BMBSmaN1T5n9wIS9Sagwl
         ZVBeNLNYGaEl7U011x9Uv0Dd1M8cbhrrB/TMuHeizW/vlElBYpj4ocgwjuHLmRI/QwOp
         CfntNmzCHToou8ckruXOD9uLffVKk4fAzp1KRKzkgLatYwV77PIZfaBp6JpezuJBdSTF
         vX+zO0FzIwuDvMGjNCv/qG2q9Vf89aZq7iLm3pvtRwj/gkZdoMH7qaCwmjm50I35vEVW
         8TS5pSldWqrwfHjdjYVSrQ2GyKDljxI3zhZk5S9OYb3qkfoUPwS+Av+9OqMEe3saeTFT
         OgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=C2u6wksnP2XOBMOhTm1Co0qfWZ7kvZGooWoqKq+zA3Q=;
        b=iXlQHSPHKWFy+ua1+q4mcpsUm+0TkVSif0zBEYCf3mfqAOCTEkhYTm0bv3AbIddOhD
         ZOrKvsQ94Y75jpKqppzffYUj1WkQB+fVkSHqQsBZQe9d3+FLuw90fD3Re6aSECnrXmJW
         rdkbJJnOww5snV1lMolYy09tZuUf3EofVpl5JIkRb/SW0KablSILHmv01aL4at4ioZ3T
         xdFKw34W6xr1L9oYrqPdC+qQ+duQ979F2TPntNZsy8W1H3jPGS3iZlrJGewHN1msm689
         Na/3HsUqYr3bffqrcibMH4fuxNnu1vaOyCUnd02u1qKlx2SbsORFKyV2PmJkf+S1Gqxe
         zbdg==
X-Gm-Message-State: ALoCoQl6Iex+711ITeIyic1H3WcvFAdfzc4a/jJWv0DDpJZi/+9mkC/TSGeHajS0HOKC1+oFZI1b
X-Received: by 10.112.9.131 with SMTP id z3mr690264lba.63.1446636411624;
        Wed, 04 Nov 2015 03:26:51 -0800 (PST)
Received: from [192.168.4.126] ([31.173.80.214])
        by smtp.gmail.com with ESMTPSA id u12sm130133lbk.45.2015.11.04.03.26.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 03:26:50 -0800 (PST)
Subject: Re: [PATCH 4/9] arch: mips: ralink: add tty detection
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
 <1446634214-11564-4-git-send-email-blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5639EB7A.6030604@cogentembedded.com>
Date:   Wed, 4 Nov 2015 14:26:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1446634214-11564-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49836
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

On 11/4/2015 1:50 PM, John Crispin wrote:

> MT7688 has several uarts that can be used for console. There are several
> boards in the wild, that use ttyS1 or ttyS2. This patch applies a simply
> autodetection routine to figure out which ttyS the bootloader used as
> console. The uarts come up in 6 bit mode by default. The bootloader will
> have set 8 bit mode on the console. Find that 8bit tty and use it.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/early_printk.c |   26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
> index 255d695..36c2468 100644
> --- a/arch/mips/ralink/early_printk.c
> +++ b/arch/mips/ralink/early_printk.c
[...]
> @@ -47,8 +49,32 @@ static inline int soc_is_mt7628(void)
>   		(__raw_readl(chipid_membase) == MT7628_CHIP_NAME1);
>   }
>
> +static inline void find_uart_base(void)
           ^^^^^^
    We let gcc figure it out itself these days.

[...]

MBR< Sergei
