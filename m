Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JFsFRw001973
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 08:54:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JFsFco001972
	for linux-mips-outgoing; Fri, 19 Jul 2002 08:54:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JFsARw001961
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 08:54:11 -0700
Received: from excalibur.cologne.de (p5085144B.dip.t-dialin.net [80.133.20.75])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id RAA27866
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 17:54:42 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 17Va80-0000Lp-00
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 17:57:12 +0200
Date: Fri, 19 Jul 2002 17:57:12 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: Current CVS (2.4.19-rc1) broken on DECstations
Message-ID: <20020719175712.A651@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <20020717212503.A4332@excalibur.cologne.de> <Pine.GSO.3.96.1020718111752.9765B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020718111752.9765B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jul 18, 2002 at 11:26:00AM +0200
X-No-Archive: yes
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 18, 2002 at 11:26:00AM +0200, Maciej W. Rozycki wrote:

>  Thanks for the report.  It's a stupid bug in the KN02BA IRQ routing
> table.  I'm committing the following fix to the CVS.

Thanks, the LANCE works again with your patch, but I have discovered another
problem: hwclock does not work (it did wth earlier kernels).

"hwclock --show" results in

hwclock: ioctl() to /dev/rtc to turn on update interrupts failed unexpectedly,
errno=25: Inappropriate ioctl for device.

The kernel at least finds the RTC:
"rtc: Digital DECstation epoch (2000) detected".

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
