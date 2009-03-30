Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 05:07:05 +0100 (BST)
Received: from rtitmf2.realtek.com.tw ([60.250.210.236]:64262 "EHLO
	mf2.realtek.com.tw") by ftp.linux-mips.org with ESMTP
	id S20022713AbZC3EG5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Mar 2009 05:06:57 +0100
Received: from mail.realtek.com.tw (unverified [172.21.1.180]) by mf2.realtek.com.tw
 (Clearswift SMTPRS 5.1.7) with ESMTP id <T8d63af24bfac100226125c@mf2.realtek.com.tw>;
 Mon, 30 Mar 2009 12:06:51 +0800
Received: from LIN (172.21.98.162) by rtitcas1.realtek.com.tw (172.21.1.180)
 with Microsoft SMTP Server (TLS) id 8.1.240.5; Mon, 30 Mar 2009 12:06:51
 +0800
Message-ID: <9BDA961341E843F29C1C1ECDB54FD0CF@realtek.com.tw>
From:	=?big5?B?qkyr2KZ3?= <colin@realtek.com.tw>
To:	Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: The impact to change page size to 16k for cache alias
Date:	Mon, 30 Mar 2009 12:06:51 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Return-Path: <colin@realtek.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
We are willing to use 16k page size to avoid cache alias problem.
The Linux version we use is 2.6.12. If we just upgrade mm system to support 
16k page size, what else problems will happen?
There is already one thing we know that applications of ELF format 
applications should be transformed to be 16k alignment.
Another one, we think, highly suspected to be problematic is that many 
drivers will be ok for 4k page size but fails for 16k.
That is because 4k page size had been seemed to be natural for a very long 
long time.
Any other problem that shall happen for 16k page size?

Regards,
Colin 
