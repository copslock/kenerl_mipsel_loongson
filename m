Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25AG4t18961
	for linux-mips-outgoing; Tue, 5 Mar 2002 02:16:04 -0800
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25AFx918956
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 02:15:59 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id g259Fuc11232
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 10:15:57 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id F4K6LB0A; Tue, 5 Mar 2002 10:15:55 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Tue, 05 Mar 2002 10:15:55 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <D4M0401N>; Tue, 5 Mar 2002 10:18:42 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E74B@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: Console problem
Date: Tue, 5 Mar 2002 10:18:41 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g25AG0918958
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

I wrote my own console driver based on the ARC console driver (to keep it
simple). When I am booting my modified 2.4.3 kernel, I get an "unable to
open initial console" error (code: No such device). I have tracked it down
to the point where the kernel searches for a valid TTY device with major and
minor ID 4:64. 
All devices that are present at this time are: 3:0-3:256 2:0-2:256 5:0 5:1.
Obviously there is no 4:64 device.

I mount root via NFS and my devices are as follows:.
crw-------    1 root     tty        5,   1 Mär  4 17:49 console
crw-------    1 root     tty        4,   0 Mär  4 17:49 tty0
crw-rw-rw-    1 root     tty        4,   1 Mär  4 17:49 tty1
...
crw-r--r--    1 root     root       4,  64 Mär  5 08:26 ttyS0
crw-r--r--    1 root     root       4,  65 Mär  5 08:26 ttyS1

I also add a "console=ttyS0,9600" to the kernel command line. 
Am I missing anything? Why is there no device 4:64? (My console driver
identifies itself as 4,64)   
Any help would be appreciated.


best regards
--
Andre Messerschmidt

Application Engineer
Infineon Technologies AG
