Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 16:46:42 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:53886 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992911AbdKNPqfs6ZI0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 16:46:35 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 15:46:29 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 14 Nov 2017 07:44:59 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: RB532: Avoid undefined early_serial_setup() without SERIAL_8250_CONSOLE
Date:   Tue, 14 Nov 2017 15:44:22 +0000
Message-ID: <1510674263-14065-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510674389-321459-22243-73736-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186917
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
X-archive-position: 60926
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

Currently MIPS allnoconfig with CONFIG_MIKROTIK_RB532=y fails to link due to
missing support for early_serial_setup():

  LD      vmlinux
arch/mips/rb532/serial.o: In function `setup_serial_port':
serial.c:(.init.text+0x14): undefined reference to `early_serial_setup'

Rather than adding dependencies to the platform to force inclusion of
SERIAL_8250_CONSOLE together with it's dependencies like TTY, HAS_IOMEM,
etc, just exclude arch/mips/rb532/serial.c from the build when it's
dependency is not selected in the kernel config.

Reported-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/rb532/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/rb532/Makefile b/arch/mips/rb532/Makefile
index efdecdb6e3ea..8186afca2234 100644
--- a/arch/mips/rb532/Makefile
+++ b/arch/mips/rb532/Makefile
@@ -2,4 +2,6 @@
 # Makefile for the RB532 board specific parts of the kernel
 #
 
-obj-y	 += irq.o time.o setup.o serial.o prom.o gpio.o devices.o
+obj-$(CONFIG_SERIAL_8250_CONSOLE) += serial.o
+
+obj-y	 += irq.o time.o setup.o prom.o gpio.o devices.o
-- 
2.7.4
