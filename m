Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5ICVAnC014305
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 05:31:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5ICVAwi014304
	for linux-mips-outgoing; Tue, 18 Jun 2002 05:31:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5ICV4nC014300
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 05:31:04 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id FAA11827
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 05:33:50 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA05736
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 05:33:51 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5ICXpb11613
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 14:33:51 +0200 (MEST)
Message-ID: <3D0F28AE.7B0D822B@mips.com>
Date: Tue, 18 Jun 2002 14:33:50 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: 64-bit kernel
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I don't know if anymore has a interest in the 64-bit kernel, but I just
found this bug (see patch below).
It would be nice to know, how many are interested in the 64-bit kernel
and who actually got something running.
So please rise you voice.

/Carsten

Index: include/asm-mips64/exception.h
===================================================================
RCS file:
/home/repository/sw/linux-2.4.18/include/asm-mips64/exception.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 exception.h
--- include/asm-mips64/exception.h      4 Mar 2002 11:13:25 -0000
1.1.1.1
+++ include/asm-mips64/exception.h      18 Jun 2002 12:18:40 -0000
@@ -28,7 +28,7 @@

        .macro  __build_clear_fpe
        cfc1    a1, fcr31
-       li      a2, ~(0x3f << 13)
+       li      a2, ~(0x3f << 12)
        and     a2, a1
        ctc1    a2, fcr31
        STI



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
