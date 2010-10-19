Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 03:06:00 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15332 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491869Ab0JSBF5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Oct 2010 03:05:57 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cbcef170000>; Mon, 18 Oct 2010 18:06:31 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Oct 2010 18:06:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Oct 2010 18:06:15 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9J15pj2029445;
        Mon, 18 Oct 2010 18:05:51 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9J15oQw029444;
        Mon, 18 Oct 2010 18:05:50 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: jz4740: Cleanup Kbuild Platform file.
Date:   Mon, 18 Oct 2010 18:05:49 -0700
Message-Id: <1287450349-29412-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 19 Oct 2010 01:06:15.0217 (UTC) FILETIME=[D40D3A10:01CB6F29]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The platform specific files should be included via the platform-y
variable.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---

I didn't test this, but it looks correct.  I found it while poking at
things to get 'make clean' working.

 arch/mips/jz4740/Platform |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/jz4740/Platform b/arch/mips/jz4740/Platform
index 6a97230..ba91be9 100644
--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,3 +1,3 @@
-core-$(CONFIG_MACH_JZ4740)	+= arch/mips/jz4740/
+platform-$(CONFIG_MACH_JZ4740)	+= jz4740/
 cflags-$(CONFIG_MACH_JZ4740)	+= -I$(srctree)/arch/mips/include/asm/mach-jz4740
 load-$(CONFIG_MACH_JZ4740)	+= 0xffffffff80010000
-- 
1.7.2.3
