Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Nov 2004 18:05:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45806 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224930AbUKASE4>; Mon, 1 Nov 2004 18:04:56 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iA1I4sdh011842
	for <linux-mips@linux-mips.org>; Mon, 1 Nov 2004 10:04:54 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iA1I4r7b011840
	for linux-mips@linux-mips.org; Mon, 1 Nov 2004 10:04:53 -0800
Date: Mon, 1 Nov 2004 10:04:53 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Subject: [PATCH]MTD Support for Malta in 2.6.10
Message-ID: <20041101180453.GB10943@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello !

Attached patch gets MTD to work on the Malta board in 2.6.10. Please review ...

Thanks
Manish Lachwani


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-mtd-malta

--- arch/mips/mips-boards/malta/malta_setup.c.orig	2004-10-29 18:42:24.000000000 -0700
+++ arch/mips/mips-boards/malta/malta_setup.c	2004-10-29 19:19:01.000000000 -0700
@@ -25,6 +25,8 @@
 #ifdef CONFIG_MTD
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
 #endif
 
 #include <asm/cpu.h>

--O5XBE6gyVG5Rl6Rj--
