Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Feb 2007 21:13:56 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45971 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576304AbXBXVNw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Feb 2007 21:13:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1OLDnAN013618;
	Sat, 24 Feb 2007 21:13:49 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1OLDmUP013617;
	Sat, 24 Feb 2007 21:13:48 GMT
Date:	Sat, 24 Feb 2007 21:13:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building 2.6.20.1 from source
Message-ID: <20070224211348.GB12637@linux-mips.org>
References: <45E0A57F.4020304@jg555.com> <20070224205850.GA12637@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070224205850.GA12637@linux-mips.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 24, 2007 at 08:58:50PM +0000, Ralf Baechle wrote:

Guess I should have eyeballed the error message for a few extra nanoseconds,
my answer wasn't quite right.  Enabling the binary compat options would
fix the build but leave the native N64 broken.  Below the fix.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 10e9a18..e569b84 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -470,4 +470,4 @@ sys_call_table:
 	PTR	sys_get_robust_list
 	PTR	sys_kexec_load			/* 5270 */
 	PTR	sys_getcpu
-	PTR	compat_sys_epoll_pwait
+	PTR	sys_epoll_pwait
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index c5f590c..bcc4248 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -518,5 +518,5 @@ sys_call_table:
 	PTR	compat_sys_get_robust_list	/* 4310 */
 	PTR	compat_sys_kexec_load
 	PTR	sys_getcpu
-	PTR	sys_epoll_pwait
+	PTR	compat_sys_epoll_pwait
 	.size	sys_call_table,.-sys_call_table
