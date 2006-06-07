Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 15:58:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35815 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8134013AbWFGO5x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 15:57:53 +0100
Received: from localhost (p3137-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.137])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 33060A6A9; Wed,  7 Jun 2006 23:57:48 +0900 (JST)
Date:	Wed, 07 Jun 2006 23:58:45 +0900 (JST)
Message-Id: <20060607.235845.128616718.anemo@mba.ocn.ne.jp>
To:	eckhardt@satorlaser.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix some compiler warnings (field width, unused
 variable)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200606071103.34646.eckhardt@satorlaser.com>
References: <Pine.LNX.4.62.0605311840170.18323@chinchilla.sonytel.be>
	<20060602.015404.93020143.anemo@mba.ocn.ne.jp>
	<200606071103.34646.eckhardt@satorlaser.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 7 Jun 2006 11:03:34 +0200, Ulrich Eckhardt <eckhardt@satorlaser.com> wrote:
> I'm not so sure if this is a good idea because some systems have 36
> bit physical addresses while they only have 32 bit void pointers, so
> long long is probably really the better solution.

In general, it would be better to use "long long" for 32bit physical
address.  For this particular code, both values are "unsigned long" so
casting to "void *" for printing should be safe anyway.

> I'm wondering if it would be worth having a special flag in printk
> to indicate a physical address ("%lp" perhaps?) so that you don't
> get the unimportant leading zeroes for the bits 36 to 63 for above
> mentioned platforms.

It might raise some new gcc/sparse warnings about format strings :-)

---
Atsushi Nemoto
