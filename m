Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2004 10:50:36 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:62452 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225482AbUCBKuf>;
	Tue, 2 Mar 2004 10:50:35 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id TAA13946;
	Tue, 2 Mar 2004 19:50:30 +0900 (JST)
Received: 4UMDO00 id i22AoUd00637; Tue, 2 Mar 2004 19:50:30 +0900 (JST)
Received: 4UMRO01 id i22AoSe28889; Tue, 2 Mar 2004 19:50:29 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 2 Mar 2004 19:50:28 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Fixed ISA configuration
Message-Id: <20040302195028.3addcdf7.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch solves the problem which cannot choose ISA support about CASIO E55, IBM WorkPad, and others.
Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2004-02-26 10:39:17.000000000 +0900
+++ linux/arch/mips/Kconfig	2004-03-02 11:35:24.000000000 +0900
@@ -1317,8 +1317,7 @@
 
 config ISA
 	bool "ISA bus support"
-	depends on ACER_PICA_61 || SGI_IP22 || MIPS_MAGNUM_4000 || OLIVETTI_M700 || SNI_RM200_PCI
-	default y if TOSHIBA_RBTX4927 || DDB5476 || DDB5074 || IBM_WORKPAD || CASIO_E55
+	depends on ACER_PICA_61 || SGI_IP22 || MIPS_MAGNUM_4000 || OLIVETTI_M700 || SNI_RM200_PCI || TOSHIBA_RBTX4927 || DDB5476 || DDB5074 || IBM_WORKPAD || CASIO_E55
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
