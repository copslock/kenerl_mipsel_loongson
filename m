Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 17:10:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:33527 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28644529AbYIRQKa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 17:10:30 +0100
Received: from localhost (p7111-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.111])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 56192AFFF; Fri, 19 Sep 2008 01:10:23 +0900 (JST)
Date:	Fri, 19 Sep 2008 01:10:41 +0900 (JST)
Message-Id: <20080919.011041.128619273.anemo@mba.ocn.ne.jp>
To:	jeff@garzik.org
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48D17D95.6050008@garzik.org>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
	<48D17D95.6050008@garzik.org>
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
X-archive-position: 20532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 17 Sep 2008 17:58:45 -0400, Jeff Garzik <jeff@garzik.org> wrote:
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> I hope a libata driver is coming, too?

Yes, but it is just a plan.  No code for now.

---
Atsushi Nemoto
