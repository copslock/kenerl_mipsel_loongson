Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 01:33:49 +0100 (BST)
Received: from mx2.idealab.com ([IPv6:::ffff:64.208.8.4]:203 "EHLO
	butch.idealab.com") by linux-mips.org with ESMTP
	id <S8225217AbTFQAdq>; Tue, 17 Jun 2003 01:33:46 +0100
Received: (qmail 70372 invoked by uid 72); 17 Jun 2003 00:33:39 -0000
Received: from joseph@omnilux.net by butch.idealab.com with qmail-scanner-1.03 (sweep: 2.6/3.49. . Clean. Processed in 3.303008 secs); 17 Jun 2003 00:33:39 -0000
X-Qmail-Scanner-Mail-From: joseph@omnilux.net via butch.idealab.com
X-Qmail-Scanner: 1.03 (Clean. Processed in 3.303008 secs)
Received: from unknown (HELO c002079) (10.1.2.63)
  by 0 with SMTP; 17 Jun 2003 00:33:36 -0000
From: "Joseph Chiu" <joseph@omnilux.net>
To: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: wired tlb entry?
Date: Mon, 16 Jun 2003 17:36:58 -0700
Message-ID: <BPEELMGAINDCONKDGDNCOEFBDMAA.joseph@omnilux.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

Hi,
Is there a (proper) way to add a page entry in the TLB it's always valid?
Specifically, accesses to memory-mapped hardware (PCMCIA) causes the kernel
to oops under heavy interrupt loading.
It seems to me that the page entry in the TLB is getting flushed out under
the activity; and when the ioremap'd memory region is accesses, the
exception handling for the missing translation does not run.

I'm afraid my two days of googling hasn't turned up the right information.
I think I just don't know the right terminology and I hope someone can at
least point me in the right direction.
Thanks.
Joseph
(I am running 2.4.18-mips)



--
Joseph Chiu, Senior Engineer, Omnilux, Inc.
joseph@omnilux.net  (626) 535-2819
The sun will come up tomorrow.  Bet your bottom dollar that tomorrow,
things'll be back.
