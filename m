Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 08:34:11 +0100 (BST)
Received: from drum.kom.e-technik.tu-darmstadt.de ([IPv6:::ffff:130.83.139.190]:16009
	"EHLO mailserver.KOM.e-technik.tu-darmstadt.de") by linux-mips.org
	with ESMTP id <S8224839AbUHKHeH>; Wed, 11 Aug 2004 08:34:07 +0100
Received: from KOM.tu-darmstadt.de by mailserver.KOM.e-technik.tu-darmstadt.de (8.7.5/8.7.5) with ESMTP id JAA13244; Wed, 11 Aug 2004 09:34:00 +0200 (MEST)
Date: Wed, 11 Aug 2004 09:35:35 +0200 (CEST)
From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
X-X-Sender: rac@shofar.kom.e-technik.tu-darmstadt.de
To: linux-mips@linux-mips.org
cc: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Subject: Q: XFree86 (on MeshCube) from Debian?
Message-ID: <Pine.LNX.4.58.0408110935080.16674@shofar.kom.e-technik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Ralf.Ackermann@KOM.tu-darmstadt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rac@KOM.tu-darmstadt.de
Precedence: bulk
X-list: linux-mips

Hello,

thanks a lot to the persons who helped me setting up a Debian/Sarge 
environment for the MeshCube (using cdebootstrap worked like a charm).

I may go on with an XFree86 server now (I tried using the ati module):
...
XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-6 20040709164028 
root@remake.rfc822
.org)
Release Date: 15 August 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.4.25 mips [ELF]
Build Date: 10 July 2004
...

Nevertheless - the server refuses to start because of:
Fatal server error:
xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)

Can this be fixed without having to install an alternative kernel on the 
cube? (e.g. by loading an additional / which? kernel module?)

best regards and thanks for your help
 Ralf
