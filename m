Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 17:04:44 +0000 (GMT)
Received: from baldur.fh-brandenburg.de ([IPv6:::ffff:195.37.0.5]:51357 "HELO
	baldur.fh-brandenburg.de") by linux-mips.org with SMTP
	id <S8225457AbUBEREn>; Thu, 5 Feb 2004 17:04:43 +0000
Received: (1380 bytes) by baldur.fh-brandenburg.de
	via sendmail with P:stdio/R:match-inet-hosts/T:smtp
	(sender: <dahms@zeus.fh-brandenburg.de>) 
	id <m1Aomqq-000ps5C@baldur.fh-brandenburg.de>
	for <linux-mips@linux-mips.org>; Thu, 5 Feb 2004 17:59:40 +0100 (MET)
	(Smail-3.2.0.97 1997-Aug-19 #3 built DST-Sep-15)
Received: from zeus.fh-brandenburg.de(195.37.1.35)
 via SMTP by baldur.fh-brandenburg.de, id smtpdNNAa001YW; Thu Feb  5 16:30:49 2004
Received: (from dahms@localhost)
	by zeus.fh-brandenburg.de (8.11.7p1+Sun/8.11.7) id i12G7Tt20206
	for linux-mips@linux-mips.org; Mon, 2 Feb 2004 17:07:29 +0100 (MET)
Date: Mon, 2 Feb 2004 17:07:29 +0100
From: Markus Dahms <dahms@fh-brandenburg.de>
To: linux-mips@linux-mips.org
Subject: Indy R4000PC problems
Message-ID: <20040202160729.GA5966@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dahms@zeus.fh-brandenburg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dahms@fh-brandenburg.de
Precedence: bulk
X-list: linux-mips

Hi,

I had problems getting the 2.4 kernel to work on an Indy with
a R4000PC (100MHz) processor (very old PROM, too).
The solution I found yesterday is to change an entry in
arch/mips/kernel/cpu-probe.c from CPU_R4000SC to CPU_R4000PC.
Is there a reason why only the SC version is thought to be
there, or is it believed to be compatible?
Without this change the machine locks up after loading the
kernel, linux hasn't switched to the black background, yet.

I also changed the compiler flags from -m{arch,tune}=r4600 to
*r4000, but this I also tried before without success.

greetings,

	Markus Dahms

-- 
A bug in the code is worth two in the documentation.
