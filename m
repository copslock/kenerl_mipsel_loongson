Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2010 18:40:56 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:40216 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492912Ab0CXRkw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Mar 2010 18:40:52 +0100
Received: by bwz7 with SMTP id 7so2558049bwz.24
        for <linux-mips@linux-mips.org>; Wed, 24 Mar 2010 10:40:45 -0700 (PDT)
Received: by 10.204.38.71 with SMTP id a7mr75551bke.159.1269452444688;
        Wed, 24 Mar 2010 10:40:44 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id 24sm1852570bkr.6.2010.03.24.10.40.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 10:40:43 -0700 (PDT)
Message-ID: <4BAA4E81.8070405@mvista.com>
Date:   Wed, 24 Mar 2010 20:40:17 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [RFC PATCH 2/2] Alchemy: UART PM through serial framework.
References: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com> <1269450986-3714-3-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1269450986-3714-3-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Hook up the Alchemy on-chip uarts with the platform 8250 PM callback
> and enable/disable the uart blocks as needed.
>
> Tested on Au1200.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>  arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
>  arch/mips/alchemy/common/power.c    |   32 --------------------------------
>  2 files changed, 17 insertions(+), 32 deletions(-)
>
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index 2580e77..70f4abd 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -21,6 +21,22 @@
>  #include <asm/mach-au1x00/au1100_mmc.h>
>  #include <asm/mach-au1x00/au1xxx_eth.h>
>  
> +static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
> +			    unsigned int old_state)
> +{
> +	if (state == 0) {		/* power on */
> +		__raw_writel(0, port->membase + UART_MOD_CNTRL);
> +		wmb();
> +		__raw_writel(1, port->membase + UART_MOD_CNTRL);
> +		wmb();
> +		__raw_writel(3, port->membase + UART_MOD_CNTRL);
> +		wmb();
> +	} else if (state == 3) {	/* power off */
> +		__raw_writel(0, port->membase + UART_MOD_CNTRL);
> +		wmb();
> +	}
> +}

   A *switch* statement seems more fitting here...

WBR, Sergei
