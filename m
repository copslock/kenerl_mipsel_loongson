Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Aug 2004 21:08:38 +0100 (BST)
Received: from drum.kom.e-technik.tu-darmstadt.de ([IPv6:::ffff:130.83.139.190]:31104
	"EHLO mailserver.KOM.e-technik.tu-darmstadt.de") by linux-mips.org
	with ESMTP id <S8225072AbUHJUId>; Tue, 10 Aug 2004 21:08:33 +0100
Received: from KOM.tu-darmstadt.de by mailserver.KOM.e-technik.tu-darmstadt.de (8.7.5/8.7.5) with ESMTP id WAA05288; Tue, 10 Aug 2004 22:07:55 +0200 (MEST)
Date: Tue, 10 Aug 2004 22:09:28 +0200 (CEST)
From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
X-X-Sender: rac@shofar.kom.e-technik.tu-darmstadt.de
To: dev-list@meshcube.org
cc: Ralf Ackermann <rac@KOM.tu-darmstadt.de>, linux-mips@linux-mips.org
Subject: Q: PCI VGA on Meshcube - any progress?
In-Reply-To: <41176789.12682.FB0F085@localhost>
Message-ID: <Pine.LNX.4.58.0408102158480.14110@shofar.kom.e-technik.tu-darmstadt.de>
References: <41176789.12682.FB0F085@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Ralf.Ackermann@KOM.tu-darmstadt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rac@KOM.tu-darmstadt.de
Precedence: bulk
X-list: linux-mips

Hello,

today my MS-9513 miniPCI VGA card arrived and I started trying to use it.
The card is identified in the /proc filesystem:

---------------
[root@meshcube01 root]# cat /proc/pci
PCI devices found:
  Bus  0, device   3, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 5.
      Master Capable.  Latency=128.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0x40000000 [0x40ffffff].
      I/O at 0x300 [0x3ff].
      Non-prefetchable 32 bit memory at 0x41000000 [0x41000fff].
----------------

Nevertheless - it does not output any signal - which is probably / as 
expected due to the missing initialization (that is done by the BIOS on 
x86 systems).

Did anybody have any more practical success/experiences so far? If so:
 - Did you try to use the card with the fbdev code (and with which 
	kernel)?
 - Did somebody suceed in using an XFree X server (which?, any special 
	hints?)

In addition to a cross-compile environment I'm using a chrooted 
Redhat/MIPS installation. It does have the development tools and 
infrastructure to compile an XFree X server on my own - nevertheless, I'd 
like to share/wait for the experiences that others made before I spend 
more time on it right now.

Any hints are welcome!

Best regards
 Ralf

---------------------------------------------------------------
Dr. Ralf Ackermann            _         rac@KOM.tu-darmstadt.de
Multimedia Communications |/ | | |\/|           Merckstrasse 25
                          |\ |_| |  |  64283 Darmstadt, Germany
Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
---------------------------------------------------------------
             http://www.kom.tu-darmstadt.de/~rac
---------------------------------------------------------------
