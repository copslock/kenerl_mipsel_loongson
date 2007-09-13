Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 03:29:55 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:32036 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20024296AbXIMC3r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 03:29:47 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 13 Sep 2007 11:29:45 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 37ED641CA4;
	Thu, 13 Sep 2007 11:29:19 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2C62F41C71;
	Thu, 13 Sep 2007 11:29:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l8D2THAF095278;
	Thu, 13 Sep 2007 11:29:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 13 Sep 2007 11:29:17 +0900 (JST)
Message-Id: <20070913.112917.76463355.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] move i8259 functions to include/asm-mips/i8259.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200709130204.l8D244XV029841@po-mbox300.hop.2iij.net>
References: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp>
	<20070913.003319.41011558.anemo@mba.ocn.ne.jp>
	<200709130204.l8D244XV029841@po-mbox300.hop.2iij.net>
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
X-archive-position: 16486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Sep 2007 11:04:04 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hw_irq.h mips/include/asm-mips/hw_irq.h
> --- mips-orig/include/asm-mips/hw_irq.h	2007-09-13 10:41:51.559222750 +0900
> +++ mips/include/asm-mips/hw_irq.h	2007-09-13 10:39:56.480030750 +0900
> @@ -8,15 +8,8 @@
>  #ifndef __ASM_HW_IRQ_H
>  #define __ASM_HW_IRQ_H
>  
> -#include <linux/profile.h>
>  #include <asm/atomic.h>

This breaks some build.  

linux/arch/mips/kernel/time.c:142: error: implicit declaration of function 'profile_tick'

Proper fix would be including profile.h from time.c, but this is
irrelevant to i8259, so should be a separate patch.

Other parts looks good to me.  Thanks.
---
Atsushi Nemoto
