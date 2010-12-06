Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 18:42:52 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8764 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492046Ab0LFRms (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 18:42:48 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cfd20c00001>; Mon, 06 Dec 2010 09:43:28 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Dec 2010 09:43:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 6 Dec 2010 09:43:52 -0800
Message-ID: <4CFD2095.9040404@caviumnetworks.com>
Date:   Mon, 06 Dec 2010 09:42:45 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce mips_late_time_init
References: <1291623812.31822.6.camel@paanoop1-desktop>
In-Reply-To: <1291623812.31822.6.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2010 17:43:52.0866 (UTC) FILETIME=[25D1A020:01CB956D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 12/06/2010 12:23 AM, Anoop P A wrote:
> This patch moves plat_time_init and clocksoure init funtion calls to
> late_time_init.
>

Why would you want to do this?

The current code works perfectly, so I see no reason to change it.

David Daney


> Signed-off-by: Anoop P A<anoop.pa@gmail.com>
> ---
> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index fb74974..dbd1ac5 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -117,10 +117,16 @@ static __init int cpu_has_mfc0_count_bug(void)
>   	return 0;
>   }
>
> -void __init time_init(void)
> +void __init mips_late_time_init(void)
>   {
>   	plat_time_init();
>
>   	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
>   		init_mips_clocksource();
>   }
> +
> +
> +void __init time_init(void)
> +{
> +	late_time_init = mips_late_time_init;
> +}
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
