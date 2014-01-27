Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:30:40 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4502 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824283AbaA0PaiKZVBj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:30:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 14/15] mips: panic if vector register partitioning is implemented
Date:   Mon, 27 Jan 2014 15:23:13 +0000
Message-ID: <1390836194-26286-15-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_30_33
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39108
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

No current systems implementing MSA include support for vector register
partitioning which makes it somewhat difficult to implement support for
it in the kernel. Thus for the moment the kernel includes no such
support. However if the kernel were to be run on a system which
implemented register partitioning then it would not function correctly,
mishandling MSA disabled exceptions. Calling panic when run on a system
with vector register partitioning implemented ensures that we're not
caught out by this later but instead reminded to implement support once
such a system is available.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/cpu-probe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 852e085..003ba3c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1193,9 +1193,13 @@ void cpu_probe(void)
 	else
 		c->srsets = 1;
 
-	if (cpu_has_msa)
+	if (cpu_has_msa) {
 		c->msa_id = cpu_get_msa_id();
 
+		if (c->msa_id & MSA_IR_WRPF)
+			panic("Vector register partitioning unimplemented!");
+	}
+
 	cpu_probe_vmbits(c);
 
 #ifdef CONFIG_64BIT
-- 
1.8.5.3
