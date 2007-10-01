Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 04:57:40 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:4795 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20021445AbXJAD5b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 04:57:31 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id B8145309B4B;
	Mon,  1 Oct 2007 03:56:54 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon,  1 Oct 2007 03:56:54 +0000 (UTC)
Received: from [192.168.7.224] ([192.168.7.224]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 20:56:52 -0700
Message-ID: <47007003.2050905@avtrex.com>
Date:	Sun, 30 Sep 2007 20:56:51 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
References: <46FF7BC2.5050905@ict.ac.cn> <20071001025340.GA7091@linux-mips.org>
In-Reply-To: <20071001025340.GA7091@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2007 03:56:52.0577 (UTC) FILETIME=[19D0E510:01C803DF]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> +	} else if (cpu_has_llsc) {					\
> +		__asm__ __volatile__(					\
> +		"	.set	push				\n"	\
> +		"	.set	noat				\n"	\
> +		"	.set	mips3				\n"	\
> +		"1:	" ld "	%0, %2		# __cmpxchg_u32	\n"	\
> +		"	bne	%0, %z3, 2f			\n"	\
> +		"	.set	mips0				\n"	\
> +		"	move	$1, %z4				\n"	\
> +		"	.set	mips3				\n"	\
> +		"	" st "	$1, %1				\n"	\
> +		"	beqz	$1, 3f				\n"	\
> +		"2:						\n"	\
> +		"	.subsection 2				\n"	\
> +		"3:	b	1b				\n"	\
> +		"	.previous				\n"	\
> +		"	.set	pop				\n"	\
> +		: "=&r" (__ret), "=R" (*m)				\
> +		: "R" (*m), "Jr" (old), "Jr" (new)			\
> +		: "memory");						\
>   
Is a 'sync' needed after the 'sc'?

According to this message:
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20070919084515.GM9972%40networkno.de
it would seem so.


David Daney
