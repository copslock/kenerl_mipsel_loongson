Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQEdb605730
	for linux-mips-outgoing; Mon, 26 Nov 2001 06:39:37 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQEdVo05721;
	Mon, 26 Nov 2001 06:39:31 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id fAQDdTD12640;
	Mon, 26 Nov 2001 14:39:29 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id X3V60CFL; Mon, 26 Nov 2001 14:39:27 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Mon, 26 Nov 2001 14:39:26 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <WR91V07B>; Mon, 26 Nov 2001 14:38:40 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E418@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: AW: Cross Compiler again
Date: Mon, 26 Nov 2001 14:38:39 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Shit in, shit out.  You must be invoking the compiler with some option for
> GP relative optimization.  Won't work.
> 
A typical gcc call is like this:
gcc -Wall -Wstrict-prototypes -O2 -mno-abicalls -fno-pic -mcpu=r4000 -D_32_
-mips2 -Wa,--trap -pipe -c foo.c -o foo.o

Is there any option missing that might me defaulting to such an
optimization?
I have played with the different -O# options without success.

regards
Andre
