Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 13:48:23 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:57980 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822263AbaDDLsQFGspV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 13:48:16 +0200
Received: by mail-lb0-f173.google.com with SMTP id p9so2345976lbv.4
        for <linux-mips@linux-mips.org>; Fri, 04 Apr 2014 04:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=P+7QbRIavGrDhJJuZ5s7bhFzMGp89SW/mMxH89sbPaU=;
        b=f5ICWYYwCLl6nCQaT/znMx98oHSUhtEMrcX2ERtXl7eTGLePYiktBwoO0pWj5ahfgk
         OntZbZbINgFOjlw1b8/CsVmJ+/5frOX+Pt9eb6IQVvUw0WnbI/pejJkq1wBs/F3m0Bw6
         oJz/1RSpAnwfNZsoOr+gb4otATs7AeMsX/KT4deLfHEeG9OmVAPrULC9MchWaD2xJ1ME
         xRa2yRaQi4GY+mpoVOjEpXVpANuh7wZHPPKbyhc6N4CyY5N31ZdKGofqnbiRuGy63qUy
         rQtGa6kHu9mRANRdf+Ee0CAK5UQR8JOHwCEBO50aydICE+khRbplVYbyVR+/MUX4iE2j
         PDjQ==
X-Gm-Message-State: ALoCoQnI+iLvU++FiwOhmNTqveMm+tBrz2mAJkMM6+oDDxmF2mmE0YU4cfqaxeRSHN75V0x/KL3o
X-Received: by 10.153.7.69 with SMTP id da5mr1339705lad.38.1396612090370;
        Fri, 04 Apr 2014 04:48:10 -0700 (PDT)
Received: from [192.168.2.4] (ppp83-237-56-180.pppoe.mtu-net.ru. [83.237.56.180])
        by mx.google.com with ESMTPSA id zf7sm7665158lab.7.2014.04.04.04.48.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 04:48:09 -0700 (PDT)
Message-ID: <533E9C03.9060808@cogentembedded.com>
Date:   Fri, 04 Apr 2014 15:48:19 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 1/9] MIPS: Support hard limit of cpu count (nr_cpu_ids)
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com> <1396599104-24370-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1396599104-24370-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39651
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

On 04-04-2014 12:11, Huacai Chen wrote:

> On MIPS currently, only the soft limit of cpu count (maxcpus) has its
> effect, this patch enable the hard limit (nr_cpus) as well. Processor
> cores which greater than maxcpus and less than nr_cpus can be taken up
> via cpu hotplug. The code is borrowed from X86.

> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   arch/mips/kernel/setup.c |   18 ++++++++++++++++++
>   1 files changed, 18 insertions(+), 0 deletions(-)

> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index a842154..7ffda01 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -729,6 +729,23 @@ static void __init resource_init(void)
>   	}
>   }
>
> +static void __init prefill_possible_map(void)
> +{
> +#ifdef CONFIG_SMP
> +	int i, possible = num_possible_cpus();
> +
> +	if (possible > nr_cpu_ids)
> +		possible = nr_cpu_ids;
> +
> +	for (i = 0; i < possible; i++)
> +		set_cpu_possible(i, true);
> +	for (; i < NR_CPUS; i++)
> +		set_cpu_possible(i, false);
> +
> +	nr_cpu_ids = possible;
> +#endif
 > +}
 > +

    #ifdef's in the function body are ugly. Instead I'm suggesting:

#ifdef CONFIG_SMP
static void __init prefill_possible_map(void)
{
[...]
}
#else
static inline void prefill_possible_map(void) {}
#endif

WBR, Sergei
