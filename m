Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQHSYC12595
	for linux-mips-outgoing; Mon, 26 Nov 2001 09:28:34 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQHSSo12590;
	Mon, 26 Nov 2001 09:28:28 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id fAQGSQD29436;
	Mon, 26 Nov 2001 17:28:26 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id X3V60QRT; Mon, 26 Nov 2001 17:28:24 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Mon, 26 Nov 2001 17:28:24 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <WR91WAAQ>; Mon, 26 Nov 2001 17:27:39 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E41A@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: AW: Cross Compiler again
Date: Mon, 26 Nov 2001 17:27:38 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> -G 0.
Thanks that helped for the relocation error.
init/main.o(.text.init+0x7d8): relocation truncated to fit: R_MIPS_GPREL16
execute_command

But I still get a lot of undefined references.
arch/mips/kernel/kernel.o(.debug+0x32e14): undefined reference to `L_E660'
arch/mips/kernel/kernel.o(.debug+0x60e7c): undefined reference to `L_E549'
arch/mips/kernel/kernel.o(.debug+0x8d097): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d0b9): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d168): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d18a): undefined reference to `L_E8015'
...

I believe there is still something wrong with my glibc, but I need to check
that.

> What compiler are you using?  All compilers I've ever released did default
> to -G 0.
I compiled my own gcc using Bradley D. LaRonde's howto.

regards
Andre
