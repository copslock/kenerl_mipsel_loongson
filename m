Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 18:57:32 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:25766 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225009AbVEER5Q>; Thu, 5 May 2005 18:57:16 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc12) with SMTP
          id <2005050517570801400g21vte>; Thu, 5 May 2005 17:57:08 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	<owner-linux-mips@oss.sgi.com>
Cc:	<linux-mips@linux-mips.org>
Subject: ATA devices attached to arbitary busses
Date:	Thu, 5 May 2005 13:56:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVRm9QE9/BnFJFTTLSeLMfemcyIyw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050505175716Z8225009-1340+6570@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

owner-linux-mips@oss.sgi.com  wrote on 8/19/2002:

> We support ATA devices attached to arbitary busses. The newest ATA code
> supports arbitary mmio/pio addressing mechanisms. You don't need ISA or
> an ISA like bus.


This is good news!  We want to connect an IDE flash drive to the local bus
of an rm9224.  Of course we will have to make an IDE host adapter with an
FPGA.  Right now, I'm a bit clueless as to how to get the linux kernel to
support this.  Could someone please point me in the right direction?  What
kernel source files should I be looking at?  Is there any documentation?
Many thanks!

Bryan 
