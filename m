Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Dec 2015 23:48:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15919 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008672AbbLZWsUigj7N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Dec 2015 23:48:20 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 3A03D84AACB5D;
        Sat, 26 Dec 2015 22:48:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Sat, 26 Dec 2015 22:48:14 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Sat, 26 Dec 2015 22:48:13 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Andi Kleen" <ak@linux.intel.com>, Michal Marek <mmarek@suse.cz>,
        Guenter Roeck <linux@roeck-us.net>, <linux-mips@linux-mips.org>
Subject: [PATCH] Fix ld-version.sh to handle large 3rd version part
Date:   Sat, 26 Dec 2015 22:47:52 +0000
Message-ID: <1451170072-22846-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The ld-version.sh script doesn't handle versions with large (>= 10) 3rd
version components, because the 2nd component is only multiplied by 10
times that of the 3rd component.

For example the following version string:
GNU ld (Codescape GNU Tools 2015.06-05 for MIPS MTI Linux) 2.24.90

gives a bogus version number:
 20000000
+ 2400000
+  900000 = 23300000

Breakage, confusion and mole-whacking ensues.

Increase the multipliers of the first two version components by a factor
of 10 to give space for a 3rd components of up to 99, and update the
sole user of ld-ifversion (MIPS VDSO) accordingly.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-mips@linux-mips.org
---
This is based on top of mips-for-linux-next with Guenter's patch "MIPS:
VDSO: Fix build error with binutils 2.24 and earlier" applied first.

Ralf: Please consider applying to hopefully fix the VDSO build issue
once and for all.

Andi/Michal: If this patch gets merged, I'm guessing the patch "Kbuild,
lto: Add Link Time Optimization support v3" will need tweaking when it
gets merged.
---
 arch/mips/vdso/Makefile | 2 +-
 scripts/ld-version.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 14568900fc1d..ee3617c0c5e2 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
 # the comments on that file.
 #
 ifndef CONFIG_CPU_MIPSR6
-  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
+  ifeq ($(call ld-ifversion, -lt, 225000000, y),y)
     $(warning MIPS VDSO requires binutils >= 2.25)
     obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
     ccflags-vdso += -DDISABLE_MIPS_VDSO
diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index 198580d245e0..0b67edc5bc6f 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -3,6 +3,6 @@
 	{
 	gsub(".*)", "");
 	split($1,a, ".");
-	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
+	print a[1]*100000000 + a[2]*1000000 + a[3]*10000 + a[4]*100 + a[5];
 	exit
 	}
-- 
2.4.10
