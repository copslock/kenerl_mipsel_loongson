Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 10:37:22 +0100 (BST)
Received: from [IPv6:::ffff:203.129.212.34] ([IPv6:::ffff:203.129.212.34]:13838
	"HELO contech.contechsoftware.com") by linux-mips.org with SMTP
	id <S8225476AbTIXJhS>; Wed, 24 Sep 2003 10:37:18 +0100
Received: (from prabhakar [200.1.1.48])
 by contech.contechsoftware.com (SAVSMTP 3.0.0.44) with SMTP id M2003092415145319978
 for <linux-mips@linux-mips.org>; Wed, 24 Sep 2003 15:14:57 +0530
Received: by localhost with Microsoft MAPI; Wed, 24 Sep 2003 15:15:12 -0000
Message-ID: <01C382AE.A6330DF0.prabhakark@contechsoftware.com>
From: Prabhakar Kalasani <prabhakark@contechsoftware.com>
Reply-To: "prabhakark@contechsoftware.com" <prabhakark@contechsoftware.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: How to translate Little to Big endian ?
Date: Wed, 24 Sep 2003 15:15:11 -0000
Organization: Contech Software Limited
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
Encoding: 9 TEXT
Return-Path: <prabhakark@contechsoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prabhakark@contechsoftware.com
Precedence: bulk
X-list: linux-mips

Hi all,
I'm trying to port linux-2.4.21 on CSB250 , which is Au1500 processor based board,
the processor is a Big endian, I have taken PB1500 board as my prototype, but it's used Au1500 Little endian.
anybody could help me out, what are the changes do i need to change to make a Little endian souce into Big endian source.

Is anybody worked on Cogent's CSB250 board till.

Thanks in advance
Prabhakar
