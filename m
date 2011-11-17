Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 12:49:07 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:35346 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904023Ab1KQLtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 12:49:00 +0100
Received: by bkat2 with SMTP id t2so2377767bka.36
        for <multiple recipients>; Thu, 17 Nov 2011 03:48:54 -0800 (PST)
Received: by 10.204.143.140 with SMTP id v12mr33812742bku.15.1321530533848;
        Thu, 17 Nov 2011 03:48:53 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-177-81.pppoe.mtu-net.ru. [85.141.177.81])
        by mx.google.com with ESMTPS id e8sm41060128bkd.7.2011.11.17.03.48.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 03:48:52 -0800 (PST)
Message-ID: <4EC4F470.4090605@mvista.com>
Date:   Thu, 17 Nov 2011 15:48:00 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/3] MIPS: Alchemy: db1200: improve PB1200 detection.
References: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14388

Hello.

On 16-11-2011 19:42, Manuel Lauss wrote:

> The PB1200 has the CPLD located at an address which on the DB1200 is
> RAM;  reading the Board-ID sometimes results in a PB1200 being detected
> instead (especially during reboots after long uptimes).
> On the other hand, the address of the DB1200's CPLD is hosting Flash
> chips on the PB1200.  Test for the DB1200 first and additionally do a
> quick write-test to the hexleds register to make sure we're writing
> to the CPLD.

> Signed-off-by: Manuel Lauss<manuel.lauss@googlemail.com>
> ---
> Applies on top of the other patches queued for 3.3

>   arch/mips/alchemy/devboards/db1200.c |   30 ++++++++++++++++++++++--------
>   1 files changed, 22 insertions(+), 8 deletions(-)

> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index 1181241..6721991 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -66,19 +66,33 @@ static int __init detect_board(void)
>   {
>   	int bid;
>
> -	/* try the PB1200 first */
> +	/* try the DB1200 first */
> +	bcsr_init(DB1200_BCSR_PHYS_ADDR,
> +		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
> +	if (BCSR_WHOAMI_DB1200 == BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
> +		unsigned short t = bcsr_read(BCSR_HEXLEDS);
> +		bcsr_write(BCSR_HEXLEDS, ~t);
> +		if (bcsr_read(BCSR_HEXLEDS) != t) {
> +			bcsr_write(BCSR_HEXLEDS, t);
> +			return 0;
> +		}
> +	}
> +
> +	/* okay, try the PB1200 then */
>   	bcsr_init(PB1200_BCSR_PHYS_ADDR,
>   		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
>   	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
>   	if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
> -	    (bid == BCSR_WHOAMI_PB1200_DDR2))
> -		return 0;
> +	    (bid == BCSR_WHOAMI_PB1200_DDR2)) {
> +		unsigned short t = bcsr_read(BCSR_HEXLEDS);
> +		bcsr_write(BCSR_HEXLEDS, ~t);
> +		if (bcsr_read(BCSR_HEXLEDS) != t) {
> +			bcsr_write(BCSR_HEXLEDS, t);
> +			return 0;
> +		}

    Isn't it worth putting the repetitive code into a subroutine?

WBR, Sergei
