Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 20:22:11 +0000 (GMT)
Received: from vsmtp2alice.tin.it ([IPv6:::ffff:212.216.176.142]:32678 "EHLO
	vsmtp2.tin.it") by linux-mips.org with ESMTP id <S8225351AbVAUUWG>;
	Fri, 21 Jan 2005 20:22:06 +0000
Received: from eppesuigoccas.homedns.org (80.180.159.168) by vsmtp2.tin.it (7.0.027) (authenticated as giuseppe.sacco17@tin.it)
        id 41F01B8A000975FA for linux-mips@linux-mips.org; Fri, 21 Jan 2005 21:21:59 +0100
Received: from eppesuig3 ([192.168.2.50] ident=giuseppe)
	by eppesuigoccas.homedns.org with asmtp (Exim 3.35 #1 (Debian))
	id 1Cs5I5-00041L-00
	for <linux-mips@linux-mips.org>; Fri, 21 Jan 2005 21:21:57 +0100
Subject: Re: O2 and 128Mb
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <41E6CB5B.6080303@total-knowledge.com>
References: <1105602134.10493.23.camel@localhost>
	 <41E627F8.3010004@total-knowledge.com>
	 <1105605285.10490.52.camel@localhost>
	 <41E6CB5B.6080303@total-knowledge.com>
Content-Type: text/plain
Organization: Giuseppe Sacco Consulting
Date:	Fri, 21 Jan 2005 21:19:35 +0100
Message-Id: <1106338775.4760.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno gio, 13-01-2005 alle 11:26 -0800, Ilya A. Volynets-Evenbakh ha
scritto:
> Please set up serial console, and find out where kernel crashes.
> It is pretty obvious that happens before gbefb is initialized, but
> after ip32-reset is setup (which sets up timer to blink the LED),
> thus should be able to give you some output on serial port.

Sorry for being late,
I tried: I found a laptop equipped with serial port, plugged a nullmodem
serial cable on the laptop serial port and on the serial port labeled "1"
of the O2 machine. I started minicom on the laptop and selected ttyS0, 9600,
8bit, noparity, 1 stop bit.

Then changed in /etc/arcboot.conf, my append line from
append="root=/dev/sda1" to
append="root=/dev/sda1 console=ttyS0,9600n8 console=tty0"

shutdown the O2, unplugged power cable, waited, plugged, swithed on.
Then I changed the OSLoadFilename correctly, and typed "boot".

During the supposed boot, minicom doesn't display *any* character. It
just change the online label from "00:00" to "00:01". Nothing more,

Then, as already explained, the red led on the SGI O2 starts blinking.

I then tried the same "append" line with my working kernel and it worked
as expected: writing to both the serial console and the O2 screen.

How may I better debug the problem? Anyone have a working kernel or,
maybe, a newer arcboot?

Thanks,
Giuseppe

Il giorno gio, 13-01-2005 alle 11:26 -0800, Ilya A. Volynets-Evenbakh ha
scritto:
> Please set up serial console, and find out where kernel crashes.
> It is pretty obvious that happens before gbefb is initialized, but
> after ip32-reset is setup (which sets up timer to blink the LED),
> thus should be able to give you some output on serial port.
> 
> Oh, and what does it have to do with fact you have 128M of RAM?
> Giuseppe Sacco wrote:
> 
> >Il giorno mer, 12-01-2005 alle 23:49 -0800, Ilya A. Volynets-Evenbakh ha
> >scritto:
> >  
> >
> >>"Cannot boot" is not very good describtion of the problem.
> >>
> >>    
> >>
> >
> >You are right.
> >Arcboot is Debian version 0.3.8.4. I select the stanza arcboot should
> >use, with 'setenv OSLoadFilename <stanza>" and the kernel is loaded.
> >Then it s ran and the only change I see is the red led blinking. The
> >screen messages are:
> >
> >Loading program segment 1 at 0x80004000, offset=0x4000, size = 0x3df086
> >Zeroing memory at 0x803e3086, size = 0x2bf9a
> >Starting 32-bit kernel
> >
> >Bye,
> >Giuseppe
> >
> >
> >  
> >
> 
