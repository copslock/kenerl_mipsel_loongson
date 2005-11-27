Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Nov 2005 03:31:53 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:11168 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133767AbVK0Dbf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 27 Nov 2005 03:31:35 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1EgDJJ-0008Pd-G0; Sat, 26 Nov 2005 22:34:41 -0500
Date:	Sat, 26 Nov 2005 22:34:41 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Generate SIGILL again
Message-ID: <20051127033441.GA32180@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

The rdhwr emulation accidentally swallowed the SIGILL from most other
illegal instructions.  Make sure to return -EFAULT by default.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7f60f61..63db2fa 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -534,13 +534,14 @@ static inline int simulate_rdhwr(struct 
 		switch (rd) {
 			case 29:
 				regs->regs[rt] = ti->tp_value;
-				break;
+				return 0;
 			default:
 				return -EFAULT;
 		}
 	}
 
-	return 0;
+	/* Not ours.  */
+	return -EFAULT;
 }
 
 asmlinkage void do_ov(struct pt_regs *regs)

-- 
Daniel Jacobowitz
CodeSourcery, LLC
