Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3N9lFwJ006220
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Apr 2002 02:47:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3N9lFTG006219
	for linux-mips-outgoing; Tue, 23 Apr 2002 02:47:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3N9l2wJ006215;
	Tue, 23 Apr 2002 02:47:03 -0700
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id g3N9lMn14266;
	Tue, 23 Apr 2002 11:47:22 +0200 (MET DST)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id JF1RT5LW; Tue, 23 Apr 2002 11:47:21 +0200
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Tue, 23 Apr 2002 11:47:21 +0200
Received: by DLFW003A with Internet Mail Service (5.5.2653.19)
	id <JJ7N9S09>; Tue, 23 Apr 2002 11:47:25 +0200
Message-ID: <86048F07C015D311864100902760F1DD01B5E90E@DLFW003A>
From: Andre.Messerschmidt@infineon.com
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: AW: Wait queue problem
Date: Tue, 23 Apr 2002 11:47:20 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> A bad race condition in that code.  If foo_int is called before your
> process
> had a chance to get to sleep it'll never be woken before the timeout.
> 
I think this has been the problem. Thanks.
Is there any possibility to check if there are processes waiting on a queue?

regards
Andre
