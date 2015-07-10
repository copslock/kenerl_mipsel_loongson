Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:01:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14258 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010008AbbGJPBYo4pTp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:01:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 429DB8DC27D9F;
        Fri, 10 Jul 2015 16:01:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:01:18 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:01:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/16] MIPS: remove outdated comments in sigcontext.h
Date:   Fri, 10 Jul 2015 16:00:10 +0100
Message-ID: <1436540426-10021-2-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 48177
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

The offsets to various fields within struct sigcontext are declared
using asm-offsets.c these days, so drop the outdated comment that talks
about keeping in sync with a no longer present file.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/uapi/asm/sigcontext.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
index 6c9906f..ae78902 100644
--- a/arch/mips/include/uapi/asm/sigcontext.h
+++ b/arch/mips/include/uapi/asm/sigcontext.h
@@ -14,10 +14,6 @@
 
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
-/*
- * Keep this struct definition in sync with the sigcontext fragment
- * in arch/mips/tools/offset.c
- */
 struct sigcontext {
 	unsigned int		sc_regmask;	/* Unused */
 	unsigned int		sc_status;	/* Unused */
@@ -45,9 +41,6 @@ struct sigcontext {
 
 #include <linux/posix_types.h>
 /*
- * Keep this struct definition in sync with the sigcontext fragment
- * in arch/mips/tools/offset.c
- *
  * Warning: this structure illdefined with sc_badvaddr being just an unsigned
  * int so it was changed to unsigned long in 2.6.0-test1.  This may break
  * binary compatibility - no prisoners.
-- 
2.4.4
