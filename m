Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 11:12:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26261 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006859AbbLHKMErPtB2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 11:12:04 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id B60AA32230FF3;
        Tue,  8 Dec 2015 10:11:56 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 10:11:58 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 10:11:58 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <alex@alex-smith.me.uk>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH] MIPS: VDSO: Fix build error
Date:   Tue, 8 Dec 2015 10:11:43 +0000
Message-ID: <1449569503-1611-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

Commit ebb5e78cc634 (MIPS: Initial implementation of a VDSO) introduced a build
error.

For MIPS VDSO to be compiled it requires binutils version 2.25 or above but the
check in the Makefile had inverted logic causing it to be compiled in if binutils
is below 2.25.

This fixes the following compilation error:

CC      arch/mips/vdso/gettimeofday.o
/tmp/ccsExcUd.s: Assembler messages:
/tmp/ccsExcUd.s:62: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}
/tmp/ccsExcUd.s:467: Error: can't resolve `_start' {*UND* section} - `L0' {.text section}
make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
make[1]: *** [arch/mips/vdso] Error 2
make: *** [arch/mips] Error 2

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index ef5f348f386a..018f8c7b94f2 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,8 +26,8 @@ aflags-vdso := $(ccflags-vdso) \
 # the comments on that file.
 #
 ifndef CONFIG_CPU_MIPSR6
-  ifeq ($(call ld-ifversion, -gt, 22400000, y),)
-    $(warning MIPS VDSO requires binutils > 2.24)
+  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
+    $(warning MIPS VDSO requires binutils >= 2.25)
     obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
     ccflags-vdso += -DDISABLE_MIPS_VDSO
   endif
-- 
2.1.0
