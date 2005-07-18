Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 19:52:33 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:226 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8226843AbVGRSwJ>; Mon, 18 Jul 2005 19:52:09 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc12) with SMTP
          id <2005071818533901400353h3e>; Mon, 18 Jul 2005 18:53:40 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: mips64 crosstool
Date:	Mon, 18 Jul 2005 14:53:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcWHZSfad2BSW7ZHSgK2kHba95oicQEYtSEA
In-Reply-To: <6097c4905071221414a929ed2@mail.gmail.com>
Message-Id: <20050718185209Z8226843-3678+3416@linux-mips.org>
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Many thanks to everyone who has helped me on this issue. 

I ended up abandoning the crosstool approach.  It supports mips32 well, but
not mips64.  Linux from scratch has a very good step by step procedure for
building a tool chain for mips64.  I was able to build with very little
headaches.  Unfortunately, I have not yet been able to execute any programs
compiled with the tool chain.  I'm not sure where I went wrong. 

PMC sierra is working on an update for their tool chain.  They have supplied
me with a "beta" version tool chain that has solved my problems.  Now, I am
able to compile with -mabi=64 and -lpthread.  The executable no longer
Segfaults.  Since I'm past this problem, I will probably not spend much more
time trying to build a working tool chain.

Bryan   
