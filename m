Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5678lnC031419
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 00:08:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5678kRg031418
	for linux-mips-outgoing; Thu, 6 Jun 2002 00:08:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5678hnC031415
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 00:08:44 -0700
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id g567AZ217142;
	Thu, 6 Jun 2002 09:10:35 +0200 (MET DST)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id MKXM3S9S; Thu, 6 Jun 2002 09:10:34 +0200
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Thu, 06 Jun 2002 09:10:34 +0200
Received: by DLFW003A with Internet Mail Service (5.5.2653.19)
	id <JJ7N0HSB>; Thu, 6 Jun 2002 09:10:45 +0200
Message-ID: <86048F07C015D311864100902760F1DD01B5EA87@DLFW003A>
From: Andre.Messerschmidt@infineon.com
To: alan@lxorguk.ukuu.org.uk
Cc: linux-mips@oss.sgi.com
Subject: AW: kmalloc question
Date: Thu, 6 Jun 2002 09:10:45 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> GFP_ATOMIC is safe in an interrupt handler. You might get NULL back and
> that it is your problem, but the kmalloc is safe
> 
Thanks. 
NULL is something I can handle.

regards
Andre
