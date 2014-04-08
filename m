Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:51:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:34024 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6820489AbaDHLrceINf0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1134D26E19A4C
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:23 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 12:47:24 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:24 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:23 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 14/14] MIPS: Enable the BPF_JIT symbol for MIPS
Date:   Tue, 8 Apr 2014 12:47:15 +0100
Message-ID: <1396957635-27071-15-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 16d5ab1..7a6edca 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -12,6 +12,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_BPF_JIT if CPU_MIPSR2 && !CPU_MICROMIPS
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
-- 
1.9.1
