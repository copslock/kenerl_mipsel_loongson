Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2008 19:51:03 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.185]:49076 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S62071266AbYIOSvA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Sep 2008 19:51:00 +0100
Received: by gv-out-0910.google.com with SMTP id e6so1148266gvc.2
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2008 11:50:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=lKsFSykpp82vOAJ9rPrK9JRi/tkubwna8AwYR7Wp9PI=;
        b=fFSrp7LO0qMGC8Sxe9cSKzSNebeDkHhKTC4ew3+PIrRAUMj+95xrJInTRinDodyGNr
         NrBrugtSWJ6wttz1FY02SNugJ2LGFE7Jv0UCLQuKRml3+ciQ5gPtaLmK2jnZ4g6YBbst
         4uJjWQ6fFutetWudbyNkoFo21zaDUYzqukqBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=dR5hjdimv55hbMBiOug4D0t8yM9sV//90N+6nOG7t0tuQxN0ISr9bDTC3wE2eaH86l
         3nlUNX6+sTrOiaPM6AuEiHnXAqPYYFmf4Gk2Zth9AWo/KoMAzZsYSy/L9oRijE0uyqAo
         +hrhYz8DYtRNGPJKS3SegV5eiIkx6SAu+kDD8=
Received: by 10.187.194.7 with SMTP id w7mr1128942fap.75.1221504659536;
        Mon, 15 Sep 2008 11:50:59 -0700 (PDT)
Received: from ?192.168.1.117? ( [213.46.133.62])
        by mx.google.com with ESMTPS id f6sm42539837nfh.12.2008.09.15.11.50.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 11:50:58 -0700 (PDT)
Message-ID: <48CF02EE.8050406@gmail.com>
Date:	Mon, 15 Sep 2008 20:50:54 -0400
From:	roel kluin <roel.kluin@gmail.com>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To:	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [MIPS] vr41xx: unsigned irq cannot be negative
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

unsigned irq cannot be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/mips/vr41xx/common/irq.c b/arch/mips/vr41xx/common/irq.c
index cba36a2..92dd1a0 100644
--- a/arch/mips/vr41xx/common/irq.c
+++ b/arch/mips/vr41xx/common/irq.c
@@ -72,6 +72,7 @@ static void irq_dispatch(unsigned int irq)
 	cascade = irq_cascade + irq;
 	if (cascade->get_irq != NULL) {
 		unsigned int source_irq = irq;
+		int ret;
 		desc = irq_desc + source_irq;
 		if (desc->chip->mask_ack)
 			desc->chip->mask_ack(source_irq);
@@ -79,8 +80,9 @@ static void irq_dispatch(unsigned int irq)
 			desc->chip->mask(source_irq);
 			desc->chip->ack(source_irq);
 		}
-		irq = cascade->get_irq(irq);
-		if (irq < 0)
+		ret = cascade->get_irq(irq);
+		irq = ret;
+		if (ret < 0)
 			atomic_inc(&irq_err_count);
 		else
 			irq_dispatch(irq);
