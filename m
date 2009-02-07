Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Feb 2009 14:57:43 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:30384 "EHLO orbit.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21366278AbZBGO5j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Feb 2009 14:57:39 +0000
Received: from orbit.nwl.cc (localhost [127.0.0.1])
	by orbit.nwl.cc (Postfix) with ESMTP id E38904CEB7;
	Sat,  7 Feb 2009 15:57:33 +0100 (CET)
Received: from base (localhost [127.0.0.1])
	by orbit.nwl.cc (Postfix) with ESMTP id ABA9E4CE8B;
	Sat,  7 Feb 2009 15:57:33 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: rb532: use mdelay to sleep when atomic
Date:	Sat,  7 Feb 2009 15:57:26 +0100
X-Mailer: git-send-email 1.5.6.4
Message-Id: <20090207145733.ABA9E4CE8B@orbit.nwl.cc>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

In fact, using msleep() here triggers scheduling when the kernel has
been built with CONFIG_PREEMPT, which in turn causes the kernel to
complain about scheduling when being atomic.

The delay itself is basically a hack to allow the rb564 daughter board
(FIXME: right?) to be detected correctly. Maybe there is some real fix
for this issue, but sadly I can't test as I don't have any hardware
requiring this delay.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/pci/ops-rc32434.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/ops-rc32434.c b/arch/mips/pci/ops-rc32434.c
index d1f8fa2..0999e91 100644
--- a/arch/mips/pci/ops-rc32434.c
+++ b/arch/mips/pci/ops-rc32434.c
@@ -118,7 +118,7 @@ retry:
 			if (delay > 4)
 				return 0;
 			delay *= 2;
-			msleep(delay);
+			mdelay(delay);
 			goto retry;
 		}
 	}
-- 
1.5.6.4
