Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Aug 2004 10:19:34 +0100 (BST)
Received: from drum.kom.e-technik.tu-darmstadt.de ([IPv6:::ffff:130.83.139.190]:16590
	"EHLO mailserver.KOM.e-technik.tu-darmstadt.de") by linux-mips.org
	with ESMTP id <S8224923AbUHNJT2> convert rfc822-to-8bit; Sat, 14 Aug 2004 10:19:28 +0100
Received: from KOM.tu-darmstadt.de by mailserver.KOM.e-technik.tu-darmstadt.de (8.7.5/8.7.5) with ESMTP id LAA12408; Sat, 14 Aug 2004 11:18:39 +0200 (MEST)
Date: Sat, 14 Aug 2004 11:20:27 +0200 (CEST)
From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
X-X-Sender: rac@shofar.kom.e-technik.tu-darmstadt.de
To: Michael Stickel <michael.stickel@4g-systems.biz>
cc: Pete Popov <ppopov@mvista.com>, dev-list@meshcube.org,
	linux-mips@linux-mips.org
Subject: MeshCube: ATI Rage VGA progress
Message-ID: <Pine.LNX.4.58.0408141104000.24021@shofar.kom.e-technik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <Ralf.Ackermann@KOM.tu-darmstadt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rac@KOM.tu-darmstadt.de
Precedence: bulk
X-list: linux-mips

Hello Michael,

I managed to compile and start a 2.4.22 kernel (with aty... patch 
applied).
=> executes some atyfb specific code (see below)

atyfb: using auxiliary register aperture
atyfb: 3D RAGE (XL pCI-33MHz) [0x4752 rev 0x27] 4M DRAM, 29.498928 MHz 
XTAL, 23K
Console: switching to colour frame buffer device 80x25
fb0: ATY Mach64 frame buffer device on PCI
Dummy keyboard driver installed.
	=> the output varies from either
		- my monitor stating "no signal"
		- to "input not supported"
=> is there any further way to debug this behaviour?

---
Unfortunately the kernel later on reproducibly crashes at

NET4: Linux TCP/IP 1.fos: ICMP, UDP,�CP,�GMP
IP: rhats, CPreinti Pain sockets 1.0/SMP for Linux NET4.0.
Unable to handle kernel paging request at virtual address fffff000,�pc 
== 8028 0
Oops in fault.c::do_page_fault, line 206:
$0 : 00000000

=> We can hopefully solve this by agreeing on a common (proven to work) 
test basis => see below.

------------------------

Can we do a few things to coordinate further work:

1. Are we using the same miniPCI ATI Rage XL? Mine is an Micro Star MS 
9513 and states

[root@meshcube02 /]# lspci -vv
0000:00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 
27) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (2000ns min)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 0300 [size=256]
        Region 2: Memory at 41000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

---
2. Can we please put 
	- a hint on what kernel source to use (e.g. tag for retrieval 
		from mips-linux CVS) and any necessary further
		modifications
	- a .config file for the kernel
on the Wiki?

Looking forward to seeing something on my monitor! :-)

regards
 Ralf

---------------------------------------------------------------
Dr. Ralf Ackermann            _         rac@KOM.tu-darmstadt.de
Multimedia Communications |/ | | |\/|           Merckstrasse 25
                          |\ |_| |  |  64283 Darmstadt, Germany
Tel.: (+49) 6151 16-6138                Fax: (+49) 6151 16-6152
---------------------------------------------------------------
             http://www.kom.tu-darmstadt.de/~rac
---------------------------------------------------------------
