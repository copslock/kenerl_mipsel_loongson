Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9T8dXG26630
	for linux-mips-outgoing; Mon, 29 Oct 2001 00:39:33 -0800
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9T8dV026626
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 00:39:31 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id f9T8dT217529
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 09:39:30 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id VW6NWMJG; Mon, 29 Oct 2001 09:39:12 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Mon, 29 Oct 2001 09:39:12 +0100 (W. Europe Standard Time)
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <4YC1M6QN>; Mon, 29 Oct 2001 09:42:01 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E2B0@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: AW: Kernel 2.4.3 compile problem
Date: Mon, 29 Oct 2001 09:41:57 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> If this file contains a NUL character your compiler installation got
> corrupted somehow.  Say might also be memory corruption of your compiler
> host.
> 
Oh. Sometimes it can be simple. 
I removed the NULL character at the end of the file and it compiled
flawlessly. (Don't know where this thing came from...)
Sorry for bothering with such a non-problem.

regards 
Andre
