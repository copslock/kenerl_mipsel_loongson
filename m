Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 09:56:57 +0000 (GMT)
Received: from support.romat.com ([IPv6:::ffff:212.143.245.3]:773 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225257AbUK3J4w>;
	Tue, 30 Nov 2004 09:56:52 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id 8CFE0EB2F8
	for <linux-mips@linux-mips.org>; Tue, 30 Nov 2004 11:56:45 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13726-04 for <linux-mips@linux-mips.org>;
 Tue, 30 Nov 2004 11:56:40 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with ESMTP id 499DFEB2EF
	for <linux-mips@linux-mips.org>; Tue, 30 Nov 2004 11:56:40 +0200 (IST)
From: "Gilad Rom" <gilad@romat.com>
To: <linux-mips@linux-mips.org>
Subject: CP0 EntryLo
Date: Tue, 30 Nov 2004 11:56:39 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcTWwuKtiKfMKMGUQxWkLYFbnRTzGg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20041130095640.499DFEB2EF@mail.romat.com>
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Hello List,

I am attempting to access a peripheral device over the Au1500 static bus.

According to the Au1500 Databook, Whenever I set the Chip Select config
Register DTY bits to 1 (for "I/O Device"), I must also set 
Bits 29:26 of CoProcessor 0 to 0xD, to represent bits 35:32 of the 
Physical address. 

My question is, if anyone can answer it, is how do I setup
The CoProcessor0 registers 29:26 in my driver?

I have noticed a set of functions called write/read_c0_entrylo[0,1],
But I keep getting random values when invoking these from my driver.

Thanks,
Gilad.
