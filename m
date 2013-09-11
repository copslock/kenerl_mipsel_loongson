Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 06:57:43 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4894 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822681Ab3IKE5ky0SZR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 06:57:40 +0200
X-Authority-Analysis: v=2.0 cv=fJG7LOme c=1 sm=0 a=Sro2XwOs0tJUSHxCKfOySw==:17 a=Drc5e87SC40A:10 a=Ciwy3NGCPMMA:10 a=0VuXmfspDfQA:10 a=5SG0PmZfjMsA:10 a=bbbx4UPp9XUA:10 a=meVymXHHAAAA:8 a=KGjhK52YXX0A:10 a=TOGzHjoSfPQA:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=VPGR01oulgvuwXaeG6kA:9 a=EDSpbFuiShEA:10 a=1DbiqZag68YA:10 a=jeBq3FmKZ4MA:10 a=Sro2XwOs0tJUSHxCKfOySw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.255.60.225
Received: from [67.255.60.225] ([67.255.60.225:50902] helo=gandalf.local.home)
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 4A/3F-27973-448FF225; Wed, 11 Sep 2013 04:57:40 +0000
Received: from rostedt by gandalf.local.home with local (Exim 4.80)
        (envelope-from <rostedt@goodmis.org>)
        id 1VJc35-0002HY-1H; Wed, 11 Sep 2013 00:29:03 -0400
Message-Id: <20130911042902.966666775@goodmis.org>
User-Agent: quilt/0.60-1
Date:   Wed, 11 Sep 2013 00:28:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [063/251] lib/Kconfig.debug: Restrict FRAME_POINTER for MIPS
References: <20130911042707.738353451@goodmis.org>
Content-Disposition: inline; filename=0063-lib-Kconfig.debug-Restrict-FRAME_POINTER-for-MIPS.patch
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

3.6.11.9-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

[ Upstream commit 25c87eae1725ed77a8b44d782a86abdc279b4ede ]

FAULT_INJECTION_STACKTRACE_FILTER selects FRAME_POINTER but
that symbol is not available for MIPS.

Fixes the following problem on a randconfig:
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP &&
 KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies
(DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN ||
MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Patchwork: https://patchwork.linux-mips.org/patch/5441/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2403a63..89a657a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1242,7 +1242,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
-- 
1.7.10.4
