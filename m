Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LJaBq09175
	for linux-mips-outgoing; Thu, 21 Mar 2002 11:36:11 -0800
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LJa8q09172
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 11:36:08 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id g2LIa4c00134
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 19:36:05 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id HJ082VZQ; Thu, 21 Mar 2002 19:36:03 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Thu, 21 Mar 2002 19:36:03 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <D4M0VHWZ>; Thu, 21 Mar 2002 19:36:07 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E828@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: Kernel compile with -O0
Date: Thu, 21 Mar 2002 19:36:06 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

When I try to compile my 2.4.3 Kernel with -O0 I get a lot of undefined
references to functions like __cli, clear_bit etc. during linking. With -O1
it works.

Do I have to provide some special compile option to make this work?

best regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
