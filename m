Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 23:15:09 +0100 (BST)
Received: from drum.kom.e-technik.tu-darmstadt.de ([IPv6:::ffff:130.83.139.190]:29873
	"EHLO mailserver.KOM.e-technik.tu-darmstadt.de") by linux-mips.org
	with ESMTP id <S8225216AbUHLWPE>; Thu, 12 Aug 2004 23:15:04 +0100
Received: from KOM.tu-darmstadt.de by mailserver.KOM.e-technik.tu-darmstadt.de (8.7.5/8.7.5) with ESMTP id AAA02134; Fri, 13 Aug 2004 00:14:12 +0200 (MEST)
Date: Fri, 13 Aug 2004 00:15:49 +0200 (CEST)
From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
X-X-Sender: rac@shofar.kom.e-technik.tu-darmstadt.de
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ralf Ackermann <rac@KOM.tu-darmstadt.de>, dev-list@meshcube.org,
	linuxconsole-dev@lists.sourceforge.net,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Q: problems with missing /dev/tty0 on X startup in MIPS system
In-Reply-To: <Pine.GSO.4.58.0408122101460.18214@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0408130009070.14554@shofar.kom.e-technik.tu-darmstadt.de>
References: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de>
 <Pine.GSO.4.58.0408122101460.18214@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Ralf.Ackermann@KOM.tu-darmstadt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rac@KOM.tu-darmstadt.de
Precedence: bulk
X-list: linux-mips

Still unable to get the miniPCI ATI Rage to work with the meshcube.

> Yep, that's the current virtual console. Do you have CONFIG_VT enabled? If yes,
> probably the VC initialization failed due to vgacon failing. In that case, you
> can try enabling dummycon (and hope X can wake up your graphics card).
> 
> BTW, there exists (depending on your kernel version) code in atyfb to
> initialize the RAGE XL.

Hello Geert,

many thanks for your help. With the dummycon and the atyfb code activated 
(I'm using a 2.4.24 kernel) I was able to start the X server.

Unfortunately - neither the fbdev code nor the X startup activates the 
card.
The X startup failed with an "unable to map the card" once and now 
repeatedly fails with:

...
(==) Log file: "/var/log/XFree86.0.log", Time: Fri Aug 13 00:05:26 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(EE) No devices detected.

Fatal server error:
no screens found

I do not see whether any int10 module specific code is executed (the X.log 
file does not indicate any module load activities at all.

Any hints here on the list on how to proceed? I'll probably better try 
to ask the Xfree people now.

best regards
 Ralf
