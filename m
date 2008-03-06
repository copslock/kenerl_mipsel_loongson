Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 10:00:35 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:9863 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603258AbYCFJ5s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:48 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id BA01E341F5;
	Thu,  6 Mar 2008 18:57:32 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id BD1A950773; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094800.249412632@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:47 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 10/12] kexec-tools: mipsel: Fit elf_mipsel_usage() into 80 columns
Content-Disposition: inline; filename=elf_mipsel_usage-80col.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-elf-mipsel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-05 11:12:44.000000000 +0900
+++ kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-05 11:18:34.000000000 +0900
@@ -97,10 +97,10 @@ int elf_mipsel_probe(const char *buf, of
 
 void elf_mipsel_usage(void)
 {
-	printf
-	    (
-	     "    --command-line=STRING Set the kernel command line to STRING.  \n"
-	     "    --append=STRING       Set the kernel command line to STRING.  \n");
+	printf("    --command-line=STRING Set the kernel command line to "
+			"STRING.\n"
+	       "    --append=STRING       Set the kernel command line to "
+			"STRING.\n");
 }
 
 int elf_mipsel_load(int argc, char **argv, const char *buf, off_t len,

-- 

-- 
Horms
