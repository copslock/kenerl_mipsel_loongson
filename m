Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 15:11:13 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:11468 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021878AbXCSPLI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 15:11:08 +0000
Received: from localhost (p3228-ipad01funabasi.chiba.ocn.ne.jp [61.207.77.228])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 20801A88F
	for <linux-mips@linux-mips.org>; Tue, 20 Mar 2007 00:09:48 +0900 (JST)
Date:	Tue, 20 Mar 2007 00:09:47 +0900 (JST)
Message-Id: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: ZONE_DMA on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Some ZONE_DMA patches were merged in 2.6.21.  On most MIPS, ZONE_DMA
is not needed, isn't it?

Currently JAZZ, MALTA, QEMU, IP22, SNI_RM, RBTX4938 defines
GENERIC_ISA_DMA so they may need ZONE_DMA (though I wonder QEMU or
RBTX4938 really need it...)

Are there any other platforms requires special DMA zone?

---
Atsushi Nemoto
