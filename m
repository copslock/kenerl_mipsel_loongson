Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V5tbh01426
	for linux-mips-outgoing; Mon, 30 Jul 2001 22:55:37 -0700
Received: from snfc21.pbi.net (mta5.snfc21.pbi.net [206.13.28.241])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V5taV01423
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 22:55:36 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta5.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GHB00ACLPSNNP@mta5.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Mon, 30 Jul 2001 22:55:35 -0700 (PDT)
Date: Mon, 30 Jul 2001 22:55:35 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: r4600 flag
To: "Kevin D. Kissell" <kevink@mips.com>, Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3B664857.4040100@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

in arch/mips/Makefile, we use the -mcpu=r4600 flag for MIPS32. What's 
interesting is that the use of this flag can cause the toolchain to 
generate incorrect code. For example:

la k0, 1f
nop
1: nop


The la macro is split into a lui and a daddiu. The daddiu is not correct 
for a mips32 cpu.  Getting rid of the -mcpu=4600 fixes the problem and 
the daddiu is then changed addiu.

Is there a truly correct -mcpu option for a mips32 cpu?

Pete
