Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 14:05:09 +0000 (GMT)
Received: from rn-out-0910.google.com ([64.233.170.191]:37182 "EHLO
	rn-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22734536AbYJ3OE5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Oct 2008 14:04:57 +0000
Received: by rn-out-0910.google.com with SMTP id j66so413060rne.9
        for <linux-mips@linux-mips.org>; Thu, 30 Oct 2008 07:04:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :x-mailer:mime-version:content-type:content-transfer-encoding:sender
         :message-id;
        bh=/F3CbN5rWQc3pGLAozbrCrPxshuR8oNGD9TCwI8BpmY=;
        b=eUamERdjiQtaBCsPZQACeoR9jFnmqzLYV624YlLq1f6i3RZY0AAAHHPHQdrB+aC7u+
         HJUcPN8snO/cj7q4dETFIuC5+CGY6/oqYebjqU+N0YKLTmgAKnLpArU3KUoJljKXRy3f
         zo9OYlcDrFWWbcnSA1j8jwIPJLpF+faBLfxVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:x-mailer:mime-version:content-type
         :content-transfer-encoding:sender:message-id;
        b=Oj1LcMf1m2teRaQIGV66qMO87IVr6Y9dTcyGO66cl3DY4BJCuReVWQOx9SEH1ODVCU
         mX4mpAk/R2htIyhov8xPlr0o9Uj9fyGQuOUOiOzNtw4wZoLM4Ombztc82ubIiviaH9wb
         XXaefjPo4JN3FlAas27+/pEguPMLsaREljKkE=
Received: by 10.142.212.19 with SMTP id k19mr4701294wfg.155.1225375494207;
        Thu, 30 Oct 2008 07:04:54 -0700 (PDT)
Received: from delta (187.24.30.125.dy.iij4u.or.jp [125.30.24.187])
        by mx.google.com with ESMTPS id 28sm2852553wfd.4.2008.10.30.07.04.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 07:04:53 -0700 (PDT)
Date:	Thu, 30 Oct 2008 23:04:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix dsemul build error
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <4909bf05.1c048e0a.2c9d.fffffe74@mx.google.com>
Return-Path: <tripeaks@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


arch/mips/math-emu/dsemul.c: In function 'mips_dsemul':
arch/mips/math-emu/dsemul.c:96: error: 'BRK_MEMU' undeclared (first use in this function)
arch/mips/math-emu/dsemul.c:96: error: (Each undeclared identifier is reported only once
arch/mips/math-emu/dsemul.c:96: error: for each function it appears in.)
arch/mips/math-emu/dsemul.c: In function 'do_dsemulret':
arch/mips/math-emu/dsemul.c:138: error: 'BRK_MEMU' undeclared (first use in this function)
make[1]: *** [arch/mips/math-emu/dsemul.o] Error 1

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/include/asm/fpu_emulator.h linux/arch/mips/include/asm/fpu_emulator.h
--- linux-orig/arch/mips/include/asm/fpu_emulator.h	2008-10-30 09:49:14.369198923 +0900
+++ linux/arch/mips/include/asm/fpu_emulator.h	2008-10-30 11:37:39.871188124 +0900
@@ -23,6 +23,7 @@
 #ifndef _ASM_FPU_EMULATOR_H
 #define _ASM_FPU_EMULATOR_H
 
+#include <asm/break.h>
 #include <asm/inst.h>
 
 struct mips_fpu_emulator_stats {
