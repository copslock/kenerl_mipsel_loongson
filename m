Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 20:11:43 +0100 (BST)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:39616 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8224933AbUHLTLj>;
	Thu, 12 Aug 2004 20:11:39 +0100
Received: (qmail 21046 invoked by uid 0); 12 Aug 2004 19:11:33 -0000
Received: from 213.23.33.61 by www3.gmx.net with HTTP;
	Thu, 12 Aug 2004 21:11:33 +0200 (MEST)
Date: Thu, 12 Aug 2004 21:11:33 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Cc: linuxconsole-dev@lists.sourceforge.net, linux-mips@linux-mips.org,
	rac@KOM.tu-darmstadt.de
MIME-Version: 1.0
References: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de>
Subject: Re: Q: problems with missing /dev/tty0 on X startup in MIPS system
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <15387.1092337893@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <svetljo@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetljo@gmx.de
Precedence: bulk
X-list: linux-mips

> Hello,
> 
> I'm trying to get VGA output on a MIPSel system (MeshCube 
> http://www.meshcube.org) to work. 
> The system uses a miniPCI ATI Rage VGA card (=> problem does not get 
> initialized due to lack of system BIOS => hopefully initialized by int10 
> XFree86 x86 emulator code).
> 
> I've attached an USB mouse and keyboard but fail to start X due to
> 
> Fatal server error:
> xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)
> 
> My questions to those working with MIPS boards / on the Ruby/Linux console
> project are:
>  - 1. How to test the USB input functionality?
> 	(I could test the mouse by doing: cat < /dev/input/mice
> 	=> any hints on doing something similar for the keyboard?)

not a guru here, but i hope this will help you
-----------------------
modprobe evdev
cat /proc/bus/input/devices
: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0
B: EV=120003
B: KEY=4 2000000 2b803878 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7
<snip>
cat /dev/input/event0
------
should give you some characters on typing to
the corresponding keyboard

>  - 2. Any hints on the missing /dev/tty0 stuff? (this is maybe
> 	related to the console / keyboard stuff?)
> 
> Any hints are welcome, best regards
>  Ralf

best,

svetljo

-- 
NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl
