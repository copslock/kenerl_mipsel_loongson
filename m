Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jun 2017 22:55:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15971 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994915AbdFQUyruAp7F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jun 2017 22:54:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 544757B612F2C;
        Sat, 17 Jun 2017 21:54:37 +0100 (IST)
Received: from localhost (10.20.78.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 17 Jun
 2017 21:54:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Subject: [PATCH v5 3/4] MIPS: DTS: img: Don't attempt to build-in all .dtb files
Date:   Sat, 17 Jun 2017 13:52:48 -0700
Message-ID: <20170617205249.1391-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170617205249.1391-1-paul.burton@imgtec.com>
References: <20170617205249.1391-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.225]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

When building a FIT image we may want the kernel to build multiple .dtb
files, but we don't want to build them all into the kernel binary as
object files since they'll instead be included in the FIT image.

Commit daa10170da27 ("MIPS: DTS: img: add device tree for Marduk board")
however created arch/mips/boot/dts/img/Makefile with a line that builds
any enabled .dtb files into the kernel. Remove this & build the
pistachio object specifically, in preparation for adding .dtb targets
which we don't want to build into the kernel.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v5: None

Changes in v4:
- New patch.

Changes in v3: None
Changes in v2: None

 arch/mips/boot/dts/img/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
index 69a65f0f82d2..c178cf56f5b8 100644
--- a/arch/mips/boot/dts/img/Makefile
+++ b/arch/mips/boot/dts/img/Makefile
@@ -1,6 +1,5 @@
 dtb-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb
-
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb.o
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-- 
2.13.1
