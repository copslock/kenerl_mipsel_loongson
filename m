Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6Q9AHk08566
	for linux-mips-outgoing; Thu, 26 Jul 2001 02:10:17 -0700
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6Q9AFV08557
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 02:10:15 -0700
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id f6Q9AD210228
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 11:10:13 +0200 (MET DST)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id PTHNGSJF; Thu, 26 Jul 2001 11:10:06 +0200
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Thu, 26 Jul 2001 11:09:34 +0200 (W. Europe Daylight Time)
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <PR6RSBCR>; Thu, 26 Jul 2001 11:09:38 +0200
Message-ID: <86048F07C015D311864100902760F1DDFF0021@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: glibc problem
Date: Thu, 26 Jul 2001 11:09:37 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

During compilation of glibc 2.2.3  I get the following error:
Can not represent BFD_RELOC_16_PCREL_S2 relocation in this object file
format

Someone in the archives meant that -D__PIC__ should be included to the
CFLAGS to resolve this problem, but it seams that I am too dumb to do this. 
I tried several locations to set the variable in the Makefiles and used the
configparms file to set it, but nothing worked. Then I tried to define it in
the file where the error occured, just to realize that there are more
locations where this define is needed, so I reckon it would be the best to
define it from the beginning.
Can anybody tell me how to get it right? 

best regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
