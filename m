Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:24:40 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:58459 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491929Ab0ELNYM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:24:12 +0200
Received: by pvc30 with SMTP id 30so40862pvc.36
        for <multiple recipients>; Wed, 12 May 2010 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=OXlyUj49EO2pBkuow6vJXRWkmMi9OGFwxKGGZcgnjZc=;
        b=bHO/CXCzOK17cQoHF4wKeJdKfJ5idmaFMlpH3zSMnB3nRR2jNQroIIyOm0x2adoVXX
         Cnbrf7LhM5cKBs7VzbYvUEdFEFy+PgA9cdvKfLyIJp/P6LGE6b2lnxd34ffFylH+AfTu
         3mZMzsCCayi09NKlPV3PRUWK5mQywbja09Gpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ssm4AFBdYtwFRve59vv5hrnWNAg5FYm3JKjOT5Jj1ghVB1jVExEHF0Tbsfgl9pNnr4
         sJeCpHj3d8Ndv1TakFh5iiOYpHphhPANNbSU6QatkyJWrK1tgBD97JZYpj9Aas8wyZEn
         IlmXL3r6YACYbvbs2v/7IFYo7YY/FWHW+v0ac=
Received: by 10.114.7.35 with SMTP id 35mr5861351wag.4.1273670639259;
        Wed, 12 May 2010 06:23:59 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.23.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:23:58 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/9] tracing: MIPS: mcount.S: Fixup of the 32bit support with gcc 4.5
Date:   Wed, 12 May 2010 21:23:10 +0800
Message-Id: <fd8a13e37a33c1075da184f4fe92b0d9afc51c09.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As the doc[1] of gcc-4.5 shows, the -mmcount-ra-address uses register
$12 to transfer the stack offset of the return address to the _mcount
function. in 64bit kernel, $12 is t0, but in 32bit kernel, it is t4, so,
we need to use $12 instead of t0 here to cover the 64bit and 32bit
support.

[1] Gcc doc: MIPS Options
http://gcc.gnu.org/onlinedocs/gcc/MIPS-Options.html

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index e256bf9..92d1540 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -69,7 +69,7 @@ _mcount:
 
 	MCOUNT_SAVE_REGS
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_S	t0, PT_R12(sp)	/* t0 saved the location of the return address(at) by -mmcount-ra-address */
+	PTR_S	$12, PT_R12(sp)	/* $12 saved the location of the return address(at) by -mmcount-ra-address */
 #endif
 
 	move	a0, ra		/* arg1: next ip, selfaddr */
@@ -135,7 +135,7 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 #ifdef CONFIG_DYNAMIC_FTRACE
 	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_L	t0, PT_R12(sp)	/* load the original t0 from the stack */
+	PTR_L	$12, PT_R12(sp)	/* load the original $12 from the stack */
 #endif
 #else
 	MCOUNT_SAVE_REGS
@@ -143,10 +143,10 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 #endif
 
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	bnez	t0, 1f		/* non-leaf func: t0 saved the location of the return address */
+	bnez	$12, 1f		/* non-leaf func: $12 saved the location of the return address */
 	 nop
-	PTR_LA	t0, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
-1:	move	a0, t0		/* arg1: the location of the return address */
+	PTR_LA	$12, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
+1:	move	a0, $12		/* arg1: the location of the return address */
 #else
 	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
 #endif
-- 
1.7.0.4
