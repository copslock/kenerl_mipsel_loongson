Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 17:12:20 +0200 (CEST)
Received: from mail-la0-f45.google.com ([209.85.215.45]:41691 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820610Ab3EIPLr7BgoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 17:11:47 +0200
Received: by mail-la0-f45.google.com with SMTP id fp12so2930736lab.4
        for <linux-mips@linux-mips.org>; Thu, 09 May 2013 08:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=6v/WYQ/AeO0DZfWeMMDBPKfe46ALLUcgkub2yGh7nkc=;
        b=EQAxEFn7uF8z/1CVWAGPltL/4kuGKAEunIMIMO5G8wNwGzO1XUSkE932Bc+jGCc6xT
         4RpiXqXjKLExgf4BZQmlIwjlNA78ydaItuOFno54bYwy1GUCRV109MsN1v4jDHD3rJ4j
         O25WgTIswxDHoWUUL6U9jYslA7cA63IMRuWpf5hC4saaoQ2CnFPnqP2Tl3c9od/DFuBS
         sZjrRdZRuFWPg5C8Xh4Ud91QPjDWZd5svKwmjt4AUV4wHDD04i2j9cOtvkkDm1knlIQ9
         4yGFzATAKKk1dJle+bz33YYC28+N1Pu7rRQ4ceYRXyRJfQ3VvZcudRdn7KomFV3eX8Pz
         qGjw==
X-Received: by 10.152.19.132 with SMTP id f4mr5614029lae.16.1368112302300;
        Thu, 09 May 2013 08:11:42 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-144-111.pppoe.mtu-net.ru. [91.76.144.111])
        by mx.google.com with ESMTPSA id r9sm1331446lbr.3.2013.05.09.08.11.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 08:11:41 -0700 (PDT)
Message-ID: <518BBCAF.60608@cogentembedded.com>
Date:   Thu, 09 May 2013 19:11:43 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: get schedule_mfi info from __schedule
References: <20130509144911.GD3562@hades>
In-Reply-To: <20130509144911.GD3562@hades>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnb8KPdLd27uB2JpriZhvSeS8x8zcV/EBYhiBSb6yCrneDpZlMKHunNEcWkenWXN2Xj2lK2
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36367
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

On 09-05-2013 18:49, Tony Wu wrote:

> schedule_mfi is supposed to be extracted from schedule(), and
> is used in thread_saved_pc and get_wchan.

> But, after optimization, schedule() is reduced to a sibling
> call to __schedule(), and no real frame info can be extracted.

> One solution is to compile schedule() with -fno-omit-frame-pointer
> and -fno-optimize-sibling-calls, but that will incur performance
> degradation.

> This patch follows the sibling call and extracts the
> schedule_mfi from the __schedule with and without KALLSYMS enabled.

> Signed-off-by: Tony Wu <tung7970@gmail.com>
> ---
>   arch/mips/kernel/process.c |   28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index a794eb5..289ea69 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -314,15 +314,39 @@ err:
>
>   static struct mips_frame_info schedule_mfi __read_mostly;
>
> +static unsigned long get___schedule_addr(void)
> +{
> +#ifdef CONFIG_KALLSYMS
> +	return kallsyms_lookup_name("__schedule");
> +#else
> +	union mips_instruction *ip = (void *)schedule;
> +	int max_insns = 8;
> +	int i;
> +
> +	for (i = 0; i < max_insns; i++, ip++) {
> +		if (ip->j_format.opcode == j_op)
> +			return J_TARGET(ip, ip->j_format.target);
> +	}
> +	return 0;
> +#endif
> +}
> +

     #ifdef's inside function body are frowned upon. Better code it as:

#ifdef CONFIG_KALLSYMS
static unsigned long get___schedule_addr(void)
{
	return kallsyms_lookup_name("__schedule");
}
#else
static unsigned long get___schedule_addr(void)
{
	union mips_instruction *ip = (void *)schedule;
[...]
	return 0;
}
#endif

WBR, Sergei
