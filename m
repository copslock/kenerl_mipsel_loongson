Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 03:55:38 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:2783 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S28582162AbYDWCzd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Apr 2008 03:55:33 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for [213.58.128.207] [213.58.128.207]) with ESMTP; Wed, 23 Apr 2008 11:55:31 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0A7BB478FF;
	Wed, 23 Apr 2008 11:55:29 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id EB0CB478F5;
	Wed, 23 Apr 2008 11:55:28 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m3N2tSAF006761;
	Wed, 23 Apr 2008 11:55:28 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 23 Apr 2008 11:55:28 +0900 (JST)
Message-Id: <20080423.115528.59033169.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] [MIPS] add DECstation DS1287 clockevent
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200804222353.m3MNr8m4025538@po-mbox303.hop.2iij.net>
References: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
	<200804222353.m3MNr8m4025538@po-mbox303.hop.2iij.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 23 Apr 2008 08:52:45 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> add DECstation DS1287 clockevent
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
...
> --- linux-orig/arch/mips/kernel/Makefile	2008-04-22 19:01:43.957134178 +0900
> +++ linux/arch/mips/kernel/Makefile	2008-04-22 18:03:05.427649422 +0900
> @@ -9,8 +9,9 @@ obj-y		+= cpu-probe.o branch.o entry.o g
>  		   time.o topology.o traps.o unaligned.o
>  
>  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
> -obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
> +obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
>  obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
> +obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
>  obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
>  obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
>  obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o

Why CONFIG_CEVT_R4K line was moved?  The order is important?

> --- linux-orig/arch/mips/kernel/cevt-ds1287.c	1970-01-01 09:00:00.000000000 +0900
> +++ linux/arch/mips/kernel/cevt-ds1287.c	2008-04-22 18:03:05.455637018 +0900
...
> +static void ds1287_set_mode(enum clock_event_mode mode,
> +			    struct clock_event_device *evt)
> +{
> +	unsigned long flags;
> +	u8 val;
> +
> +	spin_lock_irqsave(&rtc_lock, flags);

You do not have to use irqsave here, while set_mode is always called
with interrupts disabled.  And for rtc_lock ... I don't know if this
code could be used on SMP :-)

> --- linux-orig/include/asm-mips/dec/ds1287.h	1970-01-01 09:00:00.000000000 +0900
> +++ linux/include/asm-mips/dec/ds1287.h	2008-04-22 18:03:05.455637018 +0900
> @@ -0,0 +1,27 @@
...

I suppose CEVT_DS1287 is not DEC specific one.  If so,
include/asm-mips/ would be better place.

---
Atsushi Nemoto
