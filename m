Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Nov 2008 14:45:23 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.170]:10643 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S23988122AbYK2OpQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 29 Nov 2008 14:45:16 +0000
Received: by ug-out-1314.google.com with SMTP id k40so2291948ugc.2
        for <linux-mips@linux-mips.org>; Sat, 29 Nov 2008 06:45:13 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=NlMTtXDyEZlkaEaQb+s9hnZux9rYQ33ngRsG+90sdzg=;
        b=dIYAEyJBP/Sc5p3Iz3bkOB5CSgNRq2MQMwx9EskHn3MXdPOjbyV3ogEsS1Uujhpwin
         Lbv2SdHTse1tFEBLHAx/X54KymEqv1PYZ27xW0FF3SGTrrzYThpMa74HxatNRSVK7dJS
         GcJ5Ci5jUMgBXsEW8S5Ok5trs6QzEUTtr0QBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=T4zKDBUqBQxtjbaDsuQfmQmYfxlXOMgIDAYLjwdtGi3ZRYb+4ap6cXgIiBVIagc5LI
         lBNtT5iAz5tPl/3Ms4j3N1S8Xb96ORRcsTrT1TgW8Y868cTAW6uITDiqWLP/ydRsH0AQ
         KMS2IORDr+NaMFQpSKHQhcLhDzFaZVhIwVCu8=
Received: by 10.66.222.6 with SMTP id u6mr1767961ugg.19.1227969912888;
        Sat, 29 Nov 2008 06:45:12 -0800 (PST)
Received: from ?192.168.1.117? (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id o30sm3753272ugd.52.2008.11.29.06.45.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 06:45:11 -0800 (PST)
Message-ID: <49315574.7080006@gmail.com>
Date:	Sat, 29 Nov 2008 09:45:08 -0500
From:	roel kluin <roel.kluin@gmail.com>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: unsigned result >= 0 is always true
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

unsigned result >= 0 is always true. Make sure that the return value
is zero or more if atomic_sub is successful.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
UNTESTED! please confirm whether this is the right fix.

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 1232be3..e0b5604 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -248,7 +248,7 @@ static __inline__ int atomic_sub_return(int i, atomic_t * v)
  */
 static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 {
-	unsigned long result;
+	int result;
 
 	smp_llsc_mb();
 
@@ -296,9 +296,10 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 
 		raw_local_irq_save(flags);
 		result = v->counter;
-		result -= i;
-		if (result >= 0)
-			v->counter = result;
+		if (v->counter >= i)
+			v->counter -= i;
+		else
+			result -= i;
 		raw_local_irq_restore(flags);
 	}
 
