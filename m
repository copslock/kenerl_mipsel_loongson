Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 14:48:06 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42768 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20025600AbXFANsE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Jun 2007 14:48:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DE92EE1CFF;
	Fri,  1 Jun 2007 15:47:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c7kpi+LUPcJT; Fri,  1 Jun 2007 15:47:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 91727E1C85;
	Fri,  1 Jun 2007 15:47:22 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l51DlYNE031600;
	Fri, 1 Jun 2007 15:47:34 +0200
Date:	Fri, 1 Jun 2007 14:47:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jan Rekorajski <baggins@sith.mimuw.edu.pl>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] zs: Move to the serial subsystem
In-Reply-To: <20070601125052.GA15787@sith.mimuw.edu.pl>
Message-ID: <Pine.LNX.4.64N.0706011406170.26841@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl>
 <20070530165842.GL29894@sith.mimuw.edu.pl> <Pine.LNX.4.64N.0705301802570.27697@blysk.ds.pg.gda.pl>
 <20070601125052.GA15787@sith.mimuw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.2/3335/Thu May 31 12:16:21 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jun 2007, Jan Rekorajski wrote:

> >  I am looking into a solution that would make it automatic without the 
> > need of involving userland which just does not seem right here -- you do 
> > want to run your kernel with "init=/bin/bash" or suchlike and have your 
> > virtual terminal console usable.  I will remove the old lk201 bits then.
> 
> Why not do that in the driver? AFAIK there can't be anything else on
> those ports.

 Well, with some soldering skills you can make an adapter that will 
convert each of them to an ordinary 3-wire serial line.  Therefore I think 
the best approach would be only doing the binding of the keyboard and the 
mouse port to the input subsystem if the virtual terminal device is 
opened.

 This is unfortunately not the way how things are set up right now.  
Opening the VT does not trigger a query for the associated input devices 
that could pull the necessary drivers.  It merely uses whatever got 
registered beforehand (or actually at any point) and for the DECstation it 
means dummy devices (how useful!).

 But that is not the most important reason.  That in fact is the way how 
it could be implemented in the driver.  It means at least hacks to the 
receive interrupt and another hack to implement an alternative transmit 
interrupt handler.  I refuse to do polled transmission with this chip 
because of its performance hit, sorry, and with the dz driver, which 
requires a corresponding change, the hit would be even worse.

 Finally, the lone reason for introducing the serial subsystem was to 
abstract serial ports from the TTY layer, so any sort of devices could use 
them, regardless of whether they resemble a terminal or not.  And there is 
a proper serio driver for this abstract serial port already implemented.  
Therefore introducing hacks to the serial driver "under the bonnet" is 
certainly not the way to go.  We did have such hacks in 2.4, but that was 
because there was no generic serial port layer back then and all serial 
ports were TTYs. ;-)

 Besides, I think the driver should not enforce any policy, because it 
does not "know" or enforce the external wiring of the serial ports.  
These are the part of the platform (and please note that there are two 
variations available for the DECstation and other two for the DEC 3000 
AXP) and it's the platform that should mark each port appropriately.  I do 
admit at the moment the device handled by the driver is not handled as a 
platform device as it should, but I'd like to avoid short-term hacks that 
do not add value.  The DECstation port needs a generic way of registering 
platform devices (all the bits on the motherboard that do not pretend to 
be TURBOchannel options) like some other platforms already do and when 
this is implemented the serial ports will be handled as necessary as a 
part of it.

  Maciej
