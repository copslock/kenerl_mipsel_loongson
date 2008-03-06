Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 10:00:10 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:10887 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603254AbYCFJ5s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:48 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id CC5FC341FA;
	Thu,  6 Mar 2008 18:57:32 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id C3E4A5077B; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094800.531036774@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:48 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 11/12] kexec-tools: mipsel: Fit elf_mipsel_load() into 80 columns
Content-Disposition: inline; filename=elf_mipsel_load-80col.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-elf-mipsel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-05 11:44:06.000000000 +0900
+++ kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-05 11:44:06.000000000 +0900
@@ -128,7 +128,8 @@ int elf_mipsel_load(int argc, char **arg
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
 
 	command_line = 0;
-	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+	while ((opt = getopt_long(argc, argv, short_options,
+				  options, 0)) != -1) {
 		switch (opt) {
 		default:
 			/* Ignore core options */

-- 

-- 
Horms
