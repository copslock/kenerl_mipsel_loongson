Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARDajt16763
	for linux-mips-outgoing; Tue, 27 Nov 2001 05:36:45 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARDago16760
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 05:36:42 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id fARCaaD29953;
	Tue, 27 Nov 2001 13:36:36 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id XW7QX9D0; Tue, 27 Nov 2001 13:36:35 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Tue, 27 Nov 2001 13:36:33 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <WR91WARW>; Tue, 27 Nov 2001 13:36:01 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E42B@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: dan@debian.org
Cc: linux-mips@oss.sgi.com
Subject: AW: Cross Compiler again
Date: Tue, 27 Nov 2001 13:35:55 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I don't know what compiler you're using, but it isn't working right :)
> I suspect you're running afoul of the change in debugging format
> between binutils 2.10 and 2.11.2.
> 
Using the toolchain provided by H.J.Lu it is now working. (gcc version is
2.96)
Don't know what was wrong with the other installation.

regards
Andre
