Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Apr 2006 21:41:51 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:17065 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133543AbWDOUld (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Apr 2006 21:41:33 +0100
Received: (qmail 5600 invoked from network); 16 Apr 2006 00:56:13 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 16 Apr 2006 00:56:13 -0000
Message-ID: <44415D17.1070005@ru.mvista.com>
Date:	Sun, 16 Apr 2006 00:52:39 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Geoff Levand <geoffrey.levand@am.sony.com>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
References: <20060415.010518.126141918.anemo@mba.ocn.ne.jp> <444032A5.3030304@am.sony.com>
In-Reply-To: <444032A5.3030304@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Geoff Levand wrote:

>>On Fri, 14 Apr 2006 08:38:00 -0700, Geoff Levand
>><geoffrey.levand@am.sony.com> wrote:

>>>I seem to get a lot of problems with an nfs root fs
>>>on tx4937 board.  I haven't looked at it closely yet,
>>>but I guess its some problem with the ne2000 driver.
>>>I wanted to know if you know anything about this.

>>Please look at:

>>http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060226.23054
>>1.75185772.anemo%40mba.ocn.ne.jp

>>With a quick glance of ne.c, it seems ei_status.stop_page should be
>>changed to 0x60 on the board.  Please confirm its value.

> Yes, this seems to fix the problem.

> Index: 2.6.16.1/drivers/net/ne.c
> ===================================================================
> --- 2.6.16.1.orig/drivers/net/ne.c	2006-04-14 15:54:41.000000000 -0700
> +++ 2.6.16.1/drivers/net/ne.c	2006-04-14 16:27:51.000000000 -0700
> @@ -140,7 +140,8 @@
>  #define NE1SM_START_PG	0x20	/* First page of TX buffer */
>  #define NE1SM_STOP_PG 	0x40	/* Last page +1 of RX ring */
>  #define NESM_START_PG	0x40	/* First page of TX buffer */
> -#define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
> +#define NESM_8_STOP_PG	0x60	/* Last page +1 of RX ring, RTL8019 8 bit mode */
> +#define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
> 
>  #if defined(CONFIG_PLAT_MAPPI)
>  #  define DCR_VAL 0x4b
> @@ -516,6 +517,7 @@
>  	ei_status.tx_start_page = start_page;
>  	ei_status.stop_page = stop_page;
>  #if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
> +	ei_status.stop_page = NESM_8_STOP_PG;
>  	wordlength = 1;
>  #endif

    This is really strange place for that #ifdef -- 'wordlength' is determined 
much earlier in this function (and stop_page is set to 0x40 for 8-bit case), 
shouldn't #ifdef be moved instead?

WBR, Sergei
