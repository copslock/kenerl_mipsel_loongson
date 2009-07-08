Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 08:08:32 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:59305 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492357AbZGHGIZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2009 08:08:25 +0200
Received: by pzk3 with SMTP id 3so4733328pzk.22
        for <multiple recipients>; Tue, 07 Jul 2009 23:08:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=p3KniJ4YVUaQfKxE3clVBJiwxrIykGdRnX1uC2NwrLI=;
        b=fEgODQ/CPy3qtc+kczqS8dxKSRXMw0IFuG7UM66W35S505/5+Ou/U1CXZGKq3xi6XU
         mVfRS0mdmRZtetnOG4kDEQCY4cP9P/etDCuQM+vLd034RXLS7bcs/uoVCtjSDa9YvRyn
         I3DZS/f/m/qIRiL9fG9svV9rA+4XgI3saepcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=pge3PwNH84wXbxHZBCeGZsUIb4Lk3B9Odb6eh97FV6xmjptSVK94mcGbDxW50rw5NN
         K1BKnKOqEWZ7mtB1t9eUl6frED3/k2fpiFEKGLpZMchxR+MlmnDUtMSfqS1zZ/I/GH2X
         PizSaQF3qYt6+rPcDcSe01/gdDlYFZBxQEykM=
Received: by 10.143.31.4 with SMTP id i4mr1601501wfj.124.1247033298450;
        Tue, 07 Jul 2009 23:08:18 -0700 (PDT)
Received: from delta (207.5.30.125.dy.iij4u.or.jp [125.30.5.207])
        by mx.google.com with ESMTPS id 30sm5100385wfg.10.2009.07.07.23.08.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 23:08:17 -0700 (PDT)
Date:	Wed, 8 Jul 2009 15:08:19 +0900
From:	Yoichi Yuasa <yuasa@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH[MIPS] fix unbalance brace in mipssim get_c0_compare_int()
Message-Id: <20090708150819.92fb1f86.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips


cc1: warnings being treated as errors
arch/mips/mipssim/sim_time.c: In function 'get_c0_compare_int':
arch/mips/mipssim/sim_time.c:103: warning: ISO C90 forbids mixed declarations and code
arch/mips/mipssim/sim_time.c:116: error: expected declaration or statement at end of input
make[1]: *** [arch/mips/mipssim/sim_time.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

diff --git a/arch/mips/mipssim/sim_time.c b/arch/mips/mipssim/sim_time.c
index 0cea932..5492c42 100644
--- a/arch/mips/mipssim/sim_time.c
+++ b/arch/mips/mipssim/sim_time.c
@@ -89,13 +89,13 @@ unsigned __cpuinit get_c0_compare_int(void)
 	if (cpu_has_veic) {
 		set_vi_handler(MSC01E_INT_CPUCTR, mips_timer_dispatch);
 		mips_cpu_timer_irq = MSC01E_INT_BASE + MSC01E_INT_CPUCTR;
-	} else {
-#endif
-	       {
-		if (cpu_has_vint)
-			set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
-		mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+
+		return mips_cpu_timer_irq;
 	}
+#endif
+	if (cpu_has_vint)
+		set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
+	mips_cpu_timer_irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 
 	return mips_cpu_timer_irq;
 }
