Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 15:02:16 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:30149
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224908AbUJSOCE>; Tue, 19 Oct 2004 15:02:04 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id 1D4C5134048; Tue, 19 Oct 2004 16:01:17 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id 1A236134044; Tue, 19 Oct 2004 16:01:17 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPLWP2; Tue, 19 Oct 2004 16:01:50 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: "Linux/MIPS Development" <linux-mips@linux-mips.org>
Subject: jump instruction in delay slot
Date: Tue, 19 Oct 2004 16:05:47 +0200
User-Agent: KMail/1.6.2
Cc: Manish Lachwani <mlachwani@mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410191605.47543.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

the following code snippet is from
arch/mips/pmc-sierra/yosemite/irq-handler.S:

ll_duart_irq:
		li	a0, 4
		move	a1, sp
		jal	do_IRQ
		j	ret_from_irq

I wonder if this is correct. AFAIK, a jump instruction
must not occupy the delay slot of another branch or
jump instruction. Since the 'jal' returns to the first
instruction after the delay slot, I would expect the
effect of the 'j' instruction to be cancelled. Or
is this some kind of trick I do not understand?

tk

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
