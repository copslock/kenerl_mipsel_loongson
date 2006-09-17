Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2006 20:30:55 +0100 (BST)
Received: from gateway.codesourcery.com ([65.74.133.9]:17067 "EHLO
	gateway.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20027647AbWIQTay (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Sep 2006 20:30:54 +0100
Received: (qmail 26659 invoked by uid 1010); 17 Sep 2006 19:30:46 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	linux-mips@linux-mips.org
Mail-Followup-To: linux-mips@linux-mips.org, richard@codesourcery.com
Subject: [PATCH] The o32 fstatat syscall behaves differently on 32 and 64 bit kernels
Date:	Sun, 17 Sep 2006 20:30:46 +0100
Message-ID: <87bqpexpcp.fsf@talisman.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

While working on a glibc patch to support the fstatat() functions[1],
I noticed that the o32 implementation behaves differently on 32-bit and
64-bit kernels; the former provides a stat64 while the latter provides
a plain (o32) stat.  I think the former is what's intended, as there is
no separate fstatat64.  It's also what x86 does.

I think this is just a case of a compat too far.  The o32 stat64 is the
same as plain stat on n64, so 64-bit kernels can just use newfstatat.
(n32 already does this, and works correctly as-is.)

Tested with the glibc patch, where it fixes the test I'd written.
Please install if OK.

Richard

[1] I've seen Khem's patch, but I don't think it's right.

Signed-off-by: Richard Sandiford <richard@codesourcery.com>

diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 2ac0141..288ee4a 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -498,7 +498,7 @@ sys_call_table:
 	PTR	sys_mknodat			/* 4290 */
 	PTR	sys_fchownat
 	PTR	compat_sys_futimesat
-	PTR	compat_sys_newfstatat
+	PTR	sys_newfstatat
 	PTR	sys_unlinkat
 	PTR	sys_renameat			/* 4295 */
 	PTR	sys_linkat
