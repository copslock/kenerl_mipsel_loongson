Received:  by oss.sgi.com id <S553651AbRAHJlF>;
	Mon, 8 Jan 2001 01:41:05 -0800
Received: from mx.mips.com ([206.31.31.226]:16326 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553647AbRAHJky>;
	Mon, 8 Jan 2001 01:40:54 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA16939
	for <linux-mips@oss.sgi.com>; Mon, 8 Jan 2001 01:40:50 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA18334
	for <linux-mips@oss.sgi.com>; Mon, 8 Jan 2001 01:40:47 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id KAA12624
	for <linux-mips@oss.sgi.com>; Mon, 8 Jan 2001 10:40:13 +0100 (MET)
Message-ID: <3A598AFC.83204F56@mips.com>
Date:   Mon, 08 Jan 2001 10:40:12 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: User applications
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have a few questions about user applications.

When a new user process is started will its user space be cleared by the
kernel or is there a potential leak from an older user process ?
What about the registers values, are they cleared for each new user
application or will it simply contain the current value it got when the
user application is started ?
How can you flush the data and instruction cashes from a user
application ?

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
