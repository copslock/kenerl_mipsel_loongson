Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 18:59:44 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:52097 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133554AbVJFR70 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 18:59:26 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j96HxItW012648;
	Thu, 6 Oct 2005 10:59:18 -0700 (PDT)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j96HxH17003741;
	Thu, 6 Oct 2005 10:59:17 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Basic question w.r.t bootloader 
Date:	Thu, 6 Oct 2005 10:59:16 -0700
Message-ID: <3CB54817FDF733459B230DD27C690CEC010493E5@Exchange.MIPS.COM>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Basic question w.r.t bootloader 
Thread-Index: AcXKR9IIYLZO+At/QcS2ik0hx9cfSwAVkVaA
From:	"Mitchell, Earl" <earlm@mips.com>
To:	"Arravind babu" <aravindforl@yahoo.co.in>
Cc:	<linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips



If its a DRAM DIMM module then SW reads info
about that RAM via the SPD interface.
SPD = Serial Presence Detect 
This is typically an I2C interface so
SW can bit bang it. 

SPD provides more info than just size.
For example on some systems you need to
know the RAS/CAS params and various
wait state settings in order to program your
memory controller for optimal performance. 
This is how PCs are able to configure themselves 
to work with standard modules. For more info
checkout this site ...

http://www.pcguide.com/art/sdram.htm

For SRAMs the HW guys usually provide
some set of registers for SW to read 
info its needs like size. And sometimes
they don't so you have to use address
probing tricks as Wolfgang described. 

-earlm


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Wolfgang Denk
> Sent: Thursday, October 06, 2005 12:29 AM
> To: Arravind babu
> Cc: linux-mips@linux-mips.org
> Subject: Re: Basic question w.r.t bootloader 
> 
> 
> In message 
> <20051006065332.6978.qmail@web8604.mail.in.yahoo.com> you wrote:
> > 
> >        Generally how bootloader/bootflash code detects
> > the size of RAM on the board? Is it hardcoded some
> > where in the bootflash code or is it detected using
> > memory chips ?
> 
> One method is to probe addresses (at N, 2*N, 4*N etc. starting with a
> resonable value of N like 1 MB) until probing fails. See for  example
> common/memsize.c in the U-Boot sources.
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> The IQ of the group is the lowest IQ of a member of the group divided
> by the number of people in the group.
> 
> 
