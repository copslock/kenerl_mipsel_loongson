Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 00:16:22 +0200 (CEST)
Received: from dns-bn1lp0143.outbound.protection.outlook.com ([207.46.163.143]:30848
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854787AbaE1WL5yxtO7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 00:11:57 +0200
Received: from alberich.caveonetworks.com (31.213.222.82) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 21:54:40 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 12/13] MIPS: Enable build for new system 'paravirt'
Date:   Wed, 28 May 2014 23:52:15 +0200
Message-ID: <1401313936-11867-13-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AMSPR01CA013.eurprd01.prod.exchangelabs.com
 (10.255.167.158) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(69596002)(99396002)(76482001)(46102001)(77156001)(50466002)(85852003)(50226001)(89996001)(83072002)(53416003)(102836001)(104166001)(101416001)(80022001)(92566001)(64706001)(92726001)(79102001)(19580395003)(83322001)(19580405001)(31966008)(74502001)(74662001)(36756003)(33646001)(86362001)(66066001)(21056001)(81342001)(87286001)(93916002)(62966002)(4396001)(77982001)(48376002)(50986999)(76176999)(87976001)(20776003)(81542001)(42186004)(81156002)(88136002)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/Kbuild.platforms |    1 +
 arch/mips/Kconfig          |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 6e23912..f5e18bf 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -18,6 +18,7 @@ platforms += loongson1
 platforms += mti-malta
 platforms += mti-sead3
 platforms += netlogic
+platforms += paravirt
 platforms += pmcs-msp71xx
 platforms += pnx833x
 platforms += ralink
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1f836d8..df16e1e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -803,6 +803,25 @@ config NLM_XLP_BOARD
 	  This board is based on Netlogic XLP Processor.
 	  Say Y here if you have a XLP based board.
 
+config MIPS_PARAVIRT
+	bool "Para-Virtualized guest system"
+	select CEVT_R4K
+	select CSRC_R4K
+	select DMA_COHERENT
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_SMP
+	select NR_CPUS_DEFAULT_4
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS64_R2
+	select SYS_HAS_CPU_CAVIUM_OCTEON
+	select HW_HAS_PCI
+	select SWAP_IO_SPACE
+	help
+	  This option supports guest running under ????
+
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
-- 
1.7.9.5
