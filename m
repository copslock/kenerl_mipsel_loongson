Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 06:17:55 +0100 (BST)
Received: from mx1.tusur.ru ([IPv6:::ffff:212.192.163.19]:49682 "EHLO tusur.ru")
	by linux-mips.org with ESMTP id <S8224773AbUGUFRu>;
	Wed, 21 Jul 2004 06:17:50 +0100
Received: from localhost (localhost.tusur.ru [127.0.0.1])
	by tusur.ru (Postfix) with SMTP id 3CE8EB6789
	for <linux-mips@linux-mips.org>; Wed, 21 Jul 2004 12:14:08 +0700 (TSD)
X-AV-Checked: Wed Jul 21 12:14:08 2004 Ok
Received: from roman (unknown [211.189.32.204])
	by tusur.ru (Postfix) with ESMTP id 07A83B5212
	for <linux-mips@linux-mips.org>; Wed, 21 Jul 2004 12:13:53 +0700 (TSD)
Message-ID: <002701c46ee1$feeb7fc0$cc20bdd3@roman>
From: "Roman Mashak" <mrv@tusur.ru>
To: <linux-mips@linux-mips.org>
Subject: simple assembler program
Date: Wed, 21 Jul 2004 14:17:14 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1081
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1081
FL-Build: Fidolook 2002 (SL) 6.0.2800.85 - 28/1/2003 19:07:30
X-Spam-DCC: : 
Return-Path: <mrv@tusur.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@tusur.ru
Precedence: bulk
X-list: linux-mips

Hello!

    I tried to compile simple assembler program:

#define a 1
#define b 2

.ent main
.global main
main:
        li $3, a
        li $2, b
        addu $4, $2, $3
.end main

I use SDE-lite kit version 5.03.06 and compile with sde-as:
#sde-as test.S -o testtest.S: Assembler messages:
test.S:9: Error: absolute expression required `li'
test.S:10: Error: absolute expression required `li'

When I eliminate #define and use just 'li $3, 1' and so on - everything is
compiled correctly. Where is my problem?

Thanks in advance!

With best regards, Roman Mashak.  E-mail: mrv@tusur.ru
