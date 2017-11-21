Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Nov 2017 01:04:21 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:37823 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992280AbdKUAEPECysn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Nov 2017 01:04:15 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 21 Nov 2017 00:03:16 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 20 Nov 2017 16:03:17 -0800
From:   James Hogan <james.hogan@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, James Hogan <jhogan@kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Fix CPS SMP NS16550 UART defaults
Date:   Tue, 21 Nov 2017 00:02:40 +0000
Message-ID: <20171121000240.4058-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <5e88e3d4-3c4b-b5eb-0b32-d0c0902e14c2@roeck-us.net>
References: <5e88e3d4-3c4b-b5eb-0b32-d0c0902e14c2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511222596-637139-12578-366385-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187137
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

The MIPS_CPS_NS16550_BASE and MIPS_CPS_NS16550_SHIFT options have no
defaults for non-Malta platforms which select SYS_SUPPORTS_MIPS_CPS
(i.e. the pistachio and generic platforms). This is problematic for
automated allyesconfig and allmodconfig builds based on these platforms,
since make silentoldconfig tries to ask the user for values, and
especially since v4.15 where the default platform was switched to
generic.

Default these options to 0 and arrange for MIPS_CPS_NS16550 to be no
when using that default base address, so that the option only has an
effect when the default is provided (i.e. Malta) or when a value is
provided by the user.

Fixes: 609cf6f2291a ("MIPS: CPS: Early debug using an ns16550-compatible UART")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-mips@linux-mips.org
---
Guenter: I'm guessing this is the problem you're referring to.
---
 arch/mips/Kconfig.debug | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 464af5e025d6..0749c3724543 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -124,30 +124,36 @@ config SCACHE_DEBUGFS
 
 	  If unsure, say N.
 
-menuconfig MIPS_CPS_NS16550
+menuconfig MIPS_CPS_NS16550_BOOL
 	bool "CPS SMP NS16550 UART output"
 	depends on MIPS_CPS
 	help
 	  Output debug information via an ns16550 compatible UART if exceptions
 	  occur early in the boot process of a secondary core.
 
-if MIPS_CPS_NS16550
+if MIPS_CPS_NS16550_BOOL
+
+config MIPS_CPS_NS16550
+	def_bool MIPS_CPS_NS16550_BASE != 0
 
 config MIPS_CPS_NS16550_BASE
 	hex "UART Base Address"
 	default 0x1b0003f8 if MIPS_MALTA
+	default 0
 	help
 	  The base address of the ns16550 compatible UART on which to output
 	  debug information from the early stages of core startup.
 
+	  This is only used if non-zero.
+
 config MIPS_CPS_NS16550_SHIFT
 	int "UART Register Shift"
-	default 0 if MIPS_MALTA
+	default 0
 	help
 	  The number of bits to shift ns16550 register indices by in order to
 	  form their addresses. That is, log base 2 of the span between
 	  adjacent ns16550 registers in the system.
 
-endif # MIPS_CPS_NS16550
+endif # MIPS_CPS_NS16550_BOOL
 
 endmenu
-- 
2.14.1
