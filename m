Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAMDhR511849
	for linux-mips-outgoing; Thu, 22 Nov 2001 05:43:27 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAMDhNo11835
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 05:43:23 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id fAMChID07721;
	Thu, 22 Nov 2001 13:43:19 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id XK4AJNPF; Thu, 22 Nov 2001 13:43:17 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Thu, 22 Nov 2001 13:43:17 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <WR91V9GB>; Thu, 22 Nov 2001 13:42:33 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E3CE@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: hjl@lucon.org
Cc: linux-mips@oss.sgi.com
Subject: RE: Cross Compiler again
Date: Thu, 22 Nov 2001 13:42:32 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> May I ask why you want dwarf? FWIW, gcc 2.96 in my RedHat 7.1 mips port
> supports dwarf, but not as default. I don't know how well it works with
> dwarf. Yes, both cross compiler running on RedHat/x86 7.1/7.2 and
> native compiler are provided in my mips port.
> 
I need dwarf support because my debugger only supports dwarf. (It is an
integrated simulation environment, where I cannot change the debugger to
gdb).

Do you have a download link for your mips port?

regards
Andre
