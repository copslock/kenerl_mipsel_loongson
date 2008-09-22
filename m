Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2008 15:55:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:23528 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20130388AbYIVOzv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Sep 2008 15:55:51 +0100
Received: from localhost (p7139-ipad310funabasi.chiba.ocn.ne.jp [123.217.209.139])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A1649A9A8; Mon, 22 Sep 2008 23:55:44 +0900 (JST)
Date:	Mon, 22 Sep 2008 23:56:08 +0900 (JST)
Message-Id: <20080922.235608.106262139.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48D51B48.2090400@ru.mvista.com>
References: <20080918.001358.08318211.anemo@mba.ocn.ne.jp>
	<48D51B48.2090400@ru.mvista.com>
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
X-archive-position: 20587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 20 Sep 2008 19:48:24 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Add a helper routine to register tx4939ide driver and use it on
> > RBTX4939 board.
> 
>   BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?

Yes, next plan.  It should be much simpler than the tx4939ide driver.

---
Atsushi Nemoto
