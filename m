Received:  by oss.sgi.com id <S553776AbRBIPPh>;
	Fri, 9 Feb 2001 07:15:37 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:64518 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553650AbRBIPPU>;
	Fri, 9 Feb 2001 07:15:20 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C74297D9; Fri,  9 Feb 2001 16:15:08 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 94CF3EEAC; Fri,  9 Feb 2001 16:15:21 +0100 (CET)
Date:   Fri, 9 Feb 2001 16:15:21 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: current cvs broken on sgi 
Message-ID: <20010209161521.D13248@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
can someone confirm that the current cvs ONCE AGAIN is broken
on SGIs (Indy/I2) ?

Even with the "early console init" it simply dies ..

Command Monitor.  Type "exit" to return to the menu.
>> bootp():vmlinux-ip22 console=ttyS0 root=/dev/sda2
Setting $netaddr to 195.71.99.220 (from server watchdog)
Obtaining vmlinux-ip22 from server watchdog
1556544+0+152424 entry: 0x880025a8                                              


Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
