Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 22:23:27 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37032 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822682Ab3HAUWwzxNuz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Aug 2013 22:22:52 +0200
Received: by mail-ob0-f177.google.com with SMTP id f8so4774624obp.36
        for <multiple recipients>; Thu, 01 Aug 2013 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hEdVRPXlZZ9jURzVZZ/xEMcLX5W92k8KtTTVU/s26ho=;
        b=cfzWoMnqqYaU8i7xwZnA39UKsFnstCKDZUmITg4cpPVjh5q+KikWCaSEjh+EDn7x4C
         13Tg5cn8St8J00oRIlX7Qyl1xH9FOx4jztrxytfDrdkvV3iGDBCmYLnChdn+wIuf5yXc
         4iiyGSuWQQbDGB419S/QU67XckjGfcQD9gfnMpC+7K6VTYfQugRuoYuQOpxvP6c2TNhD
         786sCGo2hHtd9nYUvvNMjkhlrCU5ReZBjCTBdskEJCpWfe7dF3ftXl/tfPGB+ChB8NwI
         9pnRpi2Fhnw6iUYMrB7TK5JtJBrDpQanVh0lvJc3TH0GuFbYZOXA+ocXMtZfbm8hbWQL
         Dlng==
X-Received: by 10.182.181.73 with SMTP id du9mr2594808obc.106.1375388566620;
        Thu, 01 Aug 2013 13:22:46 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id jz7sm4700288obb.4.2013.08.01.13.22.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 13:22:45 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r71KMhaR004090;
        Thu, 1 Aug 2013 13:22:43 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r71KMhuN004089;
        Thu, 1 Aug 2013 13:22:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/3] mips/kvm: Cleanup .push/.pop directives in kvm_locore.S
Date:   Thu,  1 Aug 2013 13:22:34 -0700
Message-Id: <1375388555-4045-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <david.daney@cavium.com>

There are:
	.set	push
	.set	noreorder
	.set	noat
	 .
	 .
	 .
	.set	pop

Sequences all over the place in this file, but in some places the
final ".set pop" is erroneously converted to ".set push", so none of
these really do what they appear to.

Clean up the whole mess by moving ".set noreorder", ".set noat" to the
top, and get rid of everything else.

Generated object code is unchanged.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/kvm_locore.S | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index 2b4fdd1..fdc169d 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -55,12 +55,10 @@
  * a0: run
  * a1: vcpu
  */
-
-FEXPORT(__kvm_mips_vcpu_run)
-	.set	push
 	.set	noreorder
 	.set	noat
 
+FEXPORT(__kvm_mips_vcpu_run)
 	/* k0/k1 not being used in host kernel context */
 	addiu	k1, sp, -PT_SIZE
 	LONG_S	$0, PT_R0(k1)
@@ -229,15 +227,11 @@ FEXPORT(__kvm_mips_load_k0k1)
 
 	/* Jump to guest */
 	eret
-	.set	pop
 
 VECTOR(MIPSX(exception), unknown)
 /*
  * Find out what mode we came from and jump to the proper handler.
  */
-	.set	push
-	.set	noat
-	.set	noreorder
 	mtc0	k0, CP0_ERROREPC	#01: Save guest k0
 	ehb				#02:
 
@@ -248,7 +242,6 @@ VECTOR(MIPSX(exception), unknown)
 	addiu	k0, k0, 0x2000		#06: Exception handler is installed @ offset 0x2000
 	j	k0			#07: jump to the function
 	 nop				#08: branch delay slot
-	.set	push
 VECTOR_END(MIPSX(exceptionEnd))
 .end MIPSX(exception)
 
@@ -258,10 +251,6 @@ VECTOR_END(MIPSX(exceptionEnd))
  *
  */
 NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
-	.set	push
-	.set	noat
-	.set	noreorder
-
 	/* Get the VCPU pointer from DDTATA_LO */
 	mfc0	k1, CP0_DDATA_LO
 	addiu	k1, k1, VCPU_HOST_ARCH
@@ -583,7 +572,6 @@ __kvm_mips_return_to_host:
 	j       ra
 	 nop
 
-	.set    pop
 VECTOR_END(MIPSX(GuestExceptionEnd))
 .end MIPSX(GuestException)
 
-- 
1.7.11.7
