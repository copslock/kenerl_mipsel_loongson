Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 15:26:37 +0200 (CEST)
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:47606 "EHLO
        ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491961Ab0FQN0W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 15:26:22 +0200
Received: from c83-249-211-213.bredband.comhem.se ([83.249.211.213]:49641 helo=honor.jni.nu)
        by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.68)
        (envelope-from <jesper@jni.nu>)
        id 1OPF6T-0007Ym-9I; Thu, 17 Jun 2010 15:25:59 +0200
Received: from honor.jni.nu (localhost [127.0.0.1])
        by honor.jni.nu (8.14.1/8.14.1) with ESMTP id o5HDPumR025000;
        Thu, 17 Jun 2010 15:25:56 +0200
Received: (from jesper@localhost)
        by honor.jni.nu (8.14.1/8.13.8/Submit) id o5HDPsM0024999;
        Thu, 17 Jun 2010 15:25:54 +0200
Date:   Thu, 17 Jun 2010 15:25:54 +0200
From:   Jesper Nilsson <jesper@jni.nu>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: MIPS: return after handling coprocessor 2 exception
Message-ID: <20100617132554.GB24162@jni.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
X-Originating-IP: 83.249.211.213
X-Scan-Result: No virus found in message 1OPF6T-0007Ym-9I.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1OPF6T-0007Ym-9I cfb3430c4e9b0e02823d802f44a78c9a
X-archive-position: 27159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper@jni.nu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12038

Breaking here dropped us to the default code which always sends
a SIGILL to the current process, no matter what the CU2 notifier says.

Signed-off-by: Jesper Nilsson <jesper@jni.nu>
---
 traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8bdd6a6..8527808 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -976,7 +976,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 
 	case 2:
 		raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
-		break;
+		return;
 
 	case 3:
 		break;

/^JN - Jesper Nilsson
--
                  Jesper Nilsson -- jesper_at_jni.nu
