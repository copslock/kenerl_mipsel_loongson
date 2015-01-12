Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 08:08:36 +0100 (CET)
Received: from jaguar.aricent.com ([180.151.2.24]:41163 "EHLO
        jaguar.aricent.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014481AbbALHIIxbMQ3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 08:08:08 +0100
Received: from jaguar.aricent.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33D33218BAF;
        Mon, 12 Jan 2015 12:38:02 +0530 (IST)
Received: from GUREXHT01.ASIAN.AD.ARICENT.COM (unknown [10.203.171.136])
        by jaguar.aricent.com (Postfix) with ESMTPS id 19226218B70;
        Mon, 12 Jan 2015 12:38:02 +0530 (IST)
Received: from imsseuq.aricent.com (10.203.171.248) by
 GUREXHT01.ASIAN.AD.ARICENT.COM (10.203.171.136) with Microsoft SMTP Server id
 8.3.342.0; Mon, 12 Jan 2015 12:38:00 +0530
Received: from h2512.localdomain ([172.16.116.228])     by imsseuq.aricent.com
 (8.13.1/8.13.1) with ESMTP id t0C6VBrD019509;  Mon, 12 Jan 2015 12:01:34 +0530
From:   Abhishek Paliwal <abhishek.paliwal@aricent.com>
To:     <kexin.hao@windriver.com>, <bo.liu@windriver.com>
CC:     Chandrakala.Chavva@caviumnetworks.com, rakesh.garg@aricent.com,
        Abhishek Paliwal <abhishek.paliwal@aricent.com>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        kvm@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/9] MIPS Add function get ebase cpunum
Date:   Mon, 12 Jan 2015 12:36:19 +0530
Message-ID: <1421046385-2535-4-git-send-email-abhishek.paliwal@aricent.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
References: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
Return-Path: <abhishek.paliwal@aricent.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhishek.paliwal@aricent.com
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

commit  45b585c8dcdc469bb40b58cc2801acd7a2332525 upstream

This returns the CPUNum from the low order Ebase bits.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: James Hogan <james.hogan@imgtec.com>
Cc: kvm@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/7012/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Abhishek Paliwal <abhishek.paliwal@aricent.com>
---
 arch/mips/include/asm/mipsregs.h | 8 ++++++++
 arch/mips/kernel/cpu-probe.c     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index bbc3dd4..327f989 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1894,6 +1894,14 @@ __BUILD_SET_C0(brcm_cmt_ctrl)
 __BUILD_SET_C0(brcm_config)
 __BUILD_SET_C0(brcm_mode)

+/*
+ * Return low 10 bits of ebase.
+ * Note that under KVM (MIPSVZ) this returns vcpu id.
+ */
+static inline unsigned int get_ebase_cpunum(void)
+{
+       return read_c0_ebase() & 0x3ff;
+}
 #endif /* !__ASSEMBLY__ */

 #endif /* _ASM_MIPSREGS_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 530f832..19432da 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -399,7 +399,7 @@ static void decode_configs(struct cpuinfo_mips *c)
        mips_probe_watch_registers(c);

        if (cpu_has_mips_r2)
-               c->core = read_c0_ebase() & 0x3ff;
+               c->core = get_ebase_cpunum();
 }

 #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
--
1.8.1.4



"DISCLAIMER: This message is proprietary to Aricent and is intended solely for the use of the individual to whom it is addressed. It may contain privileged or confidential information and should not be circulated or used for any purpose other than for what it is intended. If you have received this message in error, please notify the originator immediately. If you are not the intended recipient, you are notified that you are strictly prohibited from using, copying, altering, or disclosing the contents of this message. Aricent accepts no responsibility for loss or damage arising from the use of the information transmitted by this email including damage from virus."
