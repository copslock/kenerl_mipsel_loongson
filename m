Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 16:34:57 +0100 (BST)
Received: from frigate.technologeek.org ([IPv6:::ffff:62.4.21.148]:55938 "EHLO
	frigate.technologeek.org") by linux-mips.org with ESMTP
	id <S8224861AbTGAPev>; Tue, 1 Jul 2003 16:34:51 +0100
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 54F241C9140B; Tue,  1 Jul 2003 17:34:42 +0200 (CEST)
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH] Fix broken wd33c93.c
From: Julien BLACHE <jb@jblache.org>
Date: Tue, 01 Jul 2003 17:34:42 +0200
Message-ID: <87he66xnu5.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <jb@jblache.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jb@jblache.org
Precedence: bulk
X-list: linux-mips

--=-=-=

Hi,

The attached patch fixes the compilation of drivers/scsi/wd33c93.c
that is currently broken. Seems like the last merge removed the wrong
line.

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org> 


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=wd33c93.c.patch
Content-Description: Fix wd33c93.c

--- wd33c93.c.orig	2003-07-01 15:31:23.000000000 +0000
+++ wd33c93.c	2003-07-01 15:30:44.000000000 +0000
@@ -1920,7 +1920,7 @@
 
 	char *bp;
 	char tbuf[128];
-	struct Scsi_Host *instance;
+	struct WD33C93_hostdata *hd;
 	Scsi_Cmnd *cmd;
 	int x, i;
 	static int stop = 0;

--=-=-=--
