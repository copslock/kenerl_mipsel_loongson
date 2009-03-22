Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Mar 2009 22:14:01 +0000 (GMT)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:47510 "EHLO
	gw01.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S21370133AbZCVWMr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Mar 2009 22:12:47 +0000
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 89486151410;
	Mon, 23 Mar 2009 00:12:44 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 3/3] [MIPS] Make a needlessly global symbol static in arch/mips/kernel/smp.c
Date:	Mon, 23 Mar 2009 00:12:29 +0200
Message-Id: <1237759949-8223-4-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1237759949-8223-3-git-send-email-dmitri.vorobiev@movial.com>
References: <1237759949-8223-1-git-send-email-dmitri.vorobiev@movial.com>
 <1237759949-8223-2-git-send-email-dmitri.vorobiev@movial.com>
 <1237759949-8223-3-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The variable cpu_callin_map is needlessly defined global, so let's
make it static now.

Build-tested using malta_defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 3da9470..c937506 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -44,7 +44,7 @@
 #include <asm/mipsmtregs.h>
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-volatile cpumask_t cpu_callin_map;	/* Bitmask of started secondaries */
+static volatile cpumask_t cpu_callin_map;	/* Bitmask of started secondaries */
 int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
 int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
 
-- 
1.5.6.3
