Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2010 22:43:50 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:61845 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491985Ab0CYVnr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Mar 2010 22:43:47 +0100
Received: by bwz7 with SMTP id 7so3694273bwz.24
        for <linux-mips@linux-mips.org>; Thu, 25 Mar 2010 14:43:41 -0700 (PDT)
Received: by 10.204.13.68 with SMTP id b4mr285629bka.133.1269553417196;
        Thu, 25 Mar 2010 14:43:37 -0700 (PDT)
Received: from [192.168.2.2] (ppp85-140-112-235.pppoe.mtu-net.ru [85.140.112.235])
        by mx.google.com with ESMTPS id s17sm1195712bkd.22.2010.03.25.14.43.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 14:43:36 -0700 (PDT)
Message-ID: <4BABD8E9.8030008@ru.mvista.com>
Date:   Fri, 26 Mar 2010 00:43:05 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: fix up residual devboard poweroff/reboot
 code.
References: <1269542237-16617-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1269542237-16617-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
> Clean out stray unused board_reset() calls in pb1x boards,
> the pb1000 is different from the rest and gets private methods.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>   
[...]
> diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
> index b5311d8..9fa532c 100644
> --- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
> +++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
>   

[...]

> @@ -177,6 +187,10 @@ void __init board_setup(void)
>  		au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
>  		break;
>  	}
> +
> +	pm_power_off = board_power_off;
> +	 _machine_halt = board_power_off;
> +	 _machine_restart = board_reset;
>   

   Why there are spaces after tabs?

WBR, Sergei
