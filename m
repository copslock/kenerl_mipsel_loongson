Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:29:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37816 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027034AbcDSI2pWwWSY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:28:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 094A0A5AEC11E;
        Tue, 19 Apr 2016 09:28:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Apr 2016 09:28:39 +0100
Received: from localhost (10.100.200.185) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 09:28:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 13/13] MIPS: mm: Panic if an XPA kernel is run without RIXI
Date:   Tue, 19 Apr 2016 09:25:11 +0100
Message-ID: <1461054311-387-14-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
References: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.185]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53094
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

XPA kernels hardcode for the presence of RIXI - the PTE format & its
handling presume RI & XI bits. Make this dependence explicit by panicing
if we run on a system that violates it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>

---

Changes in v3:
- Remove newline in panic() call.

Changes in v2:
- New patch, in response to clarification on patch 5.

 arch/mips/mm/tlbex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 3f1a8a2..2afc710 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2395,6 +2395,9 @@ void build_tlb_refill_handler(void)
 	 */
 	static int run_once = 0;
 
+	if (config_enabled(CONFIG_XPA) && !cpu_has_rixi)
+		panic("Kernels supporting XPA currently require CPUs with RIXI");
+
 	output_pgtable_bits_defines();
 	check_pabits();
 
-- 
2.8.0
