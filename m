Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 09:57:44 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:1927 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603216AbYCFJ5l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:41 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 37DBE341E2;
	Thu,  6 Mar 2008 18:57:32 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id B06C0506E4; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094759.828031235@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:45 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 08/12] kexec-tools: mipsel: Remove unused arch_options global variable
Content-Disposition: inline; filename=mips-unused-arch_options.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/mipsel/kexec-mipsel.c |    3 ---
 1 file changed, 3 deletions(-)

Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-mipsel.c	2008-03-05 11:27:43.000000000 +0900
+++ kexec-tools-testing-mips/kexec/arch/mipsel/kexec-mipsel.c	2008-03-05 11:27:46.000000000 +0900
@@ -100,9 +100,6 @@ void arch_usage(void)
 {
 }
 
-static struct {
-} arch_options = {
-};
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {

-- 

-- 
Horms
