Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Aug 2013 13:18:36 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38783 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865291Ab3HOLS2Ij8yi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Aug 2013 13:18:28 +0200
Received: by mail-lb0-f171.google.com with SMTP id t13so538331lbd.16
        for <linux-mips@linux-mips.org>; Thu, 15 Aug 2013 04:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dquJdF0eacVIWv1Fo6NyCu0b0MRtbZ1Gt5CjcSisFGI=;
        b=CPA0tuHKWniEnfWJbzCJR5WrrWgjzGRT7V+ro+hXiG1Zqp+VzMSGVUBnlMFElAfo+s
         zN6SM4lM3yyDY+XTp1SVgT3Jq4WuvmV+MBnQUnfwx/yoVyVFDh5N7sqm5WvyTWKkqteN
         B2kW4Ib2X9pgGkL6qDQIYFlW49AyqQmHer/ZPIFG+/CkhThxg7P77ewQMQkn5qZbOTBM
         NhGxSe1X09/ydFapDr0laZNRxFTnhikZqpIa8QPjpDxYS0G5+AwIxyFpGV3zFA1qpDVr
         T6LBj5LUEqfKSRICGUzS5YEZowLSG7yXHox2Rvnrxmy4yR53vMEdtyw317VtfZ6t07lY
         NvOA==
X-Gm-Message-State: ALoCoQkxEXP15vJwNBUgy2GbSn5JB+CzfgnK5sWyQompVZ94BBhRQpTF+THdJUHpCm44aBT8Kdxo
X-Received: by 10.112.200.228 with SMTP id jv4mr869036lbc.44.1376565502416;
        Thu, 15 Aug 2013 04:18:22 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-94-3.pppoe.mtu-net.ru. [91.76.94.3])
        by mx.google.com with ESMTPSA id u18sm201823lbp.4.2013.08.15.04.18.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 04:18:21 -0700 (PDT)
Message-ID: <520CB905.1000700@cogentembedded.com>
Date:   Thu, 15 Aug 2013 15:18:29 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: netlogic: xlr: Serial support depends on CONFIG_SERIAL_8250
References: <1376555267-1633-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1376555267-1633-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37559
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

On 15-08-2013 12:27, Markos Chandras wrote:

> The nlm_early_serial_setup code needs the early_serial_setup symbol
> which is only available if CONFIG_SERIAL_8250 is selected.
> Fixes the following build problem:

> arch/mips/built-in.o: In function `nlm_early_serial_setup':
> setup.c:(.init.text+0x274): undefined reference to `early_serial_setup'
> make: *** [vmlinux] Error 1

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> This patch is for the upstream-sfr/mips-for-linux-next tree
> ---
>   arch/mips/netlogic/xlr/setup.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
> index 214d123..60769f7 100644
> --- a/arch/mips/netlogic/xlr/setup.c
> +++ b/arch/mips/netlogic/xlr/setup.c
> @@ -60,6 +60,7 @@ unsigned int  nlm_threads_per_core = 1;
>   struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
>   cpumask_t nlm_cpumask = CPU_MASK_CPU0;
>
> +#ifdef CONFIG_SERIAL_8250
>   static void __init nlm_early_serial_setup(void)
>   {
>   	struct uart_port s;
> @@ -78,6 +79,7 @@ static void __init nlm_early_serial_setup(void)
>   	s.membase	= (unsigned char __iomem *)uart_base;
>   	early_serial_setup(&s);
>   }

    It's better to follow what Documentation/Submitting patches suggest and add:

#else
static inline void nlm_early_serial_setup(void) {}
> +#endif
>
>   static void nlm_linux_exit(void)
>   {
> @@ -214,8 +216,9 @@ void __init prom_init(void)
>   	memset(reset_vec, 0, RESET_VEC_SIZE);
>   	memcpy(reset_vec, (void *)nlm_reset_entry,
>   			(nlm_reset_entry_end - nlm_reset_entry));
> -
> +#ifdef CONFIG_SERIAL_8250
>   	nlm_early_serial_setup();
> +#endif

    ... and avoid #ifdef here.

WBR, Sergei
