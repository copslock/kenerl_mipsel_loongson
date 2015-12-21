Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2015 07:31:05 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34268 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007379AbbLUGbDNoNo8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Dec 2015 07:31:03 +0100
Received: by mail-wm0-f66.google.com with SMTP id l126so12630463wml.1;
        Sun, 20 Dec 2015 22:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=IKje95YVvxfCfQPlzAIzjm2RoIVBEr7shwrtJwvnSyE=;
        b=cQB0ynerVEjFnRYO0Ejythcylo+Rd5UTFAHR+E5vkNv63SNAPQFzl5QyfCS890FA60
         VvWt+eSfCgoPTIw5yM4lwGxC+YVVP9JkwNjV9m4QI+Bkrr+unlVaa0DIUKklptxP7loO
         j2JxlLacKpfqj8TFEJr1ykxsDamsnelqMg5MjFl2Ysk8cd3cFdH5k+SdaXROjY2yRBel
         ghp9s5sn20A6AgiuoCAGNcNkPyJ1U8rk4kIzuhq/TivsUg/nL97KstGaMky4nc+asnVh
         bmFI/oXOB/hyK46uZtJji952lOmnyIETJRttaoLK3k3ZgvykDr/7TQT4Ua2j6qvAhUuS
         378g==
X-Received: by 10.28.86.196 with SMTP id k187mr17650354wmb.61.1450679457986;
        Sun, 20 Dec 2015 22:30:57 -0800 (PST)
Received: from [192.168.1.20] (x5d845e83.dyn.telefonica.de. [93.132.94.131])
        by smtp.gmail.com with ESMTPSA id cl2sm26549555wjc.33.2015.12.20.22.30.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Dec 2015 22:30:57 -0800 (PST)
Subject: Re: [PATCH] MIPS: fix macro typo
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>
References: <1450669655-62959-1-git-send-email-jaedon.shin@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <56779C9E.4040907@gmail.com>
Date:   Mon, 21 Dec 2015 07:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1450669655-62959-1-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <alexander.sverdlin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@gmail.com
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

Hello Jaedon,

On 21/12/15 04:47, Jaedon Shin wrote:
> Change the CONFIG_MIPS_CMDLINE_EXTEND to CONFIG_MIPS_CMDLINE_DTB_EXTEND
> to resolve the EXTEND_WITH_PROM macro.
> 
> Fixes: 2024972ef533 ("MIPS: Make the kernel arguments from dtb available")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

looks good,
Reviewed-by: Alexander Sverdlin <alexander.svedlin@gmail.com>

> ---
>  arch/mips/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 66aac55df349..569a7d5242dd 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -623,7 +623,7 @@ static void __init request_crashkernel(struct resource *res)
>  
>  #define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
>  #define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
> -#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_EXTEND)
> +#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
>  
>  static void __init arch_mem_init(char **cmdline_p)
>  {
