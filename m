Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 14:12:49 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:54362 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856016AbaHHMMZDXOYX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2014 14:12:25 +0200
Received: by mail-la0-f42.google.com with SMTP id pv20so4602185lab.15
        for <linux-mips@linux-mips.org>; Fri, 08 Aug 2014 05:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4jqZ/lk2CbnwVtfCC2uze4mcHpjiwp5hr6MxV8OoYP8=;
        b=eViBSWJdLA0X48TLbmr8EZBMbm8mNtB95BQuSdYrbsjsD+kjnl5dYYw5T/TuPrmVhh
         V55XYzBbUw1Vk/jMrbnJQWrkYpfyn6Gfzfq7cX8T24coN3oCwLKyl/gjqpcZqnzVrWAj
         Ut8PmjO4LTYffQq0E4o/zLnnunt6G1wCoqLkvI7I+N1z1HV5Y3cOZfPCRtUqoqnAujkV
         SiQ74PSWENyZp6M17q65ns0F9hDjbF2bQ+ENrzpBswQZUuSBisEXVkGsJqdJ2QuWqhWp
         52GwwYlH/h1tHuNle/6mIPaG2cc3YLySMVEadWqEpVZc6sSCr6eQ0rNDhTZtXKWJHj9L
         GXgA==
X-Gm-Message-State: ALoCoQlRuW+AiUEj6V/Cea8mkgu7uTfRChJ/A+GIE6BnTOX6oZpEDn54YL0UkdTwY/+Zl8GLhkD7
X-Received: by 10.152.3.199 with SMTP id e7mr21804499lae.35.1407499937422;
        Fri, 08 Aug 2014 05:12:17 -0700 (PDT)
Received: from [192.168.2.5] (ppp24-93.pppoe.mtu-net.ru. [81.195.24.93])
        by mx.google.com with ESMTPSA id x10sm1464148lal.13.2014.08.08.05.12.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 05:12:16 -0700 (PDT)
Message-ID: <53E4BEA0.1070501@cogentembedded.com>
Date:   Fri, 08 Aug 2014 16:12:16 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Loongson: Fix COP2 usage for preemptible kernel
References: <1407467768-24097-1-git-send-email-chenhc@lemote.com> <1407467768-24097-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1407467768-24097-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41907
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

On 8/8/2014 7:16 AM, Huacai Chen wrote:

> In preemptible kernel, only TIF_USEDFPU flag is reliable to distinguish
> whether _init_fpu()/_restore_fp() is needed. Because the value of the
> CP0_Status.CU1 isn't changed during preemption.

> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   arch/mips/loongson/loongson-3/cop2-ex.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/arch/mips/loongson/loongson-3/cop2-ex.c b/arch/mips/loongson/loongson-3/cop2-ex.c
> index 9182e8d..c1e9503 100644
> --- a/arch/mips/loongson/loongson-3/cop2-ex.c
> +++ b/arch/mips/loongson/loongson-3/cop2-ex.c
[...]
> @@ -39,8 +39,8 @@ static int loongson_cu2_call(struct notifier_block *nfb, unsigned long action,
>   			KSTK_STATUS(current) |= ST0_FR;
>   		else
>   			KSTK_STATUS(current) &= ~ST0_FR;
> -		/* If FPU is enabled, we needn't init or restore fp */
> -		if(!fpu_enabled) {
> +		/* If FPU is owned, we needn't init or restore fp */
> +		if(!fpu_owned) {

    Space is needed after *if*, high time to fix this.

WBR, Sergei
