Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2EAMxi32269
	for linux-mips-outgoing; Thu, 14 Mar 2002 02:22:59 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2EAMu932266
	for <linux-mips@oss.sgi.com>; Thu, 14 Mar 2002 02:22:56 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id g2EAONn07762
	for <linux-mips@oss.sgi.com>; Thu, 14 Mar 2002 11:24:23 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id G6LN4G2K; Thu, 14 Mar 2002 11:24:22 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Thu, 14 Mar 2002 11:24:22 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <D4M0V1DP>; Thu, 14 Mar 2002 11:24:18 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E7BA@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: More on serial console problem
Date: Thu, 14 Mar 2002 11:24:17 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

I have digged through my problem with the serial console and it seems that
the TTY layer is calling the tty_driver.write function with parameter
count=0x00 although the buffer contains a 0x0a. 
If I check for this 0x0a, send it to the serial port and return 1 (for on
char sent) it works. But I don't why count is 0x00. It does not make sense
and I have not found such a special check in any other driver. 

Does anybody have an idea what might go wrong here?

best regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
