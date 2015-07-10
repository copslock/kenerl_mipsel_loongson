Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:03:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58929 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009964AbbGJPDQAasep (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:03:16 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7024B6F6FB4E1;
        Fri, 10 Jul 2015 16:03:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:03:10 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:03:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <james.hogan@imgtec.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 08/16] MIPS: remove unused {get,put}_sigset functions
Date:   Fri, 10 Jul 2015 16:00:17 +0100
Message-ID: <1436540426-10021-9-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 48184
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

These functions are never called & thus dead code. Remove them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/signal32.c | 51 ---------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 2a7c6dd..3059f36 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -131,57 +131,6 @@ static int restore_sigcontext32(struct pt_regs *regs,
 }
 
 /*
- *
- */
-extern void __put_sigset_unknown_nsig(void);
-extern void __get_sigset_unknown_nsig(void);
-
-static inline int put_sigset(const sigset_t *kbuf, compat_sigset_t __user *ubuf)
-{
-	int err = 0;
-
-	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)))
-		return -EFAULT;
-
-	switch (_NSIG_WORDS) {
-	default:
-		__put_sigset_unknown_nsig();
-	case 2:
-		err |= __put_user(kbuf->sig[1] >> 32, &ubuf->sig[3]);
-		err |= __put_user(kbuf->sig[1] & 0xffffffff, &ubuf->sig[2]);
-	case 1:
-		err |= __put_user(kbuf->sig[0] >> 32, &ubuf->sig[1]);
-		err |= __put_user(kbuf->sig[0] & 0xffffffff, &ubuf->sig[0]);
-	}
-
-	return err;
-}
-
-static inline int get_sigset(sigset_t *kbuf, const compat_sigset_t __user *ubuf)
-{
-	int err = 0;
-	unsigned long sig[4];
-
-	if (!access_ok(VERIFY_READ, ubuf, sizeof(*ubuf)))
-		return -EFAULT;
-
-	switch (_NSIG_WORDS) {
-	default:
-		__get_sigset_unknown_nsig();
-	case 2:
-		err |= __get_user(sig[3], &ubuf->sig[3]);
-		err |= __get_user(sig[2], &ubuf->sig[2]);
-		kbuf->sig[1] = sig[2] | (sig[3] << 32);
-	case 1:
-		err |= __get_user(sig[1], &ubuf->sig[1]);
-		err |= __get_user(sig[0], &ubuf->sig[0]);
-		kbuf->sig[0] = sig[0] | (sig[1] << 32);
-	}
-
-	return err;
-}
-
-/*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 
-- 
2.4.4
