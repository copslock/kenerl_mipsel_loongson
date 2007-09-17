Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 00:21:17 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:48073 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022033AbXIQXVH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 00:21:07 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 46F6A309E03;
	Mon, 17 Sep 2007 23:20:47 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon, 17 Sep 2007 23:20:47 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 17 Sep 2007 16:20:28 -0700
Message-ID: <46EF0BBC.3020302@avtrex.com>
Date:	Mon, 17 Sep 2007 16:20:28 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	"Gleb O. Raiko" <raiko@niisi.msk.ru>, Kumba <kumba@gentoo.org>
Subject: Re: O2 RM7000 Issues
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469C8600.7090208@niisi.msk.ru> <20070717122711.GA19977@linux-mips.org>
In-Reply-To: <20070717122711.GA19977@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2007 23:20:28.0947 (UTC) FILETIME=[55D50630:01C7F981]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index f599e79..7ee0cb0 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -75,6 +75,26 @@ static void r4k_wait_irqoff(void)
>  	local_irq_enable();
>  }
>  
> +/*
> + * The RM7000 variant has to handle erratum 38.  The workaround is to not
> + * have any pending stores when the WAIT instruction is executed.
> + */
> +static void rm7k_wait_irqoff(void)
> +{
> +	local_irq_disable();
> +	if (!need_resched())
> +		__asm__(
> +		"	.set	push		\n"
> +		"	.set	mips3		\n"
> +		"	.set	noat		\n"
> +		"	mfc0	$1, $12		\n"
> +		"	sync			\n"
> +		"	mtc0	$1, $12		\n"
> +		"	wait			\n"
> +		"	.set	pop		\n");
> +	local_irq_enable();
> +}
> +

Technically, Shouldn't that __asm__ be volatile?

David Daney
