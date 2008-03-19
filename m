Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2008 09:35:32 +0000 (GMT)
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:29446 "EHLO
	smtp-vbr6.xs4all.nl") by ftp.linux-mips.org with ESMTP
	id S20022308AbYCSJfa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Mar 2008 09:35:30 +0000
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2J9Yvnh072533
	for <linux-mips@linux-mips.org>; Wed, 19 Mar 2008 10:35:29 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Serial console on Au1100 
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:	Wed, 19 Mar 2008 10:34:40 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF86E@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial console on Au1100 
thread-index: AciJFwlBP+AX6P9zTxeBRyzJE78jKAAgAbig
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

Sergei,
I'm using kernel 2.6.24 now (before I used 2.6.21-rc4). I do see the
console messages on the framebuffer device.

Kernel options:
console=ttyS0 root=/dev/mtdblock0 rootfstype=jffs2 rw
video=au1100fb:panel:KERN_AU1100 tsdev.xres=320 tsdev.yres=234
console=tty0

If I omit console=tty0, then there is no output on the framebuffer
device or the serial port. I also tried setting the I/O address and so
on, but no luck.

Nico Coesel
 

> -----Oorspronkelijk bericht-----
> Van: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com] 
> Verzonden: dinsdag 18 maart 2008 17:44
> Aan: Nico Coesel
> CC: linux-mips@linux-mips.org
> Onderwerp: Serial console on Au1100 
> 
> Hello.
> 
> Nico Coesel wrote:
> 
> > Hello all,
> > I didn't follow the entire discussion, but I might have similar 
> > problems on the AU1100 SoC. The AU1100 also has 16550 style serial 
> > ports. The serial console doesn't work even though I specify 
> > console=/dev/ttyS0 on the kernel command line. Once a getty is 
> > started, the serial port is active and working fine.
> 
>     This is not at all related to the discussed issue, so 
> I've changed the subject. The console works like charm 
> (seemingly for everybody, which kernel version are you using?
> 
> > Nico
> 
> WBR, Sergei
> 
