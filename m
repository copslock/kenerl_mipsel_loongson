Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2009 15:29:36 +0200 (CEST)
Received: from hera.kernel.org ([140.211.167.34]:51977 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492719AbZIVN3a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Sep 2009 15:29:30 +0200
Received: from [192.168.1.220] (triband-del-59.180.23.123.bol.net.in [59.180.23.123] (may be forged))
	(authenticated bits=0)
	by hera.kernel.org (8.14.2/8.13.8) with ESMTP id n8MDTLQU017190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 22 Sep 2009 13:29:26 GMT
Subject: [PATCH] MIPS: includecheck fix: smp.c
From:	Jaswinder Singh Rajput <jaswinder@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date:	Tue, 22 Sep 2009 18:59:27 +0530
Message-Id: <1253626167.3784.15.camel@ht.satnam>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-2.fc10) 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.93.3/9821/Mon Sep 21 23:48:15 2009 on hera.kernel.org
X-Virus-Status:	Clean
Return-Path: <jaswinder@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaswinder@kernel.org
Precedence: bulk
X-list: linux-mips


fix the following 'make includecheck' warning:

  arch/mips/kernel/smp.c: linux/smp.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/mips/kernel/smp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 64668a9..119a95e 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -32,7 +32,6 @@
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
-#include <linux/smp.h>
 
 #include <asm/atomic.h>
 #include <asm/cpu.h>
-- 
1.6.0.6
