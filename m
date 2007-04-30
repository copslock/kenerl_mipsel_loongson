Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2007 16:27:11 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:61902 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022514AbXD3P1K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2007 16:27:10 +0100
Received: from localhost (p4067-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.67])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 45592B538; Tue,  1 May 2007 00:27:06 +0900 (JST)
Date:	Tue, 01 May 2007 00:27:09 +0900 (JST)
Message-Id: <20070501.002709.130239966.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	netdev@vger.kernel.org, jeff@garzik.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: [PATCH 0/5] ne: MIPS: platform_driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 14948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Currently ne.c has some codes to support RBTX49XX boards but it is not
complete.  Instead of adding more hacks to fix it, this patchset add
an generic platform_driver interface to the driver and let RBTX49XX
use it.

[PATCH 1/5] ne: Add platform_driver
[PATCH 2/5] ne: Misc fixes for platform driver.
[PATCH 3/5] ne: Add NEEDS_PORTLIST to control ISA auto-probe
[PATCH 4/5] ne: MIPS: Use platform_driver for ne on RBTX49XX
[PATCH 5/5] MIPS: Drop unnecessary CONFIG_ISA from RBTX49XX

Changes from previous patchset:

* Split some misc fixes from platform_driver patch. (sugested by Jeff Garzik)
* Add NEEDS_PORTLIST to control ISA auto-probe. (sugested by Jeff Garzik)
* Less ifdef CONFIG_PM. (by Andrew Morton)
* Make rbtx4927_ne_init()'s res[] static __initdata. (by Andrew Morton)

---
Atsushi Nemoto
