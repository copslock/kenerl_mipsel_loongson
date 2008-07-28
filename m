Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 19:45:17 +0100 (BST)
Received: from defer106.ocn.ad.jp ([125.206.148.14]:47080 "EHLO
	defer106.ocn.ad.jp") by ftp.linux-mips.org with ESMTP
	id S28584163AbYG1SpM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jul 2008 19:45:12 +0100
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by defer106.ocn.ad.jp (Postfix) with ESMTP id 2663E8005E;
	Tue, 29 Jul 2008 01:26:10 +0900 (JST)
Received: from localhost (p3065-ipad303funabasi.chiba.ocn.ne.jp [123.217.149.65])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 037F0A9D0; Tue, 29 Jul 2008 01:24:52 +0900 (JST)
Date:	Tue, 29 Jul 2008 01:26:49 +0900 (JST)
Message-Id: <20080729.012649.63997796.anemo@mba.ocn.ne.jp>
To:	david.r.pelton@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] change EARLY_PRINTK default to n
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4856BBDB.6000306@gmail.com>
References: <4856BBDB.6000306@gmail.com>
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
X-archive-position: 19996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 16 Jun 2008 15:15:39 -0400, David Pelton <david.r.pelton@gmail.com> wrote:
> This patch changes the default for CONFIG_EARLY_PRINTK to n.  Prior to
> this change, the presence of SYS_HAS_EARLY_PRINTK would always set
> EARLY_PRINTK to y if either EMBEDDED or DEBUG_KERNEL were not set.  As
> this is a debugging option, it should default to n.
> 
> Signed-off-by: David Pelton <david.r.pelton@gmail.com>

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Ralf, any problem with this patch?

---
Atsushi Nemoto
