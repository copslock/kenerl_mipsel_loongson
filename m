Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2006 12:12:22 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:56423 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20027614AbWJ3MMS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Oct 2006 12:12:18 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 79BEB3ECA; Mon, 30 Oct 2006 04:11:57 -0800 (PST)
Message-ID: <4545EC09.9000907@ru.mvista.com>
Date:	Mon, 30 Oct 2006 15:11:53 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove an unused variable about Au1000
References: <20061029233740.21a93cbb.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061029233740.21a93cbb.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Yoichi Yuasa wrote:

> This patch has removed an unused variable about Au1000.

> arch/mips/au1000/common/time.c: In function `mips_timer_interrupt':
> arch/mips/au1000/common/time.c:82: warning: unused variable `count'

> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/time.c mips/arch/mips/au1000/common/time.c
> --- mips-orig/arch/mips/au1000/common/time.c	2006-10-24 11:07:06.417642500 +0900
> +++ mips/arch/mips/au1000/common/time.c	2006-10-24 11:51:54.583538000 +0900
> @@ -79,7 +79,6 @@ unsigned long wtimer;
>  void mips_timer_interrupt(void)
>  {
>  	int irq = 63;
> -	unsigned long count;
>  
>  	irq_enter();
>  	kstat_this_cpu.irqs[irq]++;

    Note that this whole handler should be removed. :-D

WBR, Sergei
