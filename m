Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f668HJ930626
	for linux-mips-outgoing; Fri, 6 Jul 2001 01:17:19 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f668HIV30622
	for <linux-mips@oss.sgi.com>; Fri, 6 Jul 2001 01:17:18 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA08815;
	Fri, 6 Jul 2001 01:17:01 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA06224;
	Fri, 6 Jul 2001 01:16:59 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f668Fra13194;
	Fri, 6 Jul 2001 10:15:54 +0200 (MEST)
Message-ID: <3B4573B8.9F89022B@mips.com>
Date: Fri, 06 Jul 2001 10:15:52 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: vhouten@kpn.com, linux-mips@oss.sgi.com
Subject: Illegal instruction
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karel,

I have tried the root-images tar-files: mipselroot-rh7-20010606 and
mipsroot-rh7.
The mipsroot-rh7 (bigendian) root image seem to work fine, but when
I use the mipselroot-rh7-20010606 (littleendian) I get an illegal
instruction.
[cat:179] Illegal instruction 7c010001 at 2ac8b20c ra=00000000.

I'm using a 2.4.3 kernel.
Anyone got an idea ?

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
