Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2003 15:13:19 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:32905 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225364AbTIDONH>; Thu, 4 Sep 2003 15:13:07 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA14505;
	Thu, 4 Sep 2003 16:12:55 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 4 Sep 2003 16:12:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Richard van den Berg <ravdberg@inter.NL.net>
cc: linux-mips@linux-mips.org
Subject: Re: hwclock error on DECstation 5000/133 with 2.4.22
In-Reply-To: <Pine.LNX.4.21.0309022258540.17245-100000@whale.dutch.mountain>
Message-ID: <Pine.GSO.3.96.1030904161032.12210F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 2 Sep 2003, Richard van den Berg wrote:

> Kernel 2.4.17 (Debian kernel-source package) didn't give following error: 
> fortuna:~# hwclock
> hwclock: ioctl() to /dev/rtc to turn on update interrupts failed unexpectedly, errno=25: Inappropriate ioctl for device.
> fortuna:~# hwclock -v
> hwclock 2.4c/util-linux-2.11n

 Please upgrade util-linux -- this has been fixed long time ago.

> 2.4.22 checked out august 27th, system time gets set, don't know if above
> message has other effects. With this kernel recognizes the LK401 keyboard,
> 2.4.17 gave id 186.

 Well, ID 186 looks bogus -- DEC assigned these IDs starting from 1 and
finished at 4, apparently.  I wouldn't recommend running a kernel as old
as 2.4.17. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
