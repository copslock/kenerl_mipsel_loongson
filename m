Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6P9A5u10929
	for linux-mips-outgoing; Wed, 25 Jul 2001 02:10:05 -0700
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6P9A1O10914;
	Wed, 25 Jul 2001 02:10:01 -0700
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id f6P99x211748;
	Wed, 25 Jul 2001 11:09:59 +0200 (MET DST)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id PTHN1GPV; Wed, 25 Jul 2001 11:09:54 +0200
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Wed, 25 Jul 2001 11:09:21 +0200 (W. Europe Daylight Time)
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <PR6RSAL9>; Wed, 25 Jul 2001 11:12:48 +0200
Message-ID: <86048F07C015D311864100902760F1DDFF0016@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: AW: GCC and Modules
Date: Wed, 25 Jul 2001 11:12:47 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

> He's refering to the last official release of binutils which indeed wasn't
> usable for modutils.
> 
I compiled the tools by myself but the problems remain.
My module should only print a message using printk, but I can't get it to
run.

Here are my results:
> insmod module.o
insmod: unresolved symbol _gp_disp

Module compiled with -mno-abicalls and -no-half-pic (as someone in the
archives mentioned)
> insmod module.o
Warning: unhandled reloc 9
insmod: Unhandled relocation of type 9 for
Warning: unhandled reloc 11
insmod: Unhandled relocation of type 11 for printk
Warning: unhandled reloc 9
insmod: Unhandled relocation of type 9 for
Warning: unhandled reloc 11
insmod: Unhandled relocation of type 11 for printk

Does anybody know what the problem is?

regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
