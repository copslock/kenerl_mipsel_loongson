Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2005 10:02:39 +0000 (GMT)
Received: from fw01.bwg.de ([IPv6:::ffff:213.69.156.2]:24753 "EHLO fw01.bwg.de")
	by linux-mips.org with ESMTP id <S8225208AbVA0KCY>;
	Thu, 27 Jan 2005 10:02:24 +0000
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.11.6p2G/8.11.6) with ESMTP id j0RA2NI26886
	for <linux-mips@linux-mips.org>; Thu, 27 Jan 2005 11:02:23 +0100 (CET)
Received: from mail.bwg.de (213.69.155.11) by fw01-4.bwg.de (smtprelay) with ESMTP Thu Jan 27 11:02:16 2005.
Received: from ximap.arbeitsgruppe (80.131.188.248)
          by mail.bwg.de with MERCUR Mailserver (v4.03.06 MTA4LTIzMDQtNDg3Ng==)
          for <linux-mips@linux-mips.org>; Thu, 27 Jan 2005 11:03:12 +0100
Received: from rr2600 (rr-2600 [192.168.178.44])
	by ximap.arbeitsgruppe (Postfix) with SMTP id D826B174B2E
	for <linux-mips@linux-mips.org>; Thu, 27 Jan 2005 11:02:11 +0100 (CET)
From:	=?iso-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
To:	<linux-mips@linux-mips.org>
Subject: Compiler erros in process.c
Date:	Thu, 27 Jan 2005 11:02:49 +0100
Message-ID: <NHBBLBCCGMJFJIKAMKLHEEKACCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

The last commit of process.c (version 1.73, 2.6)
results in compiler errors on my system:

arch/mips/kernel/process.c: In function `dump_regs':
arch/mips/kernel/process.c:169: error: `EF_CP0_EPC' undeclared (first use in
thi
s function)
arch/mips/kernel/process.c:169: error: (Each undeclared identifier is
reported o
nly once
arch/mips/kernel/process.c:169: error: for each function it appears in.)
arch/mips/kernel/process.c:170: error: `EF_CP0_BADVADDR' undeclared (first
use i
n this function)
arch/mips/kernel/process.c:171: error: `EF_CP0_STATUS' undeclared (first use
in
this function)
arch/mips/kernel/process.c:172: error: `EF_CP0_CAUSE' undeclared (first use
in t
his function)
make[1]: *** [arch/mips/kernel/process.o] Error 1
make: *** [arch/mips/kernel] Error 2

I could not find 'EF_CP0_EPC' in the entire source tree.

Regards
  Ralf Roesch
