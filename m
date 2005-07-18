Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 20:00:16 +0100 (BST)
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([IPv6:::ffff:82.235.130.100]:52193
	"EHLO lexbox.fr") by linux-mips.org with ESMTP id <S8226842AbVGRS75>;
	Mon, 18 Jul 2005 19:59:57 +0100
Received: from mail pickup service by lexbox.fr with Microsoft SMTPSVC;
	 Mon, 18 Jul 2005 21:00:26 +0200
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: mips64 crosstool
Date:	Mon, 18 Jul 2005 21:00:26 +0200
MIME-Version: 1.0
Message-ID: <000001c58bca$f50976e0$0300a8c0@intra.lexbox.org>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
Thread-Index: AcWHZSfad2BSW7ZHSgK2kHba95oicQEYtSEA
In-Reply-To: <6097c4905071221414a929ed2@mail.gmail.com>
To:	<unlisted-recipients:>,
	<no To-header on input>,
	"IMB Recipient 1" <mspop3connector.david.sanchez@lexbox.fr>
X-archive-position: 8537
X-ecartis-version: Ecartis v1.0.0
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
Content-Class: urn:content-classes:message
X-list:	linux-mips
Importance: normal
Priority: normal
X-OriginalArrivalTime: 18 Jul 2005 19:00:26.0078 (UTC) FILETIME=[F50BE7E0:01C58BCA]
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8538
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
