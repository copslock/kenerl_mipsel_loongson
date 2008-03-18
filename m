Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 15:49:00 +0000 (GMT)
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:29714 "EHLO
	smtp-vbr13.xs4all.nl") by ftp.linux-mips.org with ESMTP
	id S28605145AbYCRPs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 15:48:58 +0000
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2IFmgQx036926
	for <linux-mips@linux-mips.org>; Tue, 18 Mar 2008 16:48:58 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH][MIPS][5/6]: AR7: serial hack
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:	Tue, 18 Mar 2008 16:40:23 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF85B@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][MIPS][5/6]: AR7: serial hack
thread-index: AciJAs+MVV6DKv8GQWiw9FA8wJZFjgACykIw
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

Hello all,
I didn't follow the entire discussion, but I might have similar problems
on the AU1100 SoC. The AU1100 also has 16550 style serial ports. The
serial console doesn't work even though I specify console=/dev/ttyS0 on
the kernel command line. Once a getty is started, the serial port is
active and working fine.

Nico

> -----Oorspronkelijk bericht-----
> Van: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] Namens Alan Cox
> Verzonden: dinsdag 18 maart 2008 15:02
> Aan: Thomas Bogendoerfer
> CC: Matteo Croce; linux-mips@linux-mips.org; Florian 
> Fainelli; Felix Fietkau; Nicolas Thill; 
> linux-serial@vger.kernel.org; Andrew Morton
> Onderwerp: Re: [PATCH][MIPS][5/6]: AR7: serial hack
> 
> > Is there a good reason, why we don't check for BOTH_EMPTY in
> > serial8250_console_putchar() ? To match the 2.6.10 behaviour we
> 
> A very good one - we have at least 1 byte of FIFO and the 
> serial-ethernet magic console devices also use that fifo 
> emptying entirely to deduce when to send a new packet.
> 
> > would need that and this would fix the AR7 case without any special 
> > handling.
> 
> If the AR7 is an 8250 why does it need special handling? and 
> indeed why does serial work on it except for console - or 
> does that fail too.
> 
> 
