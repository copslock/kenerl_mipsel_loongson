Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:36:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:16356 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021978AbXHBOgY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 15:36:24 +0100
Received: from localhost (p2209-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B0751B658; Thu,  2 Aug 2007 23:35:03 +0900 (JST)
Date:	Thu, 02 Aug 2007 23:36:11 +0900 (JST)
Message-Id: <20070802.233611.130239626.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/5] Drop unneeded config options for RBTX4938
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
X-archive-position: 16036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4b02d8a..e7d542d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -558,9 +558,7 @@ config TOSHIBA_RBTX4927
 
 config TOSHIBA_RBTX4938
 	bool "Toshiba RBTX4938 board"
-	select HAVE_STD_PC_SERIAL_PORT
 	select DMA_NONCOHERENT
-	select GENERIC_ISA_DMA
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
 	select IRQ_CPU
