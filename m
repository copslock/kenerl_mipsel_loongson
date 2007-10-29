Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 15:03:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:14248 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574252AbXJ2PDA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 15:03:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TF2sja004184;
	Mon, 29 Oct 2007 15:02:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TF2XMQ004183;
	Mon, 29 Oct 2007 15:02:33 GMT
Date:	Mon, 29 Oct 2007 15:02:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix post-fence error
Message-ID: <20071029150233.GA4165@linux-mips.org>
References: <47228018.8020202@tiscali.nl> <472328C2.4000002@ru.mvista.com> <47232C2D.8010002@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47232C2D.8010002@tiscali.nl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 27, 2007 at 02:16:45PM +0200, Roel Kluin wrote:

> Sergei Shtylyov wrote:
> > 
> >    Could also add spaces between the operands and operators (like
> > above/below), while at it...
> > 
> like this?

Thanks. I didn't like the magic numbers in the code so I went for below
patch instead.

Cheers,

  Ralf

From: Ralf Baechle <ralf@linux-mips.org>

[MIPS] IRIX: Fix off-by-one error in signal compat code.

Based on original patch by Roel Kluin <12o3l@tiscali.nl>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
index a0a9105..5052f47 100644
--- a/arch/mips/kernel/irixsig.c
+++ b/arch/mips/kernel/irixsig.c
@@ -24,8 +24,12 @@
 
 #define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
 
+#define _IRIX_NSIG		128
+#define _IRIX_NSIG_BPW		BITS_PER_LONG
+#define _IRIX_NSIG_WORDS	(_IRIX_NSIG / _IRIX_NSIG_BPW)
+
 typedef struct {
-	unsigned long sig[4];
+	unsigned long sig[_IRIX_NSIG_WORDS];
 } irix_sigset_t;
 
 struct sigctx_irix5 {
@@ -527,7 +531,7 @@ asmlinkage int irix_sigpoll_sys(unsigned long __user *set,
 
 		expire = schedule_timeout_interruptible(expire);
 
-		for (i=0; i<=4; i++)
+		for (i=0; i < _IRIX_NSIG_BPW; i++)
 			tmp |= (current->pending.signal.sig[i] & kset.sig[i]);
 
 		if (tmp)
