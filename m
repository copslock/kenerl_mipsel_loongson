Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2008 21:18:14 +0100 (BST)
Received: from courier.cs.helsinki.fi ([128.214.9.1]:28358 "EHLO
	mail.cs.helsinki.fi") by ftp.linux-mips.org with ESMTP
	id S28574748AbYDSUSL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 Apr 2008 21:18:11 +0100
Received: from wrl-59.cs.helsinki.fi (wrl-59.cs.helsinki.fi [128.214.166.179])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Sat, 19 Apr 2008 23:17:31 +0300
  id 0006812C.480A535B.00006A9F
Received: by wrl-59.cs.helsinki.fi (Postfix, from userid 50795)
	id 80CBFA0092; Sat, 19 Apr 2008 23:16:36 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by wrl-59.cs.helsinki.fi (Postfix) with ESMTP id 6F5B5A006C;
	Sat, 19 Apr 2008 23:16:36 +0300 (EEST)
Date:	Sat, 19 Apr 2008 23:16:36 +0300 (EEST)
From:	"=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@wrl-59.cs.helsinki.fi
To:	ralf@linux-mips.org
cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] Fix order of BRK_BUG in case
Message-ID: <Pine.LNX.4.64.0804192310460.20623@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696208474-35109629-1208636196=:20623"
Return-Path: <ilpo.jarvinen@helsinki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilpo.jarvinen@helsinki.fi
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-35109629-1208636196=:20623
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


BRK bug is defined as 512, which is smaller than 1 << 10
resulting in left shifting bcode by 10 earlier. Without
this the code block can't ever be reached.

Problem was added in commit 63dc68a8cf ([MIPS] Use conditional
traps for BUG_ON on MIPS II and better).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---

I'm by no means familiar with MIPS but this seems
an appropriate fix.

 arch/mips/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 984c0d0..4dfcd61 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -694,7 +694,7 @@ asmlinkage void do_bp(struct pt_regs *regs)
 		info.si_addr = (void __user *) regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
-	case BRK_BUG:
+	case BRK_BUG << 10:
 		die("Kernel bug detected", regs);
 		break;
 	default:
-- 
1.5.4.4

---696208474-35109629-1208636196=:20623--
