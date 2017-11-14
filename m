Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 14:31:31 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:48659 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992314AbdKNNbUr8Me0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 14:31:20 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 13:31:11 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 14 Nov 2017 05:29:24 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] MIPS: ath25: Avoid undefined early_serial_setup() without SERIAL_8250_CONSOLE
Date:   Tue, 14 Nov 2017 13:29:17 +0000
Message-ID: <1510666157-27252-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510666270-321457-20023-78747-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186914
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
X-archive-position: 60916
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

Currently MIPS allnoconfig with CONFIG_ATH25=y fails to link due to
missing support for early_serial_setup():

  LD      vmlinux
arch/mips/ath25/devices.o: In function ath25_serial_setup':
devices.c:(.init.text+0x68): undefined reference to 'early_serial_setup'

Rather than adding dependencies to the platform to force inclusion of
SERIAL_8250_CONSOLE together with it's dependencies like TTY, HAS_IOMEM,
etc, just make ath25_serial_setup() a no-op when the dependency is not
selected in the kernel config.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/ath25/devices.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
index e1156347da53..301a9028273c 100644
--- a/arch/mips/ath25/devices.c
+++ b/arch/mips/ath25/devices.c
@@ -73,6 +73,7 @@ const char *get_system_type(void)
 
 void __init ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
 {
+#ifdef CONFIG_SERIAL_8250_CONSOLE
 	struct uart_port s;
 
 	memset(&s, 0, sizeof(s));
@@ -85,6 +86,7 @@ void __init ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
 	s.uartclk = uartclk;
 
 	early_serial_setup(&s);
+#endif /* CONFIG_SERIAL_8250_CONSOLE */
 }
 
 int __init ath25_add_wmac(int nr, u32 base, int irq)
-- 
2.7.4
