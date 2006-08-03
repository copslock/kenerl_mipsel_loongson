Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 14:54:17 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:35026 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133828AbWHCNyH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 14:54:07 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1G8cf8-000591-9W
	for linux-mips@linux-mips.org; Thu, 03 Aug 2006 14:50:54 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1G8df1-0005cC-OY
	for linux-mips@linux-mips.org; Thu, 03 Aug 2006 15:54:51 +0200
Date:	Thu, 3 Aug 2006 15:54:51 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060803135451.GC24940@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Understanding PCMCIA layer
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'm just playing with the PCMCIA layer in order to manage a WiFi
module.

I notice that giving the suspend/resume command sequence I get:

   hostname:~# pccardctl suspend
   WWPC-PCMCIA: config_skt 0 Vcc 0V Vpp 0V, flags 0 (reset 0)
   WWPC-PCMCIA: suspend_skt 0                                                      
   hostname:~# pccardctl resume
   WWPC-PCMCIA: init_skt 0
   WWPC-PCMCIA: config_skt 0 Vcc 0V Vpp 0V, flags 0 (reset 0)
   WWPC-PCMCIA: config_skt 0 Vcc 33V Vpp 33V, flags 0 (reset 0)
   WWPC-PCMCIA: config_skt 0 Vcc 33V Vpp 0V, flags 240 (reset 1)
   WWPC-PCMCIA: config_skt 0 Vcc 33V Vpp 0V, flags 200 (reset 0)                   

and giving the eject/insert one I get:

   hostname:~# pccardctl eject
   pccard: card ejected from slot 0
   WWPC-PCMCIA: init_skt 0
   WWPC-PCMCIA: config_skt 0 Vcc 0V Vpp 0V, flags 0 (reset 0)
   hostname:~# pccardctl insert
   WWPC-PCMCIA: config_skt 0 Vcc 33V Vpp 33V, flags 0 (reset 0)
   WWPC-PCMCIA: config_skt 0 Vcc 33V Vpp 0V, flags 240 (reset 1)
   WWPC-PCMCIA: config_skt 0 Vcc 33V Vpp 0V, flags 200 (reset 0)
   pccard: PCMCIA card inserted into slot 0
   pcmcia: registering new device pcmcia0.0                                        

My module support a "sleep" mode, so I shouldn't remove power supply
nor giving to it a reset impulse during suspend/resume stages but, on
the other hands, I'd like to reset it when I give the "insert" command
and turning it off when I give the "eject" command.

How I can resolve the problem? =:-o

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
