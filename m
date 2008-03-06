Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 09:58:57 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:1671 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603246AbYCFJ5l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:41 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 51EA5341E4;
	Thu,  6 Mar 2008 18:57:31 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id 8F77A4F8B5; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094758.980350354@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:41 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 04/12] kexec-tools: mipsel: Remove duplication declaration of BOOTLOADER_VERSION
Content-Disposition: inline; filename=mips-duplicate-BOOTLOADER_VERSION.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

BOOTLOADER_VERSION is defined in kexec.h

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-elf-mipsel.c |    1 -
 1 file changed, 1 deletion(-)

Index: kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:15:41.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:18:10.000000000 +0900
@@ -32,7 +32,6 @@
 static const int probe_debug = 0;
 
 #define BOOTLOADER         "kexec"
-#define BOOTLOADER_VERSION VERSION
 #define MAX_COMMAND_LINE   256
 
 #define UPSZ(X) ((sizeof(X) + 3) & ~3)

-- 

-- 
Horms
