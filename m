Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 19:01:11 +0100 (BST)
Received: from drum.kom.e-technik.tu-darmstadt.de ([IPv6:::ffff:130.83.139.190]:22190
	"EHLO mailserver.KOM.e-technik.tu-darmstadt.de") by linux-mips.org
	with ESMTP id <S8225216AbUHLSBH>; Thu, 12 Aug 2004 19:01:07 +0100
Received: from KOM.tu-darmstadt.de by mailserver.KOM.e-technik.tu-darmstadt.de (8.7.5/8.7.5) with ESMTP id UAA29716; Thu, 12 Aug 2004 20:00:47 +0200 (MEST)
Date: Thu, 12 Aug 2004 20:02:28 +0200 (CEST)
From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
X-X-Sender: rac@shofar.kom.e-technik.tu-darmstadt.de
To: linuxconsole-dev@lists.sourceforge.net, linux-mips@linux-mips.org
cc: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Subject: Q: problems with missing /dev/tty0 on X startup in MIPS system
Message-ID: <Pine.LNX.4.58.0408121954270.14123@shofar.kom.e-technik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Ralf.Ackermann@KOM.tu-darmstadt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rac@KOM.tu-darmstadt.de
Precedence: bulk
X-list: linux-mips

Hello,

I'm trying to get VGA output on a MIPSel system (MeshCube 
http://www.meshcube.org) to work. 
The system uses a miniPCI ATI Rage VGA card (=> problem does not get 
initialized due to lack of system BIOS => hopefully initialized by int10 
XFree86 x86 emulator code).

I've attached an USB mouse and keyboard but fail to start X due to

Fatal server error:
xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)

My questions to those working with MIPS boards / on the Ruby/Linux console 
project are:
 - 1. How to test the USB input functionality?
	(I could test the mouse by doing: cat < /dev/input/mice
	=> any hints on doing something similar for the keyboard?)
 - 2. Any hints on the missing /dev/tty0 stuff? (this is maybe
	related to the console / keyboard stuff?)

Any hints are welcome, best regards
 Ralf

---------------------------------------------------------------
Dr. Ralf Ackermann            _         rac@KOM.tu-darmstadt.de
Multimedia Communications |/ | | |\/|           Merckstrasse 25
                          |\ |_| |  |  64283 Darmstadt, Germany
Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
---------------------------------------------------------------
             http://www.kom.tu-darmstadt.de/~rac
---------------------------------------------------------------
