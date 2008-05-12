Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 15:23:20 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:59859 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030079AbYELOXQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 15:23:16 +0100
Received: from localhost (p3253-ipad304funabasi.chiba.ocn.ne.jp [123.217.157.253])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AC834B05C; Mon, 12 May 2008 23:23:09 +0900 (JST)
Date:	Mon, 12 May 2008 23:24:21 +0900 (JST)
Message-Id: <20080512.232421.108306312.anemo@mba.ocn.ne.jp>
To:	tsbogend@alpha.franken.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix check for valid stack pointer during backtrace
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080512125923.0C641DE534@solo.franken.de>
References: <20080512125923.0C641DE534@solo.franken.de>
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
X-archive-position: 19213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 12 May 2008 14:59:23 +0200 (CEST), Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> The newly added check for valid stack pointer address breaks at least for
> 64bit kernels.  Use __get_user() for accessing stack content to avoid crashes,
> when doing the backtrace.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---

Thank you for updating.

> -	unsigned long *sp = (unsigned long *)(reg29 & ~3);
> +	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);

Please drop this change, while kstack_end expect non __user pointer.

---
Atsushi Nemoto
