Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 02:51:42 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15042 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491869Ab0JSAvf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Oct 2010 02:51:35 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cbcebb80000>; Mon, 18 Oct 2010 17:52:08 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Oct 2010 17:51:51 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Oct 2010 17:51:51 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9J0pSTI028399;
        Mon, 18 Oct 2010 17:51:28 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9J0pSic028398;
        Mon, 18 Oct 2010 17:51:28 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] MIPS: Repair Kbuild make clean breakage.
Date:   Mon, 18 Oct 2010 17:51:26 -0700
Message-Id: <1287449486-28366-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 19 Oct 2010 00:51:51.0679 (UTC) FILETIME=[D157C8F0:01CB6F27]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

When running make clean, Kbuild doesn't process the .config file, so
nothing generates a platform-y variable.  We can get it to descend into
the platform directories by setting $(obj-).

The dec Platform file was unconditionally setting platform-,
obliterating its previous contents and preventing some directories
from being cleaned.  This is change to an append operation '+=' to
allow cavium-octeon to be cleaned.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/Kbuild       |    4 ++++
 arch/mips/dec/Platform |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index e322d65..7dd65cf 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -7,6 +7,10 @@ subdir-ccflags-y := -Werror
 include arch/mips/Kbuild.platforms
 obj-y := $(platform-y)
 
+# make clean traverses $(obj-) without having included .config, so
+# everything ends up here
+obj- := $(platform-)
+
 # mips object files
 # The object files are linked as core-y files would be linked
 
diff --git a/arch/mips/dec/Platform b/arch/mips/dec/Platform
index 3adbcbd..cf55a6f 100644
--- a/arch/mips/dec/Platform
+++ b/arch/mips/dec/Platform
@@ -1,7 +1,7 @@
 #
 # DECstation family
 #
-platform-$(CONFIG_MACH_DECSTATION)	= dec/
+platform-$(CONFIG_MACH_DECSTATION)	+= dec/
 cflags-$(CONFIG_MACH_DECSTATION)	+= \
 			-I$(srctree)/arch/mips/include/asm/mach-dec
 libs-$(CONFIG_MACH_DECSTATION)		+= arch/mips/dec/prom/
-- 
1.7.2.3
