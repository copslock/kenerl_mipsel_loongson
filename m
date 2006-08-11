Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 15:49:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:28360 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20044738AbWHKOtY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 15:49:24 +0100
Received: from localhost (p5235-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.235])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6551E8460; Fri, 11 Aug 2006 23:49:17 +0900 (JST)
Date:	Fri, 11 Aug 2006 23:50:56 +0900 (JST)
Message-Id: <20060811.235056.126141886.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 2/6] setup.c: move initrd code inside dedicated
 functions
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1155135159394-git-send-email-vagabon.xyz@gmail.com>
References: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
	<1155135159394-git-send-email-vagabon.xyz@gmail.com>
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
X-archive-position: 12282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed,  9 Aug 2006 16:52:34 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> +	unsigned long initrd_size = 
> +		(unsigned long)initrd_end - (unsigned long)initrd_start;

While initrd_end and initrd_start are unsigned long, these casts are
redundant.

> +	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
> +	       (void *)initrd_start, initrd_size);

You can use "0x%lx" for initrd_start and remove the cast.  I know this
fragment are copied from corrent code as is, but it would be a good
chance to clean it up.

---
Atsushi Nemoto
