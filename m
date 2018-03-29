Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 15:27:10 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:49617 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeC2N1BWJrfM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 15:27:01 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 29 Mar 2018 13:25:21 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 29 Mar 2018 03:41:37 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-riscv@lists.infradead.org>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Rob Herring <robh@kernel.org>, Nick Terrell <terrelln@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "Albert Ou" <albert@sifive.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Tom Herbert <tom@quantonium.net>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v4 2/3] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
Date:   Thu, 29 Mar 2018 11:41:22 +0100
Message-ID: <1522320083-27818-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
References: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522329921-321457-5536-21429-1
X-BESS-VER: 2018.3-r1803262126
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191513
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

When these are included into arch Kconfig files, maintaining
alphabetical ordering of the selects means these get split up. To allow
for keeping things tidier and alphabetical, rename the selects to
GENERIC_LIB_*

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

---

Changes in v4:
Rename Kconfig symbols GENERIC_* -> GENERIC_LIB_*

Changes in v3: None
Changes in v2: None

 arch/riscv/Kconfig |  6 +++---
 lib/Kconfig        | 12 ++++++------
 lib/Makefile       | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 04807c7f64cc..20185aaaf933 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -104,9 +104,9 @@ config ARCH_RV32I
 	bool "RV32I"
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select 32BIT
-	select GENERIC_ASHLDI3
-	select GENERIC_ASHRDI3
-	select GENERIC_LSHRDI3
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_LSHRDI3
 
 config ARCH_RV64I
 	bool "RV64I"
diff --git a/lib/Kconfig b/lib/Kconfig
index e96089499371..e54ebe00937e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -588,20 +588,20 @@ config STRING_SELFTEST
 
 endmenu
 
-config GENERIC_ASHLDI3
+config GENERIC_LIB_ASHLDI3
 	bool
 
-config GENERIC_ASHRDI3
+config GENERIC_LIB_ASHRDI3
 	bool
 
-config GENERIC_LSHRDI3
+config GENERIC_LIB_LSHRDI3
 	bool
 
-config GENERIC_MULDI3
+config GENERIC_LIB_MULDI3
 	bool
 
-config GENERIC_CMPDI2
+config GENERIC_LIB_CMPDI2
 	bool
 
-config GENERIC_UCMPDI2
+config GENERIC_LIB_UCMPDI2
 	bool
diff --git a/lib/Makefile b/lib/Makefile
index a90d4fcd748f..7425e177f08c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -253,9 +253,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 obj-$(CONFIG_PARMAN) += parman.o
 
 # GCC library routines
-obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
-obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
-obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
-obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
-obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
-obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
+obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
+obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
+obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
+obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
+obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
+obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
-- 
2.7.4
