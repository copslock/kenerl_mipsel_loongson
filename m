Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6M6fbRw012604
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 21 Jul 2002 23:41:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6M6fb7W012603
	for linux-mips-outgoing; Sun, 21 Jul 2002 23:41:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6M6fTRw012588;
	Sun, 21 Jul 2002 23:41:29 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6M6fbXb017168;
	Sun, 21 Jul 2002 23:41:38 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA28646;
	Sun, 21 Jul 2002 23:41:39 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6M6fdb22888;
	Mon, 22 Jul 2002 08:41:40 +0200 (MEST)
Message-ID: <3D3BA918.97AAE461@mips.com>
Date: Mon, 22 Jul 2002 08:41:39 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Johannes Stezenbach <js@convergence.de>, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: LTP testing: msgctl/IPC_STAT
References: <20020719143034.GA5956@convergence.de> <20020719080014.A20377@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H. J. Lu" wrote:

> On Fri, Jul 19, 2002 at 04:30:34PM +0200, Johannes Stezenbach wrote:
> > I was investigating LTP test suite failures of the msgctl01,
> > msgctl02, msgsnd01 and msgsnd02 tests. It seems that they
> > are caused by a mismatch between /usr/include/bits/msq.h
> > and linux/include/asm-mips/msgbuf.h.
> >
> > I suggest the following patch which makes mips' msgbuf.h
> > a copy of the one in include/asm-i386.
> >
>
> I prefer we fix glibc. Here is a patch.
>

Ok, so it's being fixed in glibc. Ralf please ignore my previous mail.


>
> H.J.
>
>   ------------------------------------------------------------------------
>
>    glibc-mips-msg.patchName: glibc-mips-msg.patch
>                        Type: Plain Text (text/plain)

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
