Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 01:53:01 +0100 (CET)
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36906 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012564AbbKEAvtyjKIs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 01:51:49 +0100
Received: by wmll128 with SMTP id l128so290452wml.0;
        Wed, 04 Nov 2015 16:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p6/RjJPHR0aX88KyGhxoyLFqh1GbSbaMAglpRLB3gnM=;
        b=YiE8ovwp+HpdvttdRDvCbzeQTinJoDjyAi3zVSxX1bdLgszmqoVhCG3MLpICJP1C/i
         pjh+j08tXAUoCXWMhL3caYA+5TkzY7YmFivj70xtJ+qvKTENvNwWWkYJ4ATRY1cDzbYn
         veLVxZXuOErBWRFSO8cEhmdpVQ6Bqr3j3cN8ZV88hv2KpiWv8hJc76R2NrPE8zRv+Ol0
         lUpQQwtEYnJsN5q2lz1WfqLRQ3S7F34mIApaUJjQg7ztSSkL+Zu2Jf2Jfe5527L88JIK
         Cbd29oKOLzS7lO/aS8Nxzym5GK/q4fFFoGxlGL7zyJU3P5QcYIX3y96K/Re9cfKar0fM
         tOiQ==
X-Received: by 10.28.21.17 with SMTP id 17mr64929wmv.82.1446684704745;
        Wed, 04 Nov 2015 16:51:44 -0800 (PST)
Received: from amanieu-laptop.wireless.ropemaker.crm.lan ([31.205.92.76])
        by smtp.gmail.com with ESMTPSA id 194sm5558927wmh.19.2015.11.04.16.51.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Nov 2015 16:51:43 -0800 (PST)
From:   Amanieu d'Antras <amanieu@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 06/20] mips: Use generic copy_siginfo_{to,from}_user32
Date:   Thu,  5 Nov 2015 00:50:25 +0000
Message-Id: <1446684640-4112-7-git-send-email-amanieu@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
Return-Path: <amanieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amanieu@gmail.com
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

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 arch/mips/include/asm/compat.h |  3 --
 arch/mips/kernel/signal32.c    | 62 ------------------------------------------
 2 files changed, 65 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 29ca129..abc4fe4 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -132,9 +132,6 @@ typedef union compat_sigval {
 
 /* Can't use the generic version because si_code and si_errno are swapped */
 #define HAVE_ARCH_COMPAT_SIGINFO_T
-#define HAVE_ARCH_COPY_SIGINFO_TO_USER32
-#define HAVE_ARCH_COPY_SIGINFO_FROM_USER32
-#define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
 typedef struct compat_siginfo {
 	int si_signo;
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index f7e89524..b719aa3 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -181,68 +181,6 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
 	return ret;
 }
 
-int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
-{
-	int err;
-
-	if (!access_ok (VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
-		return -EFAULT;
-
-	/* If you change siginfo_t structure, please be sure
-	   this code is fixed accordingly.
-	   It should never copy any pad contained in the structure
-	   to avoid security leaks, but must copy the generic
-	   3 ints plus the relevant union member.
-	   This routine must convert siginfo from 64bit to 32bit as well
-	   at the same time.  */
-	err = __put_user(from->si_signo, &to->si_signo);
-	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user((short)from->si_code, &to->si_code);
-	if (from->si_code < 0)
-		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
-	else {
-		switch (from->si_code >> 16) {
-		case __SI_TIMER >> 16:
-			err |= __put_user(from->si_tid, &to->si_tid);
-			err |= __put_user(from->si_overrun, &to->si_overrun);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		case __SI_CHLD >> 16:
-			err |= __put_user(from->si_utime, &to->si_utime);
-			err |= __put_user(from->si_stime, &to->si_stime);
-			err |= __put_user(from->si_status, &to->si_status);
-		default:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			break;
-		case __SI_FAULT >> 16:
-			err |= __put_user((unsigned long)from->si_addr, &to->si_addr);
-			break;
-		case __SI_POLL >> 16:
-			err |= __put_user(from->si_band, &to->si_band);
-			err |= __put_user(from->si_fd, &to->si_fd);
-			break;
-		case __SI_RT >> 16: /* This is not generated by the kernel as of now.  */
-		case __SI_MESGQ >> 16:
-			err |= __put_user(from->si_pid, &to->si_pid);
-			err |= __put_user(from->si_uid, &to->si_uid);
-			err |= __put_user(from->si_int, &to->si_int);
-			break;
-		}
-	}
-	return err;
-}
-
-int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
-{
-	if (copy_from_user(to, from, 3*sizeof(int)) ||
-	    copy_from_user(to->_sifields._pad,
-			   from->_sifields._pad, SI_PAD_SIZE32))
-		return -EFAULT;
-
-	return 0;
-}
-
 asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 {
 	struct sigframe32 __user *frame;
-- 
2.6.2
