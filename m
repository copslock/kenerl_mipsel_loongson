Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g555N2nC020248
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 22:23:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g555N1eR020247
	for linux-mips-outgoing; Tue, 4 Jun 2002 22:23:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g555MwnC020244
	for <linux-mips@oss.sgi.com>; Tue, 4 Jun 2002 22:22:59 -0700
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id g555OrS17591
	for <linux-mips@oss.sgi.com>; Wed, 5 Jun 2002 07:24:53 +0200 (MET DST)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id M24KSFFZ; Wed, 5 Jun 2002 07:24:52 +0200
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Wed, 05 Jun 2002 07:24:52 +0200
Received: by DLFW003A with Internet Mail Service (5.5.2653.19)
	id <JJ7N0G7X>; Wed, 5 Jun 2002 07:25:04 +0200
Message-ID: <86048F07C015D311864100902760F1DD01B5EA6B@DLFW003A>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: kmalloc question
Date: Wed, 5 Jun 2002 07:25:02 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

I always thought that it is save to use kmalloc in an interrupt handler as
long as you use GFP_ATOMIC. 
Now someone told me that it is not allowed to use these functions in any way
in an interrupt.

Can please someone clarify me here? 

regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
