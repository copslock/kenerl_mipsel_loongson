Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:54:48 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:39654 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835059Ab3ESFtpr30K- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:49:45 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:49:35 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 627A363006A; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 18/18] KVM/MIPS32-VZ: Dump out additional info about VZ features as part of /proc/cpuinfo
Date:   Sat, 18 May 2013 22:47:40 -0700
Message-Id: <1368942460-15577-19-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
References: <n>
 <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kernel/proc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index a3e4614..308e042 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -99,6 +99,17 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_vz)		seq_printf(m, "%s", " vz");
 	seq_printf(m, "\n");
 
+#ifdef CONFIG_KVM_MIPS_VZ
+	if (cpu_has_vz) {
+		seq_printf(m, "vz guestid\t\t: %s\n",
+			cpu_has_vzguestid ? "yes" : "no");
+		seq_printf(m, "vz virt irq\t\t: %s\n",
+			cpu_has_vzvirtirq ? "yes" : "no");
+	}
+	seq_printf(m, "tlbinv instructions\t: %s\n",
+		cpu_has_tlbinv ? "yes" : "no");
+#endif
+
 	if (cpu_has_mmips) {
 		seq_printf(m, "micromips kernel\t: %s\n",
 		      (read_c0_config3() & MIPS_CONF3_ISA_OE) ?  "yes" : "no");
-- 
1.7.11.3
