Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:05:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47053 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010219AbbGJPEvwZXBp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:04:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 788229623C7C8;
        Fri, 10 Jul 2015 16:04:43 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:04:46 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:04:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 14/16] MIPS: advertise MSA support via HWCAP when present
Date:   Fri, 10 Jul 2015 16:00:23 +0100
Message-ID: <1436540426-10021-15-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.2]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48190
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

If MSA is supported by both the hardware & the kernel then advertise
that support to userland via the AT_HWCAP aux vector.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/cpu-probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 168a5d3..15e9efc 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1496,6 +1496,7 @@ void cpu_probe(void)
 		c->msa_id = cpu_get_msa_id();
 		WARN(c->msa_id & MSA_IR_WRPF,
 		     "Vector register partitioning unimplemented!");
+		elf_hwcap |= HWCAP_MIPS_MSA;
 	}
 
 	cpu_probe_vmbits(c);
-- 
2.4.4
