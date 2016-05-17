Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 16:56:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34964 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029564AbcEQO43fuS5o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 16:56:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 94A5B42A23DD6;
        Tue, 17 May 2016 15:56:19 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 17 May 2016 15:56:22 +0100
Received: from localhost (10.100.200.141) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 17 May
 2016 15:56:22 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W . Rozycki" <Maciej.Rozycki@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "stable # v4 . 4+" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] MIPS: Allow R6 compact branch policy to be left unspecified
Date:   Tue, 17 May 2016 15:55:53 +0100
Message-ID: <1463496954-24713-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53490
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

It turns out that some toolchains which support MIPS R6 don't support
the -mcompact-branches flag to specify compact branch behaviour. Default
to not providing the -mcompact-branch option to the compiler such that
we can build with such toolchains.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: c1a0e9bc885d ("MIPS: Allow compact branch policy to be changed")
Cc: stable <stable@vger.kernel.org> # v4.4+

---

Changes in v2:
- Hide the options behind CONFIG_DEBUG_KERNEL.

 arch/mips/Kconfig.debug | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index f0e314c..ee3dc9b 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -117,7 +117,16 @@ if CPU_MIPSR6
 
 choice
 	prompt "Compact branch policy"
-	default MIPS_COMPACT_BRANCHES_OPTIMAL
+	depends on DEBUG_KERNEL
+	default MIPS_COMPACT_BRANCHES_DEFAULT
+
+config MIPS_COMPACT_BRANCHES_DEFAULT
+	bool "Toolchain Default (don't specify)"
+	help
+	  Don't pass the -mcompact-branches flag to the compiler, allowing it
+	  to use its default (generally "optimal"). This is particularly
+	  useful for early R6-supporting toolchains which don't support the
+	  -mcompact-branches flag.
 
 config MIPS_COMPACT_BRANCHES_NEVER
 	bool "Never (force delay slot branches)"
-- 
2.8.2
