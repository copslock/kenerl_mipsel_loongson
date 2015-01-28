Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2015 05:26:25 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008709AbbA1E0XyJLUw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jan 2015 05:26:23 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 124F2202E9;
        Wed, 28 Jan 2015 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [183.247.163.231])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACAD2035B;
        Wed, 28 Jan 2015 04:26:16 +0000 (UTC)
From:   lizf@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nsn.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 169/177] MIPS: oprofile: Fix backtrace on 64-bit kernel
Date:   Wed, 28 Jan 2015 12:10:27 +0800
Message-Id: <1422418236-12852-260-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1422418050-12581-1-git-send-email-lizf@kernel.org>
References: <1422418050-12581-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

From: Aaro Koskinen <aaro.koskinen@nsn.com>

3.4.106-rc1 review patch.  If anyone has any objections, please let me know.

------------------


commit bbaf113a481b6ce32444c125807ad3618643ce57 upstream.

Fix incorrect cast that always results in wrong address for the new
frame on 64-bit kernels.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8110/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
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
1.9.1
