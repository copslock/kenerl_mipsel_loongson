Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 00:13:03 +0200 (CEST)
Received: from mail-bn1lp0141.outbound.protection.outlook.com ([207.46.163.141]:9334
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854794AbaE1WKNk8ys2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 00:10:13 +0200
Received: from alberich.caveonetworks.com (31.213.222.82) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 21:53:49 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 05/13] MIPS: Don't build fast TLB refill handler with 32-bit kernels
Date:   Wed, 28 May 2014 23:52:08 +0200
Message-ID: <1401313936-11867-6-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AMSPR01CA013.eurprd01.prod.exchangelabs.com
 (10.255.167.158) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(69596002)(99396002)(76482001)(46102001)(77156001)(50466002)(85852003)(50226001)(89996001)(83072002)(53416003)(102836001)(104166001)(101416001)(80022001)(92566001)(64706001)(92726001)(79102001)(19580395003)(83322001)(19580405001)(31966008)(74502001)(74662001)(36756003)(33646001)(86362001)(66066001)(21056001)(81342001)(87286001)(93916002)(62966002)(4396001)(77982001)(48376002)(50986999)(76176999)(87976001)(20776003)(81542001)(42186004)(81156002)(88136002)(47776003)(158023001);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40312
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

The fast handler only supports 64-bit kernels.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index f99ec587..af91f3e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1250,13 +1250,17 @@ static void build_r4000_tlb_refill_handler(void)
 	unsigned int final_len;
 	struct mips_huge_tlb_info htlb_info __maybe_unused;
 	enum vmalloc64_mode vmalloc_mode __maybe_unused;
-
+#ifdef CONFIG_64BIT
+	bool is64bit = true;
+#else
+	bool is64bit = false;
+#endif
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));
 
-	if ((scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
+	if (is64bit && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
 		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
 							  scratch_reg);
 		vmalloc_mode = refill_scratch;
-- 
1.7.9.5
