Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:47:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65148 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860086AbaGKPqYKq8aP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:46:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3A68ACFDD26C3
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:46:14 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:46:17 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:46:17 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:46:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/13] MIPS: ensure MSA gets disabled during boot
Date:   Fri, 11 Jul 2014 16:44:34 +0100
Message-ID: <1405093479-5123-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41143
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

The kernel relies upon MSA being disabled when a task begins running,
so that it can initialise or restore context in response to the
resulting MSA disabled exception. Previously the state of MSA following
boot was left as it was before the kernel ran, where MSA could
potentially have been enabled. Explicitly disable it during boot to
prevent any problems.

As a nice side effect the code reads a little better too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/cpu-probe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e818547..1b345f0 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -130,14 +130,13 @@ static inline int __cpu_has_fpu(void)
 
 static inline unsigned long cpu_get_msa_id(void)
 {
-	unsigned long status, conf5, msa_id;
+	unsigned long status, msa_id;
 
 	status = read_c0_status();
 	__enable_fpu(FPU_64BIT);
-	conf5 = read_c0_config5();
 	enable_msa();
 	msa_id = read_msa_ir();
-	write_c0_config5(conf5);
+	disable_msa();
 	write_c0_status(status);
 	return msa_id;
 }
-- 
2.0.1
