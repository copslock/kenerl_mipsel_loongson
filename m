Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64FMbRw008246
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 08:22:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64FMbCG008245
	for linux-mips-outgoing; Thu, 4 Jul 2002 08:22:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64FMXRw008236
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 08:22:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.5/8.12.5) with ESMTP id g64FQV8j003027
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 08:26:31 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA03876
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 08:26:29 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g64FQTb00718
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 17:26:29 +0200 (MEST)
Message-ID: <3D246924.542682B2@mips.com>
Date: Thu, 04 Jul 2002 17:26:28 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: LTP testing (shmat01)
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The LTP test shmat01 fails on MIPS, because SHMLBA is defined to 0x40000
(in include/asm-mips/shmparam.h).
For all other architectures SHMLBA is defined to PAGE_SIZE, does anyone
know why we are different ?

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
