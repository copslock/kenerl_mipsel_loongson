Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 08:52:30 +0100 (BST)
Received: from eezi.conceptual.net.au ([IPv6:::ffff:203.190.192.22]:58758 "EHLO
	eezi.net.au") by linux-mips.org with ESMTP id <S8225203AbUGMHwZ>;
	Tue, 13 Jul 2004 08:52:25 +0100
Received: from swift (203-190-200-060.dial.usertools.net [::ffff:203.190.200.60])
  by eezi.net.au with esmtp; Tue, 13 Jul 2004 15:51:57 +0800
Message-ID: <000701c468ae$141c3e50$0a9913ac@swift>
From: "Collin Baillie" <collin_no_spam_for_me@xorotude.com>
To: linux-mips@linux-mips.org
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
Subject: Help with MOP network boot install on DECstation 5000/240
Date: Tue, 13 Jul 2004 15:49:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <collin_no_spam_for_me@xorotude.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: collin_no_spam_for_me@xorotude.com
Precedence: bulk
X-list: linux-mips

Hi Guys,

I'm trying to install linux-mips on a DECsation 5000/240 I have in my
posession. It has the 5.1b rom so tftp boot is apparently out.

I've setup mopd on a linux (i386) box here and I'm getting the following on
my DECstation:

>>boot 3/mop

???
? PC:  0xa0010aa4<vtr=UTLBM>
? CR:  0x8000200c<BD,CE=0,IP6,EXC=TLBS>
? SR:  0x30080000<CU1,CU0,CM,IPL=8>
? VA:  0x1000
? ER: 0xe7d43000<VALID,CPU,WRITE,ADR=1F50C000>
? CK: 0xef00ffe2<VLDHI,CHKHI=6F,SYNHI=0,VLDLO,CHKLO=7F,SNGLO,SYNLO=62>
>>


In /var/log/messages I'm seeing:

Jul 13 15:44:36 phoenix mopd[10437]: 8:0:2b:2a:fe:c0 (1) Do you have
08002b2afec0? (Yes)
Jul 13 15:44:36 phoenix mopd[10437]: 8:0:2b:2a:fe:c0 Send me 08002b2afec0


and using moptrace I get the following:

Dst          : ab:0:0:1:0:0      MOP Dump/Load Multicast
Src          : 8:0:2b:2a:fe:c0
Proto        : 6001 MOP Dump/Load
Length       : 000b (11)
Code         :   08 Request program
Device Type  :   76 MNE '3MIN (KN02-BA)'
Format       :   01
Program Type :   02 Operating System
Software     :   00 ''
Processor    :   00 System Processor
DL Buff Size : 041c (1052)


Dst          : ab:0:0:2:0:0      MOP Remote Console Multicast
Src          : 8:0:2b:2a:fe:c0
Proto        : 6002 MOP Remote Console
Length       : 001c (28)
Code         :   07 System ID
Reserved     :   00
Receipt Nbr  : 0000
Hardware Addr: 8:0:2b:2a:fe:c0
Maint Version: 3.0.0
Maint Funcion: 004b ( Loop Dump MLdr DLC )
Comm Device  :   76 MNE '3MIN (KN02-BA)'


Dst          : 0:80:ad:72:e3:6f
Src          : 8:0:2b:2a:fe:c0
Proto        : 6001 MOP Dump/Load
Length       : 000b (11)
Code         :   08 Request program
Device Type  :   76 MNE '3MIN (KN02-BA)'
Format       :   01
Program Type :   02 Operating System
Software     :   00 ''
Processor    :   00 System Processor
DL Buff Size : 041c (1052)


Dst          : 0:80:ad:72:e3:6f
Src          : 8:0:2b:2a:fe:c0
Proto        : 6001 MOP Dump/Load
Length       : 0002 (2)
Code         :   0a Request memory load
Load Number  :   01
Error        :   00 (no error)


Dst          : 0:80:ad:72:e3:6f
Src          : 8:0:2b:2a:fe:c0
Proto        : 6001 MOP Dump/Load
Length       : 0002 (2)
Code         :   0a Request memory load
Load Number  :   02
Error        :   00 (no error)


Dst          : 0:80:ad:72:e3:6f
Src          : 8:0:2b:2a:fe:c0
Proto        : 6001 MOP Dump/Load
Length       : 0002 (2)
Code         :   0a Request memory load
Load Number  :   03
Error        :   00 (no error)

I've tried with both the ecoff and the elf kernels (2.4.18) listed on
Karel's web pages.

I was wondering if anyone on the list has had any success installing via MOP
onto a DECstation 5000/240 and would be able to offer me any assistance.

Cheers,

Collin Baillie
