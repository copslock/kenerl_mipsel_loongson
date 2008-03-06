Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 10:01:00 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:11143 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603260AbYCFJ5s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:48 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id D4389341FB;
	Thu,  6 Mar 2008 18:57:32 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id C9C84507E9; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094800.680153069@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:49 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 12/12] kexec-tools: mipsel: Define OPT_APPEND outside of any function
Content-Disposition: inline; filename=mipsel-opt-defines-outside-of-function.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18348
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
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-06 18:39:51.000000000 +0900
+++ kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-06 18:39:51.000000000 +0900
@@ -70,6 +70,8 @@ static struct boot_notes {
 };
 
 
+#define OPT_APPEND	(OPT_ARCH_MAX+0)
+
 int elf_mipsel_probe(const char *buf, off_t len)
 {
 
@@ -117,7 +119,6 @@ int elf_mipsel_load(int argc, char **arg
 	unsigned char *setup_start;
 	uint32_t setup_size;
 	int opt;
-#define OPT_APPEND     (OPT_ARCH_MAX+0)
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{"command-line", 1, 0, OPT_APPEND},

-- 

-- 
Horms
