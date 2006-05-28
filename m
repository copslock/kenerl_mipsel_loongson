Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2006 16:03:20 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:9378 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133446AbWE1ODM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2006 16:03:12 +0200
Received: from lagash (88-106-136-76.dynamic.dsl.as9105.com [88.106.136.76])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id CCEA544B32; Sun, 28 May 2006 16:03:11 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FkLr3-0000nC-Ql; Sun, 28 May 2006 15:02:53 +0100
Date:	Sun, 28 May 2006 15:02:53 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] open() forces O_LARGEFILE for o32 on 64bit kernels
Message-ID: <20060528140253.GA4256@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

open() always sets the O_LARGEFILE flag for the o32 ABI implementation
of a 64bit kernel. The appended patch fixes it.


Thiemo


--- a/arch/mips/kernel/scall64-o32.S	2006-04-24 12:02:26.000000000 +0100
+++ b/arch/mips/kernel/scall64-o32.S	2006-05-28 14:56:23.000000000 +0100
@@ -209,7 +209,7 @@ sys_call_table:
 	PTR	sys_fork
 	PTR	sys_read
 	PTR	sys_write
-	PTR	sys_open			/* 4005 */
+	PTR	compat_sys_open			/* 4005 */
 	PTR	sys_close
 	PTR	sys_waitpid
 	PTR	sys_creat
