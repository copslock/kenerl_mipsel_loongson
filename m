Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 23:04:05 +0100 (BST)
Received: from courier.cs.helsinki.fi ([128.214.9.1]:25547 "EHLO
	mail.cs.helsinki.fi") by ftp.linux-mips.org with ESMTP
	id S20021863AbXHOWED (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Aug 2007 23:04:03 +0100
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Thu, 16 Aug 2007 01:03:01 +0300
  id 0005FEAB.46C37815.000007CF
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id E4B87EBAEC; Thu, 16 Aug 2007 01:03:01 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id E3DB8EBAEB;
	Thu, 16 Aug 2007 01:03:01 +0300 (EEST)
Date:	Thu, 16 Aug 2007 01:03:01 +0300 (EEST)
From:	"=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
To:	ralf@linux-mips.org
cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] Invalid semicolon after if statement
Message-ID: <Pine.LNX.4.64.0708151535000.15670@kivilampi-30.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="-696243703-794861512-1187185396=:15670"
Content-ID: <Pine.LNX.4.64.0708160102120.21858@kivilampi-30.cs.helsinki.fi>
Return-Path: <ilpo.jarvinen@helsinki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilpo.jarvinen@helsinki.fi
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-794861512-1187185396=:15670
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0708151645241.15670@kivilampi-30.cs.helsinki.fi>


A similar fix to netfilter from Eric Dumazet inspired me to
look around a bit by using some grep/sed stuff as looking for
this kind of bugs seemed easy to automate. This is one of them
I found where it looks like this semicolon is not valid.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---

...Since I'm not familiar with these parts of the kernel, you might know 
better than I do if this is stuff is valid...

 arch/mips/kernel/irixsig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
index 6980deb..28b2a8f 100644
--- a/arch/mips/kernel/irixsig.c
+++ b/arch/mips/kernel/irixsig.c
@@ -725,7 +725,7 @@ asmlinkage int irix_getcontext(struct pt_regs *regs)
 	       current->comm, current->pid, ctx);
 #endif
 
-	if (!access_ok(VERIFY_WRITE, ctx, sizeof(*ctx)));
+	if (!access_ok(VERIFY_WRITE, ctx, sizeof(*ctx)))
 		return -EFAULT;
 
 	error = __put_user(current->thread.irix_oldctx, &ctx->link);
-- 
1.5.0.6
---696243703-794861512-1187185396=:15670--
