Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 20:16:26 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:10481 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225923AbVD1TQI>; Thu, 28 Apr 2005 20:16:08 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc13) with SMTP
          id <20050428191601016002h221e>; Thu, 28 Apr 2005 19:16:01 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	<linux-mips@linux-mips.org>
Cc:	<TheNop@gmx.net>
Subject: 
Date:	Thu, 28 Apr 2005 15:15:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVMJrAGKf+TUcotQiCo0YNheAEyXQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050428191608Z8225923-1340+6320@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Hello,

I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
Somehow, I am unable to compile the kernel.  I have tried the 2.6.10 kernel
trees from ftp.pmc-sierra.com and also the latest 2.6.12 snapshot from
linux-mips.  I am using the 3.3.x cross compile tools from
ftp.pmc-sierra.com .  The 2.4.x kernels from PMC compile fine.

In the case of 2.6.10 from ftp.pmc-sierra.com, my error looks like:
       Make[3]: *** [drivers/char/agp/backend.o] Error 1

	
In the case of 2.6.12 from linux-mips, my error looks like:
	drivers/net/titan_ge.c1950: error: 'titan_device_remove"  undeclared
here (not in a function)

My compile process is like so:
make mrproper
make xconfig
make oldconfig
make ARCH=mips CROSS_COMPILE=/<tool_path>/mips64-linux-gnu-    vmlinux

Could someone share their .config with me, or make some suggestions?

Thank you,
Bryan
