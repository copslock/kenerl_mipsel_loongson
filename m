Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:28:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29060 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009063AbbIVR15oStqU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:27:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 75C4AC2BD2FB6;
        Tue, 22 Sep 2015 18:27:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:27:52 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:27:51 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] MIPS: avoid buffer overrun in mips_cm_error_report
Date:   Tue, 22 Sep 2015 10:26:39 -0700
Message-ID: <1442942801-2883-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442942801-2883-1-git-send-email-paul.burton@imgtec.com>
References: <1442942801-2883-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49287
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

Commit 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache
errors") added cases for decoding errors reported by CM3, but leaves the
buf variable which is printed as a string uninitialised for cause values
other than 1, 2 or 3. Fix by ensuring the buf variable is initialised to
an empty string in such cases.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/mips-cm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 10524ce..88a8e21 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -366,6 +366,8 @@ void mips_cm_error_report(void)
 				 cm3_cmd_group[cmd_group_bits],
 				 cm3_cca_bits, 1 << mcp_bits,
 				 cm3_tr[cm3_tr_bits], sched_bit);
+		} else {
+			buf[0] = 0;
 		}
 
 		pr_err("CM_ERROR=%llx %s <%s>\n", cm_error,
-- 
2.5.3
