Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 00:33:44 +0000 (GMT)
Received: from mx02.hansenet.de ([213.191.73.26]:6598 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S28577075AbXLRAc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Dec 2007 00:32:27 +0000
Received: from [213.39.184.147] (213.39.184.147) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 4766ADD8000AB811; Tue, 18 Dec 2007 01:31:46 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id D487347C0F;
	Tue, 18 Dec 2007 01:31:40 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Tue, 18 Dec 2007 01:27:07 +0100
Subject: [PATCH 4/4] excite: Supply platform-specific compare and performance timer interrupts
X-Length: 1010
X-UID:	21
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20071218003140.D487347C0F@mail.koeller.dyndns.org>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

As the eXcite platform uses the alternate RM9000 compare interrupt, it
must supply a platform-specific irq value. The performance counter is
currently unused.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

diff --git a/arch/mips/basler/excite/excite_setup.c 
b/arch/mips/basler/excite/excite_setup.c
index 6dd8f0d..a91309f 100644
--- a/arch/mips/basler/excite/excite_setup.c
+++ b/arch/mips/basler/excite/excite_setup.c
@@ -85,6 +85,18 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = EXCITE_CPU_EXT_CLOCK * mult / div / 2;
 }
 
+unsigned int __init
+get_c0_compare_int(void)
+{
+	return 12;
+}
+
+unsigned int __init
+get_c0_perfcounter_int(void)
+{
+	return -1;
+}
+
 static int __init excite_init_console(void)
 {
 #if defined(CONFIG_SERIAL_8250)
-- 
1.5.3.6
