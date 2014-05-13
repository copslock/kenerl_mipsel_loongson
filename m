Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2014 11:06:18 +0200 (CEST)
Received: from mail-by2on0101.outbound.protection.outlook.com ([207.46.100.101]:6269
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6841768AbaEMJGCkcizk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 May 2014 11:06:02 +0200
Received: from BL2FFO11FD019.protection.gbl (10.173.160.31) by
 BL2FFO11HUB055.protection.gbl (10.173.161.155) with Microsoft SMTP Server
 (TLS) id 15.0.939.9; Tue, 13 May 2014 09:05:53 +0000
Received: from SJ-ITEXEDGE02.altera.priv.altera.com (66.35.236.232) by
 BL2FFO11FD019.mail.protection.outlook.com (10.173.161.37) with Microsoft SMTP
 Server (TLS) id 15.0.939.9 via Frontend Transport; Tue, 13 May 2014 09:05:53
 +0000
Received: from sj-mail01.altera.com (137.57.1.6) by
 SJ-ITEXEDGE02.altera.priv.altera.com (66.35.236.232) with Microsoft SMTP
 Server id 8.3.348.2; Tue, 13 May 2014 01:52:16 -0700
Received: from leyfoon-vm (leyfoon-vm.altera.com [137.57.103.35])       by
 sj-mail01.altera.com (8.13.7+Sun/8.13.7) with SMTP id s4D95m6p004367;  Tue, 13
 May 2014 02:05:49 -0700 (PDT)
Received: by leyfoon-vm (sSMTP sendmail emulation); Tue, 13 May 2014 17:05:47
 +0800
From:   Ley Foon Tan <lftan@altera.com>
To:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>,
        <cltang@codesourcery.com>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 14/25] mips: Add 32 bit time_t and clock_t
Date:   Tue, 13 May 2014 17:05:29 +0800
Message-ID: <1399971929-4487-1-git-send-email-lftan@altera.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:66.35.236.232;CTRY:US;IPV:NLI;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10019001)(6009001)(199002)(189002)(36756003)(79102001)(76482001)(92566001)(33646001)(92726001)(47776003)(20776003)(86362001)(77982001)(84676001)(48376002)(50466002)(50986999)(89996001)(76176999)(102836001)(77156001)(2009001)(87936001)(87286001)(83072002)(85852003)(16796002)(31966008)(74662001)(74502001)(46102001)(19580405001)(6806004)(44976005)(19580395003)(83322001)(81342001)(81542001)(62966002)(4396001)(50226001)(80022001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2FFO11HUB055;H:SJ-ITEXEDGE02.altera.priv.altera.com;FPR:;MLV:sfv;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-OriginatorOrg: altera.onmicrosoft.com
X-Forefront-PRVS: 0210479ED8
Received-SPF: SoftFail (: domain of transitioning altera.com discourages use
 of 66.35.236.232 as permitted sender)
Authentication-Results: spf=softfail (sender IP is 66.35.236.232)
 smtp.mailfrom=lftan@altera.com; 
Return-Path: <lftan@altera.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lftan@altera.com
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

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/mips/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/uapi/asm/posix_types.h b/arch/mips/include/uapi/asm/posix_types.h
index fa03ec3..e9ca921 100644
--- a/arch/mips/include/uapi/asm/posix_types.h
+++ b/arch/mips/include/uapi/asm/posix_types.h
@@ -25,6 +25,12 @@ typedef struct {
 	long	val[2];
 } __kernel_fsid_t;
 #define __kernel_fsid_t __kernel_fsid_t
+
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
 #endif
 
 #include <asm-generic/posix_types.h>
-- 
1.8.2.1
