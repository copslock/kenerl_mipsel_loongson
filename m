Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 07:09:30 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:54585 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8127229AbWFHGJW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2006 07:09:22 +0100
Received: by mo.po.2iij.net (mo31) id k5869IHL010202; Thu, 8 Jun 2006 15:09:18 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id k5869EjK091995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 Jun 2006 15:09:14 +0900 (JST)
Date:	Thu, 8 Jun 2006 15:09:14 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: added "select SYS_HAS_CPU_VR41XX" for MACH_VR41XX
Message-Id: <20060608150914.64e3eb57.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch has added "select SYS_HAS_CPU_VR41XX" for MACH_VR41XX.
It's required for MACH_VR41XX.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips-rc6/Documentation/dontdiff mips-rc6-orig/arch/mips/Kconfig mips-rc6/arch/mips/Kconfig
--- mips-rc6-orig/arch/mips/Kconfig	2006-06-08 11:07:40.265524750 +0900
+++ mips-rc6/arch/mips/Kconfig	2006-06-08 14:04:05.973933500 +0900
@@ -509,6 +509,7 @@ config DDB5477
 
 config MACH_VR41XX
 	bool "NEC VR41XX-based machines"
+	select SYS_HAS_CPU_VR41XX
 
 config PMC_YOSEMITE
 	bool "PMC-Sierra Yosemite eval board"
