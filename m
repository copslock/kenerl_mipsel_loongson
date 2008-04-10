Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2008 17:24:33 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:38346 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S1784247AbYDJPY0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2008 17:24:26 +0200
Received: from localhost (p5205-ipad206funabasi.chiba.ocn.ne.jp [222.145.79.205])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D4CB27BE8; Fri, 11 Apr 2008 00:23:03 +0900 (JST)
Date:	Fri, 11 Apr 2008 00:23:55 +0900 (JST)
Message-Id: <20080411.002355.08076156.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: [PATCH 0/6] tc35815: driver update
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
X-archive-position: 18884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patchset is for tc35815 driver update, including many cleanups
and conversion to phylib.

* Statistics cleanup
* Use print_mac() helper
* Use netdev_priv()
* Use managed pci iomap helper
* Use generic PHY layer
* Whitespace cleanup

 drivers/net/Kconfig   |    2 +-
 drivers/net/tc35815.c | 1674 +++++++++++++++++--------------------------------
 2 files changed, 589 insertions(+), 1087 deletions(-)
