Received:  by oss.sgi.com id <S553677AbQLGP7i>;
	Thu, 7 Dec 2000 07:59:38 -0800
Received: from mx.mips.com ([206.31.31.226]:14566 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553659AbQLGP7e>;
	Thu, 7 Dec 2000 07:59:34 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA13203
	for <linux-mips@oss.sgi.com>; Thu, 7 Dec 2000 07:59:30 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA12327
	for <linux-mips@oss.sgi.com>; Thu, 7 Dec 2000 07:59:29 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA03748
	for <linux-mips@oss.sgi.com>; Thu, 7 Dec 2000 16:59:08 +0100 (MET)
Message-ID: <3A2FB3CB.3566F805@mips.com>
Date:   Thu, 07 Dec 2000 16:59:07 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Setup a signal frame.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have a question regarding the setup_frame function in
arch/mips/kernel/signal.c.

If the setup fails we send a SIGSEGV to the current process, but before
doing that we check if signr == SIGSEGV, and if so install the default
handler.
But isn't we sending a SIGSEGV signal, and therefore always should
install the default handler and not check if the original signal was
SIGSEGV ?

In kernel 2.2.12 we always used do_exit(SIGSEGV) if the setup failed,
why has this changed in the 2.4.0 kernel ?

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
