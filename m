Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 16:00:36 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:32714 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226453AbVGKPAT>;
	Mon, 11 Jul 2005 16:00:19 +0100
Received: MO(mo00)id j6BF1B6W016168; Tue, 12 Jul 2005 00:01:11 +0900 (JST)
Received: MDO(mdo01) id j6BF1AlN022593; Tue, 12 Jul 2005 00:01:11 +0900 (JST)
Received: from stratos (h086.p498.iij4u.or.jp [210.149.242.86])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j6BF1ACk022334
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 12 Jul 2005 00:01:10 +0900 (JST)
Date:	Tue, 12 Jul 2005 00:01:08 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: remove obsolete config in
 arch/mips/vr41xx/Kconfig
Message-Id: <20050712000108.6f7781d7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed a obsolete config in arch/mips/vr41xx/Kconfig.
Please apply this patch.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/Kconfig a/arch/mips/vr41xx/Kconfig
--- a-orig/arch/mips/vr41xx/Kconfig	2005-03-19 06:53:56.000000000 +0900
+++ a/arch/mips/vr41xx/Kconfig	2005-07-11 23:50:58.561618112 +0900
@@ -94,12 +94,6 @@
 	tristate "Add General-purpose I/O unit support of NEC VR4100 series"
 	depends on MACH_VR41XX
 
-config VRC4171
-	tristate "Add NEC VRC4171 companion chip support"
-	depends on MACH_VR41XX && ISA
-	help
-	  The NEC VRC4171/4171A is a companion chip for NEC VR4111/VR4121.
-
 config VRC4173
 	tristate "Add NEC VRC4173 companion chip support"
 	depends on MACH_VR41XX && PCI_VR41XX
