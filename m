Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 17:13:10 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55064 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011686AbaJQPMvXl-eD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2014 17:12:51 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s9HFCjNS011198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 17 Oct 2014 15:12:45 GMT
Received: from localhost.localdomain ([10.144.45.144])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s9HFCdwh023871;
        Fri, 17 Oct 2014 17:12:45 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH 3/3] MIPS: oprofile: backtrace: don't fail on leaf functions
Date:   Fri, 17 Oct 2014 18:10:26 +0300
Message-Id: <1413558626-16364-3-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1413558626-16364-1-git-send-email-aaro.koskinen@nsn.com>
References: <1413558626-16364-1-git-send-email-aaro.koskinen@nsn.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1406
X-purgate-ID: 151667::1413558766-0000437E-F34FF0A7/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
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

Continue the backtrace if we cannot find SP adjustment and RA save. In
that case, just assume the current RA. This allows us to get samples of
frequent callers of e.g. GLIBC memset().

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/oprofile/backtrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
index 83a1dfd..5e645c9 100644
--- a/arch/mips/oprofile/backtrace.c
+++ b/arch/mips/oprofile/backtrace.c
@@ -65,7 +65,7 @@ static inline int is_end_of_function_marker(union mips_instruction *ip)
  * - handle cases where the stack is adjusted inside a function
  *     (generally doesn't happen)
  * - find optimal value for max_instr_check
- * - try to find a way to handle leaf functions
+ * - try to find a better way to handle leaf functions
  */
 
 static inline int unwind_user_frame(struct stackframe *old_frame,
@@ -104,7 +104,7 @@ static inline int unwind_user_frame(struct stackframe *old_frame,
 	}
 
 	if (!ra_offset || !stack_size)
-		return -1;
+		goto done;
 
 	if (ra_offset) {
 		new_frame.ra = old_frame->sp + ra_offset;
@@ -121,6 +121,7 @@ static inline int unwind_user_frame(struct stackframe *old_frame,
 	if (new_frame.sp > old_frame->sp)
 		return -2;
 
+done:
 	new_frame.pc = old_frame->ra;
 	*old_frame = new_frame;
 
-- 
1.9.1
