Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2008 17:36:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:59339 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28584771AbYG3Qgf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2008 17:36:35 +0100
Received: from localhost (p6235-ipad212funabasi.chiba.ocn.ne.jp [58.91.170.235])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5DA96A7AD; Thu, 31 Jul 2008 01:36:29 +0900 (JST)
Date:	Thu, 31 Jul 2008 01:38:28 +0900 (JST)
Message-Id: <20080731.013828.61509567.anemo@mba.ocn.ne.jp>
To:	david.r.pelton@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] change EARLY_PRINTK default to n
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080729.012649.63997796.anemo@mba.ocn.ne.jp>
References: <4856BBDB.6000306@gmail.com>
	<20080729.012649.63997796.anemo@mba.ocn.ne.jp>
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
X-archive-position: 20054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 29 Jul 2008 01:26:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > This patch changes the default for CONFIG_EARLY_PRINTK to n.  Prior to
> > this change, the presence of SYS_HAS_EARLY_PRINTK would always set
> > EARLY_PRINTK to y if either EMBEDDED or DEBUG_KERNEL were not set.  As
> > this is a debugging option, it should default to n.
> > 
> > Signed-off-by: David Pelton <david.r.pelton@gmail.com>
> 
> Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> Ralf, any problem with this patch?

Oops, the patch cannot be applied due to tab/space issue.
But it can be fixed easily :)

---
Atsushi Nemoto
