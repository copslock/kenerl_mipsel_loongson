Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 13:49:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7357 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861346AbaGILstEu7et (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 13:48:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E21262A22D1AB
        for <linux-mips@linux-mips.org>; Wed,  9 Jul 2014 12:48:39 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 9 Jul 2014 12:48:42 +0100
Received: from pburton-laptop.home (192.168.79.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:48:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/5] MIPS: fix potential build failures using cpu_vpe_id on non-MT
Date:   Wed, 9 Jul 2014 12:48:20 +0100
Message-ID: <1404906502-10702-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404906502-10702-1-git-send-email-paul.burton@imgtec.com>
References: <1404906502-10702-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.89]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41094
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

When used in a non-MT kernel, the cpu_vpe_id macro never made use of
its cpuinfo argument. It doesn't actually need to since it is returning
a constant 0. However not using the argument can lead to build failures
if the compiler then notices that a variable used as part of the
argument is unused. Prevent that problem by "using" the argument as far
as the compiler is concerned, whilst still returning 0 as before.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 47d5967..a28e3de 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -115,7 +115,7 @@ struct proc_cpuinfo_notifier_args {
 #ifdef CONFIG_MIPS_MT_SMP
 # define cpu_vpe_id(cpuinfo)	((cpuinfo)->vpe_id)
 #else
-# define cpu_vpe_id(cpuinfo)	0
+# define cpu_vpe_id(cpuinfo)	({ (void)cpuinfo; 0; })
 #endif
 
 #endif /* __ASM_CPU_INFO_H */
-- 
2.0.1
