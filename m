Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:52:16 +0200 (CEST)
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:59443
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855093AbaETOtbn09EU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:49:31 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:49:14 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 09/15] MIPS: Add functions for hypervisor call
Date:   Tue, 20 May 2014 16:47:10 +0200
Message-ID: <1400597236-11352-10-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA004.eurprd01.prod.exchangelabs.com
 (10.242.240.14) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6069001)(6009001)(428001)(199002)(189002)(79102001)(36756003)(48376002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(20776003)(50226001)(33646001)(101416001)(50986999)(76482001)(77156001)(89996001)(42186004)(81542001)(92566001)(62966002)(81342001)(87976001)(93916002)(87286001)(4396001)(19580395003)(83072002)(88136002)(85852003)(21056001)(76176999)(83322001)(31966008)(74662001)(86362001)(99396002)(102836001)(19580405001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40183
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
 arch/mips/include/asm/mipsregs.h |   67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index f110d48..e12a518 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1916,6 +1916,73 @@ __BUILD_SET_C0(brcm_cmt_ctrl)
 __BUILD_SET_C0(brcm_config)
 __BUILD_SET_C0(brcm_mode)
 
+static inline unsigned long hypcall0(unsigned long num)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+
+	n = num;
+	__asm__ __volatile__(
+		".word 0x42000028"	/* HYPCALL */
+		: "=r" (r) : "r" (n) : "memory"
+		);
+
+	return r;
+}
+static inline unsigned long hypcall1(unsigned long num, unsigned long arg0)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+	register unsigned long a0 asm("a0");
+
+	n = num;
+	a0 = arg0;
+	__asm__ __volatile__(
+		".word 0x42000028"	/* HYPCALL */
+		: "=r" (r) : "r" (n), "r" (a0) : "memory"
+		);
+
+	return r;
+}
+static inline unsigned long hypcall2(unsigned long num, unsigned long arg0,
+				     unsigned long arg1)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+	register unsigned long a0 asm("a0");
+	register unsigned long a1 asm("a1");
+
+	n = num;
+	a0 = arg0;
+	a1 = arg1;
+	__asm__ __volatile__(
+		".word 0x42000028"	/* HYPCALL */
+		: "=r" (r) : "r" (n), "r" (a0), "r" (a1) : "memory"
+		);
+
+	return r;
+}
+static inline unsigned long hypcall3(unsigned long num, unsigned long arg0,
+				     unsigned long arg1, unsigned long arg2)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+	register unsigned long a0 asm("a0");
+	register unsigned long a1 asm("a1");
+	register unsigned long a2 asm("a2");
+
+	n = num;
+	a0 = arg0;
+	a1 = arg1;
+	a2 = arg2;
+	__asm__ __volatile__(
+		".word 0x42000028"	/* HYPCALL */
+		: "=r" (r) : "r" (n), "r" (a0), "r" (a1), "r" (a2) : "memory"
+		);
+
+	return r;
+}
+
 static inline unsigned int mips_cpunum(void)
 {
 	return read_c0_ebase() & 0x3ff; /* Low 10 bits of ebase. */
-- 
1.7.9.5
