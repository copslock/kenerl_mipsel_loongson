Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 13:05:21 +0000 (GMT)
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:56328 "EHLO
	smtp-vbr4.xs4all.nl") by ftp.linux-mips.org with ESMTP
	id S28590890AbYB1NFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Feb 2008 13:05:19 +0000
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1SD5CBq042677
	for <linux-mips@linux-mips.org>; Thu, 28 Feb 2008 14:05:17 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PNX8550 Broken on Linux 2.6.24 - Interrupt issues?
Date:	Thu, 28 Feb 2008 14:05:11 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF68E@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PNX8550 Broken on Linux 2.6.24 - Interrupt issues?
thread-index: Ach6CZPq+1tVfxp4SauI+uOFteL44QAAL6mg
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

Daniel,
I've had similar problems on the AU1100 platform. It turned out the
interrupt enumeration was faulty. You might want to check this.

Nico Coesel
 

> -----Oorspronkelijk bericht-----
> Van: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] Namens Daniel Laird
> Verzonden: donderdag 28 februari 2008 13:58
> Aan: linux-mips@linux-mips.org
> Onderwerp: PNX8550 Broken on Linux 2.6.24 - Interrupt issues?
> 
> Hi all.
> 
> I have been happily using Linux 2.6.22.1 for ages on PNX8550 (STB810).
>  I have recently decided to step up and move onto Linux 2.6.24 series.
> However I am not getting very far. :-(
> It seems that all the clock stuff has changed again (since 
> 2.6.22.1) and this is causing issues.
> The board crashes as soon as local_irq_enable is called in main.c
> 
> I was wondering if anyone out there might also be running on 
> an STB810/JBS PNX8550 based system and have any ideas as to 
> why I am crashing.
> I know that PNX8550 does not enable the R4K Clock source 
> stuff as the chip is a bit 'special' and requires the two 
> timers to be used instead of one.
> 
> As far as I can see I think my interrupts are not being setup.
> 
> Any help, ideas etc are appreciated.
> 
> Daniel Laird
> 
> 
