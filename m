Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 10:27:01 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:60427 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1492370AbZJTI0y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2009 10:26:54 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id C15E7274005; Tue, 20 Oct 2009 10:26:53 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id CD0FD274004
	for <linux-mips@linux-mips.org>; Tue, 20 Oct 2009 10:26:52 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 1A45A82855
	for <linux-mips@linux-mips.org>; Tue, 20 Oct 2009 10:37:37 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 5D0F4FF855
	for <linux-mips@linux-mips.org>; Tue, 20 Oct 2009 10:27:47 +0200 (CEST)
From:	Arnaud Patard <apatard@mandriva.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix ppoll on o32 with 64bit kernel
Organization: Mandriva
Date:	Tue, 20 Oct 2009 10:27:47 +0200
Message-ID: <m363aa8o70.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

--=-=-=


sys_ppoll syscall needs to use a compat handler on 64bit kernels with
o32 user-space. This patch wires it.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=ppoll_fix.patch

---
 arch/mips/kernel/scall64-o32.S |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.24/arch/mips/kernel/scall64-o32.S
===================================================================
--- linux-2.6.24.orig/arch/mips/kernel/scall64-o32.S	2008-07-07 17:49:07.000000000 +0200
+++ linux-2.6.24/arch/mips/kernel/scall64-o32.S	2008-07-07 19:27:42.000000000 +0200
@@ -507,7 +507,7 @@ sys_call_table:
 	PTR	sys_fchmodat
 	PTR	sys_faccessat			/* 4300 */
 	PTR	compat_sys_pselect6
-	PTR	sys_ppoll
+	PTR	compat_sys_ppoll
 	PTR	sys_unshare
 	PTR	sys_splice
 	PTR	sys32_sync_file_range		/* 4305 */

--=-=-=--
