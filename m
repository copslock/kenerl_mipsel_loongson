Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2003 01:05:35 +0100 (BST)
Received: from 64-132-170-33.gen.twtelecom.net ([IPv6:::ffff:64.132.170.33]:30213
	"EHLO smtp.gcis.net") by linux-mips.org with ESMTP
	id <S8225212AbTECAFc>; Sat, 3 May 2003 01:05:32 +0100
Received: from winMe [12.99.240.208] by smtp.gcis.net with ESMTP
  (SMTPD32-7.07) id A7F22D9010E; Fri, 02 May 2003 20:06:10 -0400
Reply-To: <jzhang@elmic.com>
From: "Jimmy Zhang" <jzhang@elmic.com>
To: <linux-mips@linux-mips.org>
Subject: How to make part of kseg0 uncached
Date: Fri, 2 May 2003 16:56:44 -0700
Message-ID: <004f01c31106$7cb63de0$0300a8c0@riverside>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Return-Path: <jzhang@elmic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jzhang@elmic.com
Precedence: bulk
X-list: linux-mips

It is pretty simple to make the WHOLE kseg0 cached or uncached. However,
I only want part of kseg0 uncached. 

I must uncache that region because it gives me too much trouble with DMA
data, however, I don't want to uncache the whole kseg0 segment in order
to get better performance.  Kseg0 is not mapped through TLB, so it seems
I can't achieve my goal through TLB. 

Cite from the book See Mips Run, "if you feel that your system needs to
make uncached references to cacheable memory, then I strongly recommand
that you divide memory into regions that are always accessed uncached
and regions that are always accessed through the cache - and don't let
them overlap. " But how ?

Thanks,

Jimmy
