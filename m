Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 16:45:08 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:42118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994689AbeBTPpAuX01a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 16:45:00 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B3521785;
        Tue, 20 Feb 2018 15:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B3521785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     Peter Mamonov <pmamonov@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: [PATCH v2] MIPS: Drop spurious __unused in struct compat_flock
Date:   Tue, 20 Feb 2018 15:44:37 +0000
Message-Id: <20180220154437.8293-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

MIPS' struct compat_flock doesn't match the 32-bit struct flock, as it
has an extra short __unused before pad[4], which combined with alignment
increases the size to 40 bytes compared with struct flock's 36 bytes.

Since commit 8c6657cb50cb ("Switch flock copyin/copyout primitives to
copy_{from,to}_user()"), put_compat_flock() writes the full compat_flock
struct to userland, which results in corruption of the userland word
after the struct flock when running 32-bit userlands on 64-bit kernels.

This was observed to cause a bus error exception when starting Firefox
on Debian 8 (Jessie).

Reported-by: Peter Mamonov <pmamonov@gmail.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Tested-by: Peter Mamonov <pmamonov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.13+
---
Resend mainly so it lands in patchwork.
---
 arch/mips/include/asm/compat.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 946681db8dc3..9a0fa66b81ac 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -86,7 +86,6 @@ struct compat_flock {
 	compat_off_t	l_len;
 	s32		l_sysid;
 	compat_pid_t	l_pid;
-	short		__unused;
 	s32		pad[4];
 };
 
-- 
2.13.6
