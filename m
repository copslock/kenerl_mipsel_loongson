Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jun 2013 16:28:54 +0200 (CEST)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38997 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834815Ab3FFO2RZhiYe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jun 2013 16:28:17 +0200
Received: by mail-pd0-f170.google.com with SMTP id x10so3435280pdj.1
        for <multiple recipients>; Thu, 06 Jun 2013 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=wy2F0HM4ygmEgBqqXMX9fmQE6DOeCDmTUV4q3nhz8DM=;
        b=I21kxRWI3MCyeaQysP4E1nAleOoub1Q6JU8Q+huhdKW5kYVskg9rRWn/0yCbQXiQIE
         21jfwZo5KWSAP53Cac7rMNjuRbkpiduAI3vbSd6R0hh3tSLrSauHuxLIzFkO75YN5K1z
         u7N8Wpre9Wqex53ot1aJNG3MVObyx0TNtCQJI4S8bWlcUUSALIIA35WCq00HltzZFhRe
         XSON6z4rGdMOaQAuJ6gw87hS6cXqWCdwPsJ8Hj4wofDSNZ6WW9bWLGFM9BcLyiff7fG6
         iMtNtM7h5bUoyJcXJaAGSPbbNp+/j2gCu7d0PJQe6IXxO/hnWw2wJPhc5T7x5I27kkvA
         86iw==
X-Received: by 10.66.164.199 with SMTP id ys7mr14461541pab.104.1370528890062;
 Thu, 06 Jun 2013 07:28:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.69.17.33 with HTTP; Thu, 6 Jun 2013 07:27:29 -0700 (PDT)
In-Reply-To: <1370526953-17122-1-git-send-email-blogic@openwrt.org>
References: <1370526953-17122-1-git-send-email-blogic@openwrt.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 6 Jun 2013 15:27:29 +0100
X-Google-Sender-Auth: 5jJG2NBw0zFdVncT6Jg0RihrKZ4
Message-ID: <CAGVrzcYkYQjGyo9CWPsOMTkf3QwCfisBk_G_k51bB=6Unj2mRQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: add missing SZ_1M multiplier
To:     John Crispin <blogic@openwrt.org>
Cc:     ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2013/6/6 John Crispin <blogic@openwrt.org>:
> On RT5350 the memory size is set to Bytes and not MegaBytes due to a missing
> multiplier.

You might want to mention that the regression got introduced in
dd63b008 ("MIPS: ralink: make use of the new memory detection code").
This also needs to be in a future 3.10-rc pull request to Linus.

Cheers
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/of.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
> index f916774..b25c1f2 100644
> --- a/arch/mips/ralink/of.c
> +++ b/arch/mips/ralink/of.c
> @@ -88,7 +88,7 @@ void __init plat_mem_setup(void)
>         __dt_setup_arch(&__dtb_start);
>
>         if (soc_info.mem_size)
> -               add_memory_region(soc_info.mem_base, soc_info.mem_size,
> +               add_memory_region(soc_info.mem_base, soc_info.mem_size * SZ_1M,
>                                   BOOT_MEM_RAM);
>         else
>                 detect_memory_region(soc_info.mem_base,
> --
> 1.7.10.4
>
>
