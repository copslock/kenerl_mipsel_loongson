Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2005 16:59:29 +0100 (BST)
Received: from krt.tmd.ns.ac.yu ([IPv6:::ffff:147.91.177.65]:6352 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8225562AbVEYP7O>;
	Wed, 25 May 2005 16:59:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4PH8LjX017215
	for <linux-mips@linux-mips.org>; Wed, 25 May 2005 19:08:21 +0200
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 17100-02 for <linux-mips@linux-mips.org>;
 Wed, 25 May 2005 19:08:21 +0200 (CEST)
Received: from davidovic ([192.168.0.89])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4PH8Jb4017205
	for <linux-mips@linux-mips.org>; Wed, 25 May 2005 19:08:19 +0200
Message-Id: <200505251708.j4PH8Jb4017205@krt.neobee.net>
Reply-To: <mile.davidovic@micronasnit.com>
From:	"Mile Davidovic" <mile.davidovic@micronasnit.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Mips4KECR2
Date:	Wed, 25 May 2005 18:00:32 +0200
Organization: MicronasNIT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVhQuDYchYJkAONS9WjBRBe+vSwhA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <mile.davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mile.davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello all 

I have problem with MIPS4KECR2 and int handler, MIPS 4KECR2 has support for
external interrupt controller. 
AFAIK, conditions for EIC mode are next:
	Config3(VEIC) = 1
	IntCtl(VS) != 0
	Cause(IV) = 1
	Status(BEV) = 0

IntCtl(VS) has to be different then zero and this field specifies spacing
beetween vectored interrupts.
Interrupt handler for MIPS4KECR2 is placed on 0x80000200 and if I set
IntCtl(VS) on 0x20 and I want to
use max number of interrupts (63) I have to place almost 2k from 0x80000200
and I am afraid that I will
overwritten something.

I am pretty shure that I do not see obviouse things, but any help/comment
will be most welcome.


Best regards Mile
