Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA24024
	for <pstadt@stud.fh-heilbronn.de>; Sat, 21 Aug 1999 03:24:27 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA10774; Fri, 20 Aug 1999 18:21:18 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA29838
	for linux-list;
	Fri, 20 Aug 1999 18:18:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id SAA04384;
	Fri, 20 Aug 1999 18:18:16 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA28865; Fri, 20 Aug 1999 18:18:11 -0700
From: "William J. Earl" <wje@fir.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14269.65107.528164.540174@fir.engr.sgi.com>
Date: Fri, 20 Aug 1999 18:18:11 -0700 (PDT)
To: Cory Jon Hollingsworth <cory@real-time.com>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux@cthulhu.engr.sgi.com
Subject: Re: Hard Hat and Tandem.
In-Reply-To: <37BDF6BA.DAFDC837@real-time.com>
References: <37B70CDF.D938EA0D@real-time.com>
	<19990818133932.A8965@uni-koblenz.de>
	<37BC8A94.289936FF@real-time.com>
	<19990820032312.A25007@uni-koblenz.de>
	<37BDF6BA.DAFDC837@real-time.com>
X-Mailer: VM 6.72 under Emacs 19.34.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Cory Jon Hollingsworth writes:
...
 >     I've opened up the box again to have another peak at the boards.  The top
 > board says this:
 > Silicon Graphics Inc.  Copyright 1994
 > SCSI-MEZZ CHALLENGE-S 030-8221-002 REV: D
 > 
 >     This board has the WD33C95 SCSI controller chip on it.  This board has two
 > wide SCSI ports out the back and an RJ45 which should be an ethernet.  It has the
 > little network symbol by it.  I initially tried that RJ45 port for bootp, but had
 > no success.  The main board below it has a female DB15 connector that I connect a
 > ethernet transceiver to in order to run bootp.
 > 
 >     The bottom board additionally has the two PS/2 like serial ports, one DB25
 > female (don't know what it is), and a thin SCSI port.
 > 
 >     It has no keyboard or mouse port even though the hinv claims it does.  I
 > wonder if this machine could be loaded with the incorrect boot prom?
...

     The keyboard and mouse hardware is in the ASIC set, just not attached
to connectors.  This is definitely a Challenge-S.  The mezzanine card (which
plugs into the GIO connectors where the Indy graphics card would be) is probably
not being recognized by the drivers you have configured, both for the WD33C95
SCSI controller and the extra Ethernet controller.  That is, you see the
base SCSI and Ethernet, not the extras on the mezzanine card.
