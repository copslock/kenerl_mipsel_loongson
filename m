Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 00:32:46 +0000 (GMT)
Received: from mx01.hansenet.de ([213.191.73.25]:34745 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S28577067AbXLRAcH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Dec 2007 00:32:07 +0000
Received: from [213.39.184.147] (213.39.184.147) by webmail.hansenet.de (7.3.118.12) (authenticated as mbx20228207@koeller-hh.org)
        id 4761398E00AECD12; Tue, 18 Dec 2007 01:31:47 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 9FAE247C0D;
	Tue, 18 Dec 2007 01:31:40 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Date:	Tue, 18 Dec 2007 01:26:37 +0100
Subject: [PATCH 2/4] [MIPS] Fix interrupt enable/disable hazards for RM9000
X-Length: 805
X-UID:	19
MIME-Version: 1.0
Content-Disposition: inline
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Content-Transfer-Encoding: 7bit
Message-Id: <20071218003140.9FAE247C0D@mail.koeller.dyndns.org>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

The no-op hazards present before this caused
c0_compare_int_usable() in arch/mips/kernel/cevt-r4k.c
to fail.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

diff --git a/include/asm-mips/hazards.h b/include/asm-mips/hazards.h
index 2de638f..6454d66 100644
--- a/include/asm-mips/hazards.h
+++ b/include/asm-mips/hazards.h
@@ -176,8 +176,10 @@ ASMMACRO(tlb_probe_hazard,
 	 _ssnop; _ssnop; _ssnop; _ssnop
 	)
 ASMMACRO(irq_enable_hazard,
+	 _ssnop; _ssnop; _ssnop; _ssnop
 	)
 ASMMACRO(irq_disable_hazard,
+	 _ssnop; _ssnop; _ssnop; _ssnop
 	)
 ASMMACRO(back_to_back_c0_hazard,
 	)
-- 
1.5.3.6
