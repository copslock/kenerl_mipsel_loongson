Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 09:59:46 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:10119 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603253AbYCFJ5s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:48 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 6AF3C341EB;
	Thu,  6 Mar 2008 18:57:31 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id AA8AF506A8; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094759.628025769@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:44 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 07/12] kexec-tools: mipsel: Remove unused variables in arch_process_options()
Content-Disposition: inline; filename=mips-arch_process_options-unused-values.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-mipsel.c |    2 --
 1 file changed, 2 deletions(-)

Index: kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.c
===================================================================
--- kexec-tools-mips.orig/kexec/arch/mipsel/kexec-mipsel.c	2008-02-27 19:14:03.000000000 +0900
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.c	2008-02-27 19:18:15.000000000 +0900
@@ -111,8 +111,6 @@ int arch_process_options(int argc, char 
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR;
 	int opt;
-	unsigned long value;
-	char *end;
 
 	opterr = 0; /* Don't complain about unrecognized options here */
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {

-- 

-- 
Horms
