Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Dec 2004 20:34:19 +0000 (GMT)
Received: from web25810.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.195]:40299
	"HELO web25810.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8224933AbULKUeN>; Sat, 11 Dec 2004 20:34:13 +0000
Received: (qmail 6023 invoked by uid 60001); 11 Dec 2004 20:34:06 -0000
Message-ID: <20041211203406.6021.qmail@web25810.mail.ukl.yahoo.com>
Received: from [81.241.205.222] by web25810.mail.ukl.yahoo.com via HTTP; Sat, 11 Dec 2004 21:34:06 CET
Date: Sat, 11 Dec 2004 21:34:06 +0100 (CET)
From: =?iso-8859-1?q?S=E9bastien=20Vajda?= <sebvajda@yahoo.fr>
Subject: [PATCH] add iomap functions
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, yuasa@hh.iij4u.or.jp, cobalt@colonel-panic.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <sebvajda@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebvajda@yahoo.fr
Precedence: bulk
X-list: linux-mips

Dear all,

I tried compiling CVS from 3~4 days ago for a Cobalt
Qube2. This box has two tulip NIC. The tulip driver
has been changed in the 2.6.10-rcx timeframe. It now
uses iowrite32, ioread32 and assorted functions.

Those are currently not implemented in linux-mips.

In Novemember, Yoichi Yuasa submitted a patch for
iomap functions. On this submission Ralf Baechle asked
why not use the generic iomap implementation instead?

I've tried both. With the generic iomap the kernel
compiles fine, but the tulip driver is not working.
With Yoichi Yuasa's patch everything works as it
should.

As Yoichi's patch is needed for the Qube2 boxen, could
I ask if the patch is going to be applied in CVS. And
if not, what needs to be done?

ps.: I'm not on the list, so please CC me when
replying.

Best regards,
Seb.


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/ 
 
Avec Yahoo! faites un don et soutenez le Téléthon en cliquant sur http://www.telethon.fr/030-Don/10-10_Don.asp
