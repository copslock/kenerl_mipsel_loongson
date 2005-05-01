Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 May 2005 00:56:17 +0100 (BST)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:49413 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8224976AbVEAX4C>; Mon, 2 May 2005 00:56:02 +0100
Received: from Snailmail (217.249.208.245)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Mon, 2 May 2005 01:53:43 +0200
Received: from Opal.Peter (pf@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id j41NtJMI001296
	for <linux-mips@linux-mips.org>; Mon, 2 May 2005 01:55:20 +0200
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id BAA03032
	for <linux-mips@linux-mips.org>; Mon, 2 May 2005 01:55:08 +0200
Date:	Mon, 2 May 2005 01:55:08 +0200 (CEST)
From:	peter fuerst <pf@net.alphadv.de>
To:	linux-mips@linux-mips.org
Subject: Bus error question...
Message-ID: <Pine.LNX.4.21.0505020149150.3024-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hi,

this question is posted here in the hope, it will be picked up and answered
by some of the <*@*engr.sgi.com> gurus, i apologize to the other members of
this mailing-list for annoying them with it as well ;-)

Is it save to assume, that memory bus errors (mc cpu_error_stat & 0x400) on
IP28 - due to R10k's precise exception model - can be asynchronous only when
caused by an aborted (misspeculated) instruction ?
The R10k manual, experiences with spurious bus errors and experiments with
"real" and speculated loads/stores seem to suggest this.
Moreover, could it be enough to recognize the bus error as asynchrounous,
when the exception code in cp0_cause doesn't say "Instruction bus error
exception" (6) or "Data bus..." (7), but "Interrupt" (0) ?  (i.e. without
analyzing the instruction at epc and register contents)

Rationale for this question: if a memory bus error can reliably be identified
as originating from a misspeculated memory access, it would be possible to get
rid of the myriads of cache barriers before *loads* (stores will remain
protected by cache barriers anyway) again, and spending some thousand machine
cycles on analyzing a bus error every three days of uptime is clearly more
efficient than having a cache barrier in kernel code every seventeen
instructions...

with kind regards

pf
