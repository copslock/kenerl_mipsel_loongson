Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1RG9WH07532
	for linux-mips-outgoing; Wed, 27 Feb 2002 08:09:32 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1RG7h907505
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 08:09:29 -0800
Received: from mail1.infineon.com ([192.35.17.229]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA01743
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 07:05:03 -0800 (PST)
	mail_from (Andre.Messerschmidt@infineon.com)
From: Andre.Messerschmidt@infineon.com
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id g1RF0Ic19732
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 16:00:48 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id F4K6CNGZ; Wed, 27 Feb 2002 16:00:16 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Wed, 27 Feb 2002 16:00:15 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <D4M0469P>; Wed, 27 Feb 2002 16:02:51 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E73C@dlfw003a.dus.infineon.com>
To: linux-mips@oss.sgi.com
Subject: Wait instruction on 5kc
Date: Wed, 27 Feb 2002 16:02:50 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

Is there a patch available for the wait instruction bug in the 5kc (RTL
Revision >= 2.1)? 
As a hack I changed it to nop (in r4k_wait() ), but I believe there is a
clever solution for this. 

regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
