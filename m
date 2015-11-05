Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 15:07:47 +0100 (CET)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36257 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012588AbbKEOHqAtlb- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 15:07:46 +0100
Received: by lbblt2 with SMTP id lt2so17097421lbb.3
        for <linux-mips@linux-mips.org>; Thu, 05 Nov 2015 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=e8UH1a/MkLehgREDT8/JTV3xI70Q12TlwZGCOcFvJvA=;
        b=llOsPdC1KE9S6+ZPNKXab4SAjy7G3b32IL6DRwrL6fq6bqXDa9aXy+PTKIP7i8hmea
         fCq9P5G/g9lz7AUBpKNK947WLlsWIsNvQnIwqB5qn5qMpCJzzCNDrT9nLHiWTk2Sicue
         dnbfKTUt+lCqZ4Igo+C7gTT0UNagLJbOHAxVSkWzMVgxoSiu1ntv4VryYkX2kYgAYYA/
         7VMK0K9Cj2GIyLDGIN+EejKue3KTttwKi0lMbHNWWuUIMTqf66KDq0IREMKNdH9C+P7C
         CMUkc783rjgx175KJma+9/9TJQ8b29c7iJmf4uAtDv3mF+oKpluwis8QEvN8TUh1r3kE
         V7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=e8UH1a/MkLehgREDT8/JTV3xI70Q12TlwZGCOcFvJvA=;
        b=SH6mozG/lbIZpFpMbg/oz070NQWW/ZfumUps/2JETBcaVdX7X4/s2aX6LOcyqx3uNJ
         Y/FrGKmax9P5/qblV4x3O9zXEK4SXbaRooWYrUfOuDaahG9nHV4oFsOvXnN/se45xqcH
         J7ChFQFuyJ0JDApKW3+QdIPMNuhd6p8EKkiFXAqKEFJPEfrRT4FlTPcmFbyxvBzSJPKt
         PGmnY0skT5k1bRJFXJ7F0WmSTBovg7ZXq8yi1BP2H2bmllxbFUgPa4/zDCd/qm+wHuD6
         W4NqWya19ZJKQawLTs4Yb3mV2VAHlqDPmoTy6t4o1LG5Es6o7zqPOkYuxymc7Mt9YvYr
         qNDA==
X-Gm-Message-State: ALoCoQltZRwigoVMxjiOpcy6Xb+ATsgrccdzMdb/uW6J2k2mkpZEwvPwCoQuSzUhad+fda7GaRls
X-Received: by 10.112.151.102 with SMTP id up6mr934892lbb.44.1446732460022;
        Thu, 05 Nov 2015 06:07:40 -0800 (PST)
Received: from [192.168.4.126] ([83.149.8.20])
        by smtp.gmail.com with ESMTPSA id j11sm978817lbz.21.2015.11.05.06.07.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2015 06:07:39 -0800 (PST)
Subject: Re: [PATCH V2 4/9] arch: mips: ralink: add tty detection
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1446692398-44153-1-git-send-email-blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <563B62AC.9000407@cogentembedded.com>
Date:   Thu, 5 Nov 2015 17:07:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1446692398-44153-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49852
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

On 11/5/2015 5:59 AM, John Crispin wrote:

> MT7688 has several uarts that can be used for console. There are several
> boards in the wild, that use ttyS1 or ttyS2. This patch applies a simply
> autodetection routine to figure out which ttyS the bootloader used as
> console. The uarts come up in 6 bit mode by default. The bootloader will
> have set 8 bit mode on the console. Find that 8bit tty and use it.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> Changes in V2:
> * remove superflous inline definition
>
>   arch/mips/ralink/early_printk.c |   26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
> index 255d695..3c59ffe 100644
> --- a/arch/mips/ralink/early_printk.c
> +++ b/arch/mips/ralink/early_printk.c
[...]
> @@ -47,8 +49,32 @@ static inline int soc_is_mt7628(void)
>   		(__raw_readl(chipid_membase) == MT7628_CHIP_NAME1);
>   }
>
> +static void find_uart_base(void)
> +{
> +	int i;
> +
> +	if (!soc_is_mt7628())
> +		return;
> +
> +	for (i = 0; i < 3; i++) {
> +		u32 reg = uart_r32(UART_REG_LCR + (0x100 * i));

    Inner parens not needed, the operator precedence is natural.

> +
> +		if (!reg)
> +			continue;
> +
> +		uart_membase = (__iomem void *) KSEG1ADDR(EARLY_UART_BASE +
> +							  (0x100 * i));

    Likewise.
    Sorry for not noticing this before.

MBR, Sergei
