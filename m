Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 18:26:41 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:37108 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225221AbTGUR0i>;
	Mon, 21 Jul 2003 18:26:38 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6LHQVQ17635;
	Mon, 21 Jul 2003 10:26:31 -0700
Date: Mon, 21 Jul 2003 10:26:31 -0700
From: Jun Sun <jsun@mvista.com>
To: =?iso-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@free.fr>
Cc: linux-mips <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: PATCH: time.c needs to export more funcs
Message-ID: <20030721102631.C17287@mvista.com>
References: <3F1AC15A.6050604@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F1AC15A.6050604@free.fr>; from vincent.stehle@free.fr on Sun, Jul 20, 2003 at 06:20:42PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Sun, Jul 20, 2003 at 06:20:42PM +0200, Vincent Stehlé wrote:
> 
> Hi,
> 
> time.c needs to export some more functions for modules such as mips_rtc.
> 
> Regards,
> 
> ---
> diff -urN -X dontdiff linux/arch/mips/kernel/time.c 
> linux-vs/arch/mips/kernel/time.c
> --- linux/arch/mips/kernel/time.c       2003-07-18 03:30:14.000000000 +0200
> +++ linux-vs/arch/mips/kernel/time.c    2003-07-18 03:41:19.000000000 +0200
> @@ -585,3 +585,6 @@
>   }
> 
>   EXPORT_SYMBOL(rtc_lock);
> +EXPORT_SYMBOL(to_tm);
> +EXPORT_SYMBOL(rtc_set_time);
> +EXPORT_SYMBOL(rtc_get_time);
> 

Thanks.  Just applied.

Jun
