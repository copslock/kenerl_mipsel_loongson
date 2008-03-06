Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 09:58:08 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:1159 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603241AbYCFJ5l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:41 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 07D86341E1;
	Thu,  6 Mar 2008 18:57:32 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id A4B1950687; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094759.405831871@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:43 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 06/12] kexec-tools: mipsel: Remove unused variables from elf_mipsel_load
Content-Disposition: inline; filename=mips-elf_mipsel_load-unused-variables.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-elf-mipsel.c |    2 --
 1 file changed, 2 deletions(-)

Index: kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:17:47.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 19:17:49.000000000 +0900
@@ -116,9 +116,7 @@ int elf_mipsel_load(int argc, char **arg
 	int command_line_len;
 	unsigned char *setup_start;
 	uint32_t setup_size;
-	int result;
 	int opt;
-	int i;
 #define OPT_APPEND     (OPT_ARCH_MAX+0)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS

-- 

-- 
Horms
