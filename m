Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 01:43:58 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:11528 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S29054755AbYGBAnu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2008 01:43:50 +0100
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 01 Jul 2008 17:43:26 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 D78E82B1; Tue, 1 Jul 2008 17:43:26 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id C37922B0; Tue, 1 Jul
 2008 17:43:26 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GZD41167; Tue, 1 Jul 2008 17:43:15 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 B3B6A20501; Tue, 1 Jul 2008 17:43:15 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [SPAM] RE: Bug in atomic_sub_if_positive
Date:	Tue, 1 Jul 2008 17:43:14 -0700
Message-ID: <ADD7831BD377A74E9A1621D1EAAED18F0450AC67@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <1CA160A5-AC66-4BBF-9C88-0C2B9FF40E6E@27m.se>
Thread-Topic: [SPAM] RE: Bug in atomic_sub_if_positive
Thread-Index: Acjb2qZnclxNhMgNQHeIqx5CltCbqAAALd2g
From:	"Morten Larsen" <mlarsen@broadcom.com>
To:	"Markus Gothe" <markus.gothe@27m.se>
cc:	linux-mips@linux-mips.org
X-WSS-ID: 647410A43D075149103-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mlarsen@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlarsen@broadcom.com
Precedence: bulk
X-list: linux-mips


Thanks for the reply. My main point is that if the sc instruction fails (returns zero) then we need to start over (with another ll instruction.) It appears that the current code does not do this correctly. If you have a better suggestion for a patch, that's fine with me. Below is the code from the 2.6.20.21 kernel, which is (also) working for me.

=:-) Morten


                 __asm__ __volatile__(
                 "       .set    mips3                                   \n"
                 "1:     ll      %1, %2          # atomic_sub_if_positive\n"
                 "       subu    %0, %1, %3                              \n"
                 "       bltz    %0, 1f                                  \n"
                 "       sc      %0, %2                                  \n"
                 "       .set    noreorder                               \n"
                 "       beqz    %0, 1b                                  \n"
                 "        subu   %0, %1, %3                              \n"
                 "       .set    reorder                                 \n"
                 "1:                                                     \n"
                 "       .set    mips0                                   \n"
                 : "=&r" (result), "=&r" (temp), "=m" (v->counter)
                 : "Ir" (i), "m" (v->counter)
                 : "memory");



________________________________

	From: Markus Gothe [mailto:markus.gothe@27m.se] 
	Sent: Tuesday, July 01, 2008 5:29 PM
	To: Morten Larsen
	Cc: linux-mips@linux-mips.org
	Subject: Re: [SPAM] RE: Bug in atomic_sub_if_positive
	
	
	NACK. 

	You must realize that 1b stands for 'label 1, backwards', so correctly it would be '2: b 1f'... Which is a kind off inconsequent numbering in this case.

	//Markus

	On 2 Jul 2008, at 02:12, Morten Larsen wrote:



			As far as I can tell the branch optimization fixes in 2.6.21 introduced
			

			a bug in atomic_sub_if_positive that causes it to return even when the
			

			sc instruction fails. The result is that e.g. down_trylock becomes
			

			unreliable as the semaphore counter is not always decremented.
			


		Previous patch was garbled by Outlook - this one should be clean:
		
		--- a/include/asm-mips/atomic.h 2008-06-25 22:38:43.159739000 -0700
		+++ b/include/asm-mips/atomic.h 2008-06-25 22:39:07.552065000 -0700
		@@ -292,10 +292,10 @@ static __inline__ int atomic_sub_if_posi
		" beqz %0, 2f \n"
		" subu %0, %1, %3 \n"
		" .set reorder \n"
		- "1: \n"
		" .subsection 2 \n"
		"2: b 1b \n"
		" .previous \n"
		+ "1: \n"
		" .set mips0 \n"
		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
		: "Ir" (i), "m" (v->counter)
		@@ -682,10 +682,10 @@ static __inline__ long atomic64_sub_if_p
		" beqz %0, 2f \n"
		" dsubu %0, %1, %3 \n"
		" .set reorder \n"
		- "1: \n"
		" .subsection 2 \n"
		"2: b 1b \n"
		" .previous \n"
		+ "1: \n"
		" .set mips0 \n"
		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
		: "Ir" (i), "m" (v->counter)
		


			_______________________________________

	Mr Markus Gothe
	Software Engineer

	Phone: +46 (0)13 21 81 20 (ext. 1046)
	Fax: +46 (0)13 21 21 15
	Mobile: +46 (0)70 348 44 35
	Diskettgatan 11, SE-583 35 Linköping, Sweden
	www.27m.com

		
	
