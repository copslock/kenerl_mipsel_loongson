Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HJHuRw029967
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 12:17:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HJHupc029965
	for linux-mips-outgoing; Wed, 17 Jul 2002 12:17:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HJHoRw029950
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 12:17:51 -0700
Received: from excalibur.cologne.de (p50851E15.dip.t-dialin.net [80.133.30.21])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id VAA08870
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 21:22:45 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 17UuQ3-000181-00
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 21:25:03 +0200
Date: Wed, 17 Jul 2002 21:25:03 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Current CVS (2.4.19-rc1) broken on DECstations
Message-ID: <20020717212503.A4332@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: yes
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hallo everybody,

it looks like the current oss.sgi.com 2.4 cvs (currently 2.4.19-rc1) is 
broken on DECstations. The kernel boots on a DS 5000/150, but using
the onboard LANCE does not work. Using ifconfig gives a "SIOCSIFLAGS:
Resource temporarily not available and the kernel tells "lance: Can't get
DMA IRQ 24".

Besides the LANCE problems, everything else seems to work, although I
have not yet done extensive testing (fb, keyboard and harddisk seem to
work).

Can anyone confirm this? Any idea what is broken? I am currently rather
short on time, so going back in CVS to find the date of breakage might
need some time.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
