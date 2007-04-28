Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 18:12:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:33498 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021935AbXD1RMw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 18:12:52 +0100
Received: from localhost (p7147-ipad204funabasi.chiba.ocn.ne.jp [222.146.94.147])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5D8CCA9EC; Sun, 29 Apr 2007 02:12:49 +0900 (JST)
Date:	Sun, 29 Apr 2007 02:12:52 +0900 (JST)
Message-Id: <20070429.021252.75203789.anemo@mba.ocn.ne.jp>
To:	jeff@garzik.org
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] ne: Add platform_driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4633632E.5030607@garzik.org>
References: <20070425.015450.25909765.anemo@mba.ocn.ne.jp>
	<4633632E.5030607@garzik.org>
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
X-archive-position: 14942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 28 Apr 2007 11:07:26 -0400, Jeff Garzik <jeff@garzik.org> wrote:
> > * Add platform_driver interface to ne driver.
> >   (Existing legacy ports did not covered by this ne_driver for now)
> > * Make ioaddr 'unsigned long'.
> > * Move a printk down to show dev->name assigned in register_netdev.
> 
> Please split this patch into two patches: one patch does platform_driver 
> conversion, and the other patch is the other two items you describe above.

OK, I'll update and split the patch.  Thank you.

---
Atsushi Nemoto
