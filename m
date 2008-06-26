Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 07:07:55 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:22541 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S28575986AbYFZGHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2008 07:07:45 +0100
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 25 Jun 2008 23:07:28 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 0D6512B0; Wed, 25 Jun 2008 23:07:28 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id E5D5E2B0 for
 <linux-mips@linux-mips.org>; Wed, 25 Jun 2008 23:07:27 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GYV16025; Wed, 25 Jun 2008 23:07:27 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 1230120501 for <linux-mips@linux-mips.org>; Wed, 25 Jun 2008 23:07:27
 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Bug in atomic_sub_if_positive
Date:	Wed, 25 Jun 2008 23:07:24 -0700
Message-ID: <ADD7831BD377A74E9A1621D1EAAED18F0442AF00@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: Bug in atomic_sub_if_positive
Thread-Index: AcjXUubV9JI/8zo6QlaMem/+HdxMfQ==
From:	"Morten Larsen" <mlarsen@broadcom.com>
To:	linux-mips@linux-mips.org
X-WSS-ID: 647DEDAA4E062194696-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mlarsen@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlarsen@broadcom.com
Precedence: bulk
X-list: linux-mips


As far as I can tell the branch optimization fixes in 2.6.21 introduced
a bug in atomic_sub_if_positive that causes it to return even when the
sc instruction fails. The result is that e.g. down_trylock becomes
unreliable as the semaphore counter is not always decremented.

Below is a patch that fixed the problem on my system.

Morten S. Larsen


--- a/include/asm-mips/atomic.h 2008-06-25 22:38:43.159739000 -0700
+++ b/include/asm-mips/atomic.h 2008-06-25 22:39:07.552065000 -0700
@@ -292,10 +292,10 @@ static __inline__ int atomic_sub_if_posi
                "       beqz    %0, 2f
\n"
                "        subu   %0, %1, %3
\n"
                "       .set    reorder
\n"
-               "1:
\n"
                "       .subsection 2
\n"
                "2:     b       1b
\n"
                "       .previous
\n"
+               "1:
\n"
                "       .set    mips0
\n"
                : "=&r" (result), "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter)
@@ -682,10 +682,10 @@ static __inline__ long atomic64_sub_if_p
                "       beqz    %0, 2f
\n"
                "        dsubu  %0, %1, %3
\n"
                "       .set    reorder
\n"
-               "1:
\n"
                "       .subsection 2
\n"
                "2:     b       1b
\n"
                "       .previous
\n"
+               "1:
\n"
                "       .set    mips0
\n"
                : "=&r" (result), "=&r" (temp), "=m" (v->counter)
                : "Ir" (i), "m" (v->counter)
