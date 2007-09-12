Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 16:32:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:34284 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022977AbXILPbv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 16:31:51 +0100
Received: from localhost (p8044-ipad303funabasi.chiba.ocn.ne.jp [123.217.154.44])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E2DF5C2E2; Thu, 13 Sep 2007 00:31:47 +0900 (JST)
Date:	Thu, 13 Sep 2007 00:33:19 +0900 (JST)
Message-Id: <20070913.003319.41011558.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] move i8259 functions to include/asm-mips/i8259.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp>
References: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 16475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 12 Sep 2007 23:23:33 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> --- mips-orig/arch/mips/kernel/i8259.c	2007-09-12 14:37:15.447287000 +0900
> +++ mips/arch/mips/kernel/i8259.c	2007-09-12 14:26:42.007699500 +0900
> @@ -31,7 +31,10 @@
>  static int i8259A_auto_eoi = -1;
>  DEFINE_SPINLOCK(i8259A_lock);
>  /* some platforms call this... */
> -void mask_and_ack_8259A(unsigned int);
> +static void disable_8259A_irq(unsigned int irq);
> +static void enable_8259A_irq(unsigned int irq);
> +static void mask_and_ack_8259A(unsigned int irq);
> +static void init_8259A(int auto_eoi);
>  
>  static struct irq_chip i8259A_chip = {
>  	.name		= "XT-PIC",

Please drop a comment in this part too.  The comment was there just
because we had to drop "static" from mask_and_ack_8259A() at that
time.

---
Atsushi Nemoto
