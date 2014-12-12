Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 07:16:58 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57688 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006781AbaLLGQ4Me010 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 07:16:56 +0100
Received: from [2001:470:1f08:1539:c97:8151:cc89:c28d] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1XzJX1-0003ef-GH; Fri, 12 Dec 2014 06:16:51 +0000
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1XzJWw-0004Xg-Cx; Fri, 12 Dec 2014 06:16:46 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Aaro Koskinen" <aaro.koskinen@nsn.com>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date:   Fri, 12 Dec 2014 06:14:25 +0000
Message-ID: <lsq.1418364865.138129171@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 142/164] MIPS: oprofile: Fix backtrace on 64-bit kernel
In-Reply-To: <lsq.1418364865.554543691@decadent.org.uk>
X-SA-Exim-Connect-IP: 2001:470:1f08:1539:c97:8151:cc89:c28d
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@nsn.com>

commit bbaf113a481b6ce32444c125807ad3618643ce57 upstream.

Fix incorrect cast that always results in wrong address for the new
frame on 64-bit kernels.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8110/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/oprofile/backtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/oprofile/backtrace.c
+++ b/arch/mips/oprofile/backtrace.c
@@ -92,7 +92,7 @@ static inline int unwind_user_frame(stru
 				/* This marks the end of the previous function,
 				   which means we overran. */
 				break;
-			stack_size = (unsigned) stack_adjustment;
+			stack_size = (unsigned long) stack_adjustment;
 		} else if (is_ra_save_ins(&ip)) {
 			int ra_slot = ip.i_format.simmediate;
 			if (ra_slot < 0)
