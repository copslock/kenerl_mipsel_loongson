Received:  by oss.sgi.com id <S554017AbRBBOuP>;
	Fri, 2 Feb 2001 06:50:15 -0800
Received: from mx.mips.com ([206.31.31.226]:38124 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553967AbRBBOtx>;
	Fri, 2 Feb 2001 06:49:53 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA12448
	for <linux-mips@oss.sgi.com>; Fri, 2 Feb 2001 06:49:50 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA08986
	for <linux-mips@oss.sgi.com>; Fri, 2 Feb 2001 06:49:49 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id PAA07178
	for <linux-mips@oss.sgi.com>; Fri, 2 Feb 2001 15:49:39 +0100 (MET)
Message-ID: <3A7AC901.4BD0F4E0@mips.com>
Date:   Fri, 02 Feb 2001 15:49:37 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Cross build applications
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm trying to cross build a small test program on a linux PC, but it
fails.

mips-linux-gcc -o test test.c
/usr/mips-linux/bin/ld: cannot open crt1.o: No such file or directory

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
