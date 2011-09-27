Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2011 10:30:10 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1551 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491809Ab1I0I3P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2011 10:29:15 +0200
X-TM-IMSS-Message-ID: <32632a760000108e@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 32632a760000108e ; Tue, 27 Sep 2011 01:29:08 -0700
Received: from orion8.netlogicmicro.com (10.10.16.60) by
 hqcas01.netlogicmicro.com (10.10.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 27 Sep 2011 01:29:08 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by
 orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);         Tue, 27 Sep
 2011 01:29:07 -0700
Date:   Tue, 27 Sep 2011 14:07:58 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 3/9] MIPS: Netlogic: No need to set -Werror in mips/xlr
Message-ID: <7dc67587834c333530e17d110ae504e5a195aaf9.1317111127.git.jayachandranc@netlogicmicro.com>
References: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 27 Sep 2011 08:29:07.0669 (UTC) FILETIME=[8627E050:01CC7CEF]
X-archive-position: 31174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15274

The -Werror compilation flag is already set for arch/mips - it can be removed
from arch/mips/xlr/Makefile

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/xlr/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
index 2dca585..29f1fd5 100644
--- a/arch/mips/netlogic/xlr/Makefile
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -1,5 +1,3 @@
 obj-y				+= setup.o platform.o irq.o setup.o time.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= xlr_console.o
-
-ccflags-y			+= -Werror
-- 
1.7.4.1
