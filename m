Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2DAkBC05383
	for linux-mips-outgoing; Wed, 13 Mar 2002 02:46:11 -0800
Received: from mail2.infineon.com (mail2.infineon.com [192.35.17.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2DAk7905380
	for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 02:46:08 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail2.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail2.infineon.com (8.11.1/8.11.1) with ESMTP id g2D9k0n14424
	for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 10:46:00 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id GQZL44VP; Wed, 13 Mar 2002 10:45:59 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Wed, 13 Mar 2002 10:45:59 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <D4M0VDM2>; Wed, 13 Mar 2002 10:45:55 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E7A1@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: TTY/Serial-Console Problem
Date: Wed, 13 Mar 2002 10:45:54 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

I have a problem with my serial console driver for kernel 2.4.3. 
The system boots fine up to the first shell script that is executed (here:
rcS). Then when the first "echo" ist executed the message is displayed on
the console, but the system is stuck in the cpu_idle function. I still can
ping the board but the execution of the script won't continue. If I use
"echo -n" everything is fine. 
I reckon that the tty layer is waiting for some kind of confimation from the
serial driver to continue execution. But I don't what that might be.

Can anybody please clarify me?

regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
