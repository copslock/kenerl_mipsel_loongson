Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQA0n813569
	for linux-mips-outgoing; Mon, 26 Nov 2001 02:00:49 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQA0io13563
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 02:00:44 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id fAQ90eD24921;
	Mon, 26 Nov 2001 10:00:40 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id X3V69JTS; Mon, 26 Nov 2001 10:00:39 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Mon, 26 Nov 2001 10:00:38 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <WR91V0SB>; Mon, 26 Nov 2001 09:59:53 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E414@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: dan@debian.org
Cc: linux-mips@oss.sgi.com
Subject: RE: Cross Compiler again
Date: Mon, 26 Nov 2001 09:59:52 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> If you simply fix the one declaration it complains about (it involves
> adding 'volatile' to one of the two declarations of xtime) then this
> kernel actually will work under GCC 3.0.1.  We haven't QA'd it, but I
> use it routinely for testing.
> 
Thanks. Compiling now works, but the linker complains about undefined
references:

init/main.o: In function `init':
init/main.c:794: relocation truncated to fit: R_MIPS_GPREL16 execute_command
init/main.o: In function `parse_options':
init/main.o(.text.init+0x7d8): relocation truncated to fit: R_MIPS_GPREL16
execute_command
arch/mips/kernel/kernel.o(.debug+0x32e14): undefined reference to `L_E660'
arch/mips/kernel/kernel.o(.debug+0x60e7c): undefined reference to `L_E549'
arch/mips/kernel/kernel.o(.debug+0x8d097): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d0b9): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d168): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d18a): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d31f): undefined reference to `L_E8867'
arch/mips/kernel/kernel.o(.debug+0x8d3b6): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d3d8): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d52d): undefined reference to `L_E8867'
arch/mips/kernel/kernel.o(.debug+0x8d5c4): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d5e6): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d6f2): undefined reference to `L_E8867'
arch/mips/kernel/kernel.o(.debug+0x8d718): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x8d762): undefined reference to `L_E8015'
arch/mips/kernel/kernel.o(.debug+0x172bec): undefined reference to `L_E8153'
arch/mips/kernel/kernel.o(.debug+0x19dea0): undefined reference to `L_E111'
arch/mips/kernel/kernel.o(.debug+0x19debe): undefined reference to `L_E1321'
arch/mips/kernel/kernel.o(.debug+0x1f64f2): undefined reference to `L_E7978'
arch/mips/kernel/kernel.o(.debug+0x1f662a): undefined reference to `L_E7978'

It goes on like this for 800 lines. Does anyone know why this happens?

regards
Andre
