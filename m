Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 15:33:26 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:54811 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013227AbaKKOdY5JN-c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 15:33:24 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id sABEXJZK001157
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 11 Nov 2014 14:33:19 GMT
Received: from localhost.localdomain ([10.144.45.144])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id sABEXIgR032128;
        Tue, 11 Nov 2014 15:33:18 +0100
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>, stable@vger.kernel.org
Subject: [PATCH RESEND 1/3] MIPS: oprofile: fix backtrace on 64-bit kernel
Date:   Tue, 11 Nov 2014 16:30:41 +0200
Message-Id: <1415716243-1303-1-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 2.1.2
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 863
X-purgate-ID: 151667::1415716399-00001FC1-8734D451/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44002
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

Fix incorrect cast that always results in wrong address for the new
frame on 64-bit kernels.

Cc: stable@vger.kernel.org
Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/oprofile/backtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/oprofile/backtrace.c b/arch/mips/oprofile/backtrace.c
index 6854ed5..83a1dfd 100644
--- a/arch/mips/oprofile/backtrace.c
+++ b/arch/mips/oprofile/backtrace.c
@@ -92,7 +92,7 @@ static inline int unwind_user_frame(struct stackframe *old_frame,
 				/* This marks the end of the previous function,
 				   which means we overran. */
 				break;
-			stack_size = (unsigned) stack_adjustment;
+			stack_size = (unsigned long) stack_adjustment;
 		} else if (is_ra_save_ins(&ip)) {
 			int ra_slot = ip.i_format.simmediate;
 			if (ra_slot < 0)
-- 
2.1.2
