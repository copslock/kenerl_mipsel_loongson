Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 16:04:50 +0100 (BST)
Received: from [IPv6:::ffff:199.3.224.121] ([IPv6:::ffff:199.3.224.121]:44047
	"EHLO mailsweeper.scc-inc.com") by linux-mips.org with ESMTP
	id <S8225072AbTGPPEs>; Wed, 16 Jul 2003 16:04:48 +0100
Received: from Mailserver.scc-inc.com (mailserver.scc-inc.com) by mailsweeper.scc-inc.com
 (Content Technologies SMTPRS 4.3.6) with ESMTP id <T6377305fd10a0101456f0@mailsweeper.scc-inc.com>;
 Wed, 16 Jul 2003 11:03:41 -0400
Received: by Mailserver.scc-inc.com with Internet Mail Service (5.5.2653.19)
	id <N9DWDH6A>; Wed, 16 Jul 2003 11:05:15 -0400
Message-ID: <4019CBE63D5A174F8F55FE25BC82D04102B46818@Mailserver.scc-inc.com>
From: Chris Fouts <ChrisF@SCC-INC.com>
To: "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: RE: sudo oops on mips64 linux_2_4
Date: Wed, 16 Jul 2003 11:05:14 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ChrisF@scc-inc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ChrisF@SCC-INC.com
Precedence: bulk
X-list: linux-mips

I'm just getting started with MIPS in Linux so please bear with me.

What options do I use for the compiler to recoginze the C0 specific
op-codes, e.g., mfc0, mtc0, etc? I tried -mips1, -mips2, -mips3 and 
arch=RM7000 to no avail.

-chris
