Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:55:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:59093 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022613AbXGLQzT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 17:55:19 +0100
Received: from localhost (p7217-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4947FA24C; Fri, 13 Jul 2007 01:55:16 +0900 (JST)
Date:	Fri, 13 Jul 2007 01:56:11 +0900 (JST)
Message-Id: <20070713.015611.15246984.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	rpjday@mindspring.com
Subject: Re: dead(?) MIPS config stuff
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <468D163B.9070907@ru.mvista.com>
References: <20070705144641.GA20210@linux-mips.org>
	<468D163B.9070907@ru.mvista.com>
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
X-archive-position: 15744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 05 Jul 2007 20:03:07 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > ========== TX4927BUG_WORKAROUND ==========
> > arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:141:#define CONFIG_TX4927BUG_WORKAROUND
> > arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:672:#ifdef CONFIG_TX4927BUG_WORKAROUND
> > arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:914:#ifdef CONFIG_TX4927BUG_WORKAROUND
> 
>     This one shouldn't have been called CONFIG_* and might be just killed as 
> well....

That was workarounds for very early chip.  I believe we can kill them all.

---
Atsushi Nemoto
