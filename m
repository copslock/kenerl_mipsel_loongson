Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAMA9Zo29813
	for linux-mips-outgoing; Thu, 22 Nov 2001 02:09:35 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAMA9Vo29803
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 02:09:31 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id fAM99TD11011
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 10:09:29 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id XK4A27W7; Thu, 22 Nov 2001 10:09:28 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Thu, 22 Nov 2001 10:09:28 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <WR91V9AQ>; Thu, 22 Nov 2001 10:08:45 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E3CA@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: Cross Compiler again
Date: Thu, 22 Nov 2001 10:08:44 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

For my environment I need a compiler that supports dwarf debug information.
Sadly my precompiled version does not have this support so I tried it on my
own, using Bradley D. LaRonde's  HowTo. 
All went well but I had to learn that GCC 3.0.1 is not able to compile a
current kernel. So I tried version 2.95.3, but I ran into the same problem
that I had last time I tried such a thing. When compiling glibc the process
failed because of a missing -D__PIC__ option. I was told that this has to do
with a non-MIPS compiler that is used, but the compiler used is my previous
build static version of gcc. 
I don't know what else may be wrong or where to look. Can anybody enlighten
me?

Or has anybody a precompiled gcc with dwarf support for download (That is
able to compile a current kernel, of course. ;-) )?

Best regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
