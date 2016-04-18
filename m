Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 18:59:24 +0200 (CEST)
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36215 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026933AbcDRQ7VxuTW1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 18:59:21 +0200
Received: by mail-lf0-f51.google.com with SMTP id g184so224316612lfb.3
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2016 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LK4jbc50rM7dKfBQflRABjUZMX2moRM7PhoMD0VMWpM=;
        b=VLtBEPy0wfpNmVnzDb/MhcvwicWBwh3z6h2/SLWmPUab00JzYTrdwwRRGInp+iQ42y
         d5f1LH4EA+PME/GebHhQ5Ojp5Petb+yvU96AkaXHe24EMlYuPof+MQuYeIP4AfMNQnuG
         JPXLGjnG0g/4pV8fEi5gbtEBXEfBTTfvMkLyPGI/mNC/+ScS5TSurxI5toODDjIte7m5
         toj87Q65l7pukLXsa34+qloLO4ijDGYIGGsJ4lfCxyYPzr0H/Vcviq6BGVxpii77GSfJ
         Wu1nD7bV2BYB8kag4Q97RgHBEx477h7iokie1PEbVG9JzcsausrECIw9iSyAmxGEK3E4
         wpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=LK4jbc50rM7dKfBQflRABjUZMX2moRM7PhoMD0VMWpM=;
        b=Bu17jh60YGOkGO9c+792Pn3gbGcQ0PrM1oAHNNGap0KB40HheN6f0dfXZbL/Ms/Zoy
         tvvviNGoWS/ffESfUjzbi3IWAhZMtBkD4peiS/HhmCoh2pyFppk+4voCIHSfK45fesS+
         XHutWq3/ZUwwV4RGT3cPXgItwX0vEawh/s8ZW2dmbawhiCUuaYqMLPpqyaFnnVOuvIHP
         tBnHbcTtjQM99OVMa3CRrRhxF6O1p2I57o8DC5MaTvdlm5sAoEN4MMITT0KwjWiLPsxj
         RSXb1OHp08ulHJjGDKEUhBCaj8pbGQrEEml21m0gKkje63+kA2CRh0r2EPkuPb2EVZfP
         Jupw==
X-Gm-Message-State: AOPr4FVU0UK6upUQ60BCS2gtQ5JVunkEh4JXy6YdsykE07O9eAjlVVRUuYuuMrmfbMsMnw==
X-Received: by 10.112.31.194 with SMTP id c2mr10134264lbi.105.1460998756146;
        Mon, 18 Apr 2016 09:59:16 -0700 (PDT)
Received: from wasted.cogentembedded.com ([83.149.9.178])
        by smtp.gmail.com with ESMTPSA id jo1sm10276780lbc.3.2016.04.18.09.59.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2016 09:59:14 -0700 (PDT)
Subject: Re: [PATCH] mips: pistachio: Determine SoC revision during boot
To:     James Hartley <james.hartley@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Jonas Gorski <jogo@openwrt.org>,
        James Hogan <james.hogan@imgtec.com>
References: <1460989489-30469-1-git-send-email-james.hartley@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <57151260.1060300@cogentembedded.com>
Date:   Mon, 18 Apr 2016 19:59:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1460989489-30469-1-git-send-email-james.hartley@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53067
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

On 04/18/2016 05:24 PM, James Hartley wrote:

> Now that there are different revisions of the Pistachio SoC
> in circulation, add this information to the boot log to make
> it easier for users to determine which hardware they have.
>
> Signed-off-by: James Hartley <james.hartley@imgtec.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>
>
> diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
> index 96ba2cc..48f8755 100644
> --- a/arch/mips/pistachio/init.c
> +++ b/arch/mips/pistachio/init.c
[...]
> @@ -24,9 +26,28 @@
>   #include <asm/smp-ops.h>
>   #include <asm/traps.h>
>
> +/*
> + * Core revision register decoding
> + * Bits 23 to 20: Major rev
> + * Bits 15 to 8: Minor rev
> + * Bits 7 to 0: Maintenance rev
> + */
> +#define PISTACHIO_CORE_REV_REG	0xB81483D0
> +#define PISTACHIO_CORE_REV_A1	0x00100006
> +#define PISTACHIO_CORE_REV_B0	0x00100106
> +
>   const char *get_system_type(void)
>   {
> -	return "IMG Pistachio SoC";
> +	u32 core_rev;
> +
> +	core_rev = __raw_readl((const void *)PISTACHIO_CORE_REV_REG);
> +
> +	if (core_rev == PISTACHIO_CORE_REV_B0)
> +		return "IMG Pistachio SoC (B0)";
> +	else if (core_rev == PISTACHIO_CORE_REV_A1)
> +		return "IMG_Pistachio SoC (A1)";
> +	else
> +		return "IMG_Pistachio SoC";

    How about the *switch* instead?

[...]

MBR, Sergei
