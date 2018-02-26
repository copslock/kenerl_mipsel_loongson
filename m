Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2018 21:27:38 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeBZU1a6nK4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Feb 2018 21:27:30 +0100
Received: from localhost (clnet-b04-243.ikbnet.co.at [83.175.124.243])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54F62E4B;
        Mon, 26 Feb 2018 20:27:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Mamonov <pmamonov@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mips@linux-mips.org
Subject: [PATCH 4.15 07/64] MIPS: Drop spurious __unused in struct compat_flock
Date:   Mon, 26 Feb 2018 21:21:44 +0100
Message-Id: <20180226202153.748429368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 6ae1756faddefd7494353380ee546dd38c2f97eb upstream.

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
Patchwork: https://patchwork.linux-mips.org/patch/18646/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/compat.h |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -86,7 +86,6 @@ struct compat_flock {
 	compat_off_t	l_len;
 	s32		l_sysid;
 	compat_pid_t	l_pid;
-	short		__unused;
 	s32		pad[4];
 };
 
