Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 16:17:06 +0000 (GMT)
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:10767 "EHLO
	smtp-vbr11.xs4all.nl") by ftp.linux-mips.org with ESMTP
	id S28582958AbYCMQRE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Mar 2008 16:17:04 +0000
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2DGH4Qd094869
	for <linux-mips@linux-mips.org>; Thu, 13 Mar 2008 17:17:04 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
Content-class: urn:content-classes:message
Subject: FW: Alchemy power managment code.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:	Thu, 13 Mar 2008 17:16:37 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Alchemy power managment code.
thread-index: AciFEhe6VQdP6xzqSLqyFGOAP4S1YAAAHiBwAATATJA=
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

Ralf,
Funny you ask because I tried this yesterday on a AU1100 system with the
2.6.24 kernel (from kernel.org). I'm afraid I must say the kernel
crashes when I enable power management. The reason I want to use power
management is because I need to send the CPU to sleep when the system
shuts down. I hacked power.c and reset.c a bit so au_sleep() is called
when the system is shut down. Perhaps someone can confirm the
powermanagement can be made to work with some fixes (it didn't work with
2.6.21-rc4 either).

The CPU frequency switching stuff isn't very usefull since it is
possible to derive various pheripheral frequencies from it. For
instance, on our board the LCD frequency is derived from the CPU
frequency. The auxilary frequency cannot by divided to provide the
refreshrate we need. So changing the CPU frequency would 'break' our LCD
display.

Nico Coesel 

> -----Oorspronkelijk bericht-----
> Van: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] Namens Ralf Baechle
> Verzonden: donderdag 13 maart 2008 14:56
> Aan: linux-mips@linux-mips.org
> Onderwerp: Alchemy power managment code.
> 
> The Alchemy code in arch/mips/au1000/common/power.c is one of the last

> remaining users of pm_send_all() which happens to be a nop call 
> because nothing registers callbacks with pm_register.  So the 
> pm_send_all() calls can be removed.
> 
> Which leaves pm_do_suspend with no sensible code, so it can be 
> removed.
> And ripped like this pm_do_sleep looks it it may well no longer be 
> functioning.
> 
> So, anybody still using that stuff, does it provide any useful 
> functionality?  Does the CPU frequency stuff actually work?
> 
>   Ralf
> 
> PS: You should hear the engine of my chainsaw warming up ...
> 
> 
