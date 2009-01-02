Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jan 2009 15:10:04 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.184]:26696 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22774218AbZABPJ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jan 2009 15:09:59 +0000
Received: by nf-out-0910.google.com with SMTP id h3so872995nfh.14
        for <multiple recipients>; Fri, 02 Jan 2009 07:09:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=dmnEB+GhJDgh6sg5w0OitCDzYTiMlF4/FRw0HkgpiYY=;
        b=KMESLaVQtX8Qg2RU6kZSYcnWFxIW2ysJEHk2IdKpaiFM2Y/odzb5xu3xJdIMytY9+c
         kiVtbHoGLdEq/6deap9pZyub2JhnpMlmqjmoYAEJPP5ENUSzbkfVbqlEg1j30kIdREpi
         uEnjJn83OX563KjdQ2QBEFNfYT7gCRYAtsHjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=uGvGsUj8IlYgw6v6uhX4Rxwm2CYZK/GwUqDCCjj690n5q9T5zZeA5VwBcqY7uCgZOf
         6SZ2hrasBlmvNfz3Ab+06mry2DuqBnHFvDmPengzaxPXIja52UEcWWqENwXGZu5e8rN0
         YKFE1Td7A8MnjRQWtkN902Rd+8IMCrLFB5PEs=
Received: by 10.210.109.10 with SMTP id h10mr21005103ebc.10.1230908998270;
        Fri, 02 Jan 2009 07:09:58 -0800 (PST)
Received: from ?192.168.1.148? (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id f3sm31650819nfh.34.2009.01.02.07.09.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jan 2009 07:09:57 -0800 (PST)
Message-ID: <495E2E47.6080605@gmail.com>
Date:	Fri, 02 Jan 2009 16:09:59 +0100
From:	Roel Kluin <roel.kluin@gmail.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: unsigned result is always greater than 0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

unsigned result is always greater than 0

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
I cannot determine whether the same bug occurs as well in assembly.
Also shouldn't similar checks occur in atomic64_sub_return and in
atomic64_add_return for negative values of i?

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 1232be3..3cd07a9 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -296,9 +296,10 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 
 		raw_local_irq_save(flags);
 		result = v->counter;
-		result -= i;
-		if (result >= 0)
+		if (i <= result) {
+			result -= i;
 			v->counter = result;
+		}
 		raw_local_irq_restore(flags);
 	}
 
@@ -677,9 +678,10 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 
 		raw_local_irq_save(flags);
 		result = v->counter;
-		result -= i;
-		if (result >= 0)
+		if (i >= result) {
+			result -= i;
 			v->counter = result;
+		}
 		raw_local_irq_restore(flags);
 	}
 
