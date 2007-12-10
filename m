Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 12:04:06 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:54714 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20024304AbXLJMD5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Dec 2007 12:03:57 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 5F45B3ECD; Mon, 10 Dec 2007 04:03:24 -0800 (PST)
Message-ID: <475D2B21.7050206@ru.mvista.com>
Date:	Mon, 10 Dec 2007 15:03:45 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] set up Cobalt's mips_hpt_frequency
References: <20071209212204.5e50a697.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071209212204.5e50a697.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Yoichi Yuasa wrote:

> Set up Cobalt's mips_hpt_frequency.

> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/time.c mips/arch/mips/cobalt/time.c
> --- mips-orig/arch/mips/cobalt/time.c	2007-12-06 18:27:02.689043750 +0900
> +++ mips/arch/mips/cobalt/time.c	2007-12-09 17:13:37.916769000 +0900
> @@ -27,9 +27,28 @@
>  
>  void __init plat_time_init(void)
>  {
> +	u32 start, end;
> +	int i = HZ / 10;
> +
>  	setup_pit_timer();
>  
>  	gt641xx_set_base_clock(GT641XX_BASE_CLOCK);
>  
> -	mips_timer_state = gt641xx_timer0_state;
> +	/*
> +	 * MIPS counter frequency is measured between 100msec 

    s/between/during/

WBR, Sergei
