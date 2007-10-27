Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2007 13:20:05 +0100 (BST)
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:5355 "EHLO
	smtp-out3.tiscali.nl") by ftp.linux-mips.org with ESMTP
	id S20029798AbXJ0MT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Oct 2007 13:19:56 +0100
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out3.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Ilkat-0004No-2L; Sat, 27 Oct 2007 14:16:47 +0200
Message-ID: <47232C2D.8010002@tiscali.nl>
Date:	Sat, 27 Oct 2007 14:16:45 +0200
From:	Roel Kluin <12o3l@tiscali.nl>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix post-fence error
References: <47228018.8020202@tiscali.nl> <472328C2.4000002@ru.mvista.com>
In-Reply-To: <472328C2.4000002@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <12o3l@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 12o3l@tiscali.nl
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> 
>    Could also add spaces between the operands and operators (like
> above/below), while at it...
> 
like this?
--
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
index a0a9105..11e74fe 100644
--- a/arch/mips/kernel/irixsig.c
+++ b/arch/mips/kernel/irixsig.c
@@ -527,7 +527,7 @@ asmlinkage int irix_sigpoll_sys(unsigned long __user *set,
 
 		expire = schedule_timeout_interruptible(expire);
 
-		for (i=0; i<=4; i++)
+		for (i = 0; i < 4; i++)
 			tmp |= (current->pending.signal.sig[i] & kset.sig[i]);
 
 		if (tmp)
