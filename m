Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 15:09:32 +0200 (CEST)
Received: from mx5.kent.ac.uk ([129.12.21.36]:47041 "EHLO mx5.kent.ac.uk")
	by ftp.linux-mips.org with ESMTP id S8133437AbWEKNJW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2006 15:09:22 +0200
Received: from apophis.ukc.ac.uk ([129.12.4.11])
	by mx5.kent.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FeAum-0000zS-5z
	for linux-mips@linux-mips.org; Thu, 11 May 2006 14:09:12 +0100
Received: from myrtle.ukc.ac.uk ([129.12.3.176] ident=exim)
	by apophis.ukc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <djd20@kent.ac.uk>)
	id 1FeAul-0007gy-Ur
	for linux-mips@linux-mips.org; Thu, 11 May 2006 14:09:11 +0100
Received: from fingerpoken.ukc.ac.uk ([129.12.16.14])
	by myrtle.ukc.ac.uk with esmtp (Exim 4.60)
	(envelope-from <djd20@kent.ac.uk>)
	id 1FeAul-0001Qw-Pd
	for linux-mips@linux-mips.org; Thu, 11 May 2006 14:09:11 +0100
From:	Damian Dimmich <djd20@kent.ac.uk>
To:	linux-mips@linux-mips.org
Subject: seeq driver possibly broken in 2.6.17-rc3-g8f3468ed?
Date:	Thu, 11 May 2006 14:00:42 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111400.42087.djd20@kent.ac.uk>
X-UKC-Mail-System: No virus detected
X-UKC-SpamCheck: 
X-UKC-MailScanner-From:	djd20@kent.ac.uk
Return-Path: <djd20@kent.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djd20@kent.ac.uk
Precedence: bulk
X-list: linux-mips

Hello,

I've just compiled a fresh 2.6.17-rc3-g8f3468ed kernel from linux-mips git for 
my indigo2.  The network card seems to have gone wonky, while the seeq driver 
loads fine:

-- snip --
Serial: IP22 Zilog driver (1 chips).
ttyS0 at MMIO 0xc000e830 (irq = 45) is a IP22-Zilog
Console: ttyS0 (IP22-Zilog)
ttyS1 at MMIO 0xc0010838 (irq = 45) is a IP22-Zilog
eth0: SGI Seeq8003 08:00:69:08:43:b2
arcnet loaded.
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
-- snip --

when trying to do dhcp:
indigo:~# dhclient eth0
Internet Software Consortium DHCP Client 2.0pl5
Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
All rights reserved.

Please contribute if you find this software useful.
For info, please visit http://www.isc.org/dhcp-contrib.html

Listening on LPF/eth0/08:00:69:08:43:b2
Sending on   LPF/eth0/08:00:69:08:43:b2
Sending on   Socket/fallback/fallback-net
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
receive_packet failed on eth0: Network is down

even though the network is up... 
The kernel is compiled in 32bit mode, and everything seems fine otherwise.  I 
am running debian which comes with a 2.4.27 kernel by default, with which the 
seeq card works fine.  There seems to be a lot of packets being sent though, 
as the light at the other end of the cable blinks a lot.

The kernel was compiled with:
gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)

No errors seem to show up aside rom the recieve_packet failed anywhere...

Any ideas?

Please let me know if I can provide any more useful info.

Cheers,
Damian
