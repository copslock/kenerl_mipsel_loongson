Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 16:08:40 +0000 (GMT)
Received: from p549F72FE.dip.t-dialin.net ([84.159.114.254]:33981 "EHLO
	p549F72FE.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20040600AbXAJQI1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 16:08:27 +0000
Received: from mail.codesourcery.com ([65.74.133.4]:65249 "EHLO
	mail.codesourcery.com") by lappi.linux-mips.net with ESMTP
	id S136598AbXAJMay (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 13:30:54 +0100
Received: (qmail 27833 invoked from network); 10 Jan 2007 12:30:51 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 10 Jan 2007 12:30:51 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.63)
	(envelope-from <joseph@codesourcery.com>)
	id 1H4cbS-0001si-R0
	for linux-mips@linux-mips.org; Wed, 10 Jan 2007 12:30:50 +0000
Date:	Wed, 10 Jan 2007 12:30:50 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	linux-mips@linux-mips.org
Subject: [PATCH] Use compat_sys_pselect6
Message-ID: <Pine.LNX.4.64.0701101228450.6217@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

The N32 and O32 pselect6 syscalls need to use compat_sys_pselect6 to
translate arguments from 32-bit to 64-bit layout.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
diff -rupN linux-2.6.19.orig/arch/mips/kernel/scall64-n32.S linux-2.6.19/arch/mips/kernel/scall64-n32.S
--- linux-2.6.19.orig/arch/mips/kernel/scall64-n32.S	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/arch/mips/kernel/scall64-n32.S	2007-01-10 00:17:13.000000000 +0000
@@ -384,7 +384,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_readlinkat
 	PTR	sys_fchmodat
 	PTR	sys_faccessat
-	PTR	sys_pselect6
+	PTR	compat_sys_pselect6
 	PTR	sys_ppoll			/* 6265 */
 	PTR	sys_unshare
 	PTR	sys_splice
diff -rupN linux-2.6.19.orig/arch/mips/kernel/scall64-o32.S linux-2.6.19/arch/mips/kernel/scall64-o32.S
--- linux-2.6.19.orig/arch/mips/kernel/scall64-o32.S	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/arch/mips/kernel/scall64-o32.S	2007-01-10 00:16:26.000000000 +0000
@@ -506,7 +506,7 @@ sys_call_table:
 	PTR	sys_readlinkat
 	PTR	sys_fchmodat
 	PTR	sys_faccessat			/* 4300 */
-	PTR	sys_pselect6
+	PTR	compat_sys_pselect6
 	PTR	sys_ppoll
 	PTR	sys_unshare
 	PTR	sys_splice

-- 
Joseph S. Myers
joseph@codesourcery.com
