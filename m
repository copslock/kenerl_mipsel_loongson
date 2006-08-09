Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 11:28:53 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:49845 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042058AbWHIK2u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 11:28:50 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAkJY-0007oI-FE
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 11:25:25 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAlJu-0000fB-8M
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 12:29:50 +0200
Date:	Wed, 9 Aug 2006 12:29:50 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809102950.GA2531@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: au1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'm just working on MMC support for au1100 CPUs. I patched au1xmmc.c
in order to disable DMA support (which is different from au1200 and
au1100) and forcing PIO mode.

Both MMC controllers of au1200 and au1100 seems similar to me...

Here what I get when I insert the card:

   mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
   mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 23 width 0
   mmc0: clock 450000Hz busmode 1 powermode 2 cs 0 Vdd 23 width 0
   mmc0: clock 450000Hz busmode 1 powermode 2 cs 1 Vdd 23 width 0
   mmc0: starting CMD0 arg 00000000 flags 00000040
   mmc0: req done (CMD0): 0/0/0: 00000000 00000000 00000000 00000000
   mmc0: clock 450000Hz busmode 1 powermode 2 cs 0 Vdd 23 width 0
   mmc0: starting CMD55 arg 00000000 flags 00000015
   mmc0: req done (CMD55): 0/0/0: 00000120 00000000 00000000 00000000
   mmc0: starting CMD41 arg 00000000 flags 00000061
   mmc0: req done (CMD41): 0/0/0: 00ff8000 00000000 00000000 00000000
   mmc0: clock 450000Hz busmode 1 powermode 2 cs 0 Vdd 15 width 0
   mmc0: clock 450000Hz busmode 1 powermode 2 cs 1 Vdd 15 width 0
   mmc0: starting CMD0 arg 00000000 flags 00000040
   mmc0: req done (CMD0): 0/0/0: 00000000 00000000 00000000 00000000
   mmc0: clock 450000Hz busmode 1 powermode 2 cs 0 Vdd 15 width 0
   mmc0: starting CMD55 arg 00000000 flags 00000015
   mmc0: req done (CMD55): 0/0/0: 00000120 00000000 00000000 00000000
   mmc0: starting CMD41 arg 00018000 flags 00000061
   mmc0: req done (CMD41): 0/0/0: 00ff8000 00000000 00000000 00000000
   mmc0: starting CMD55 arg 00000000 flags 00000015
   mmc0: req done (CMD55): 0/0/0: 00000120 00000000 00000000 00000000
   mmc0: starting CMD41 arg 00018000 flags 00000061
   mmc0: req done (CMD41): 0/0/0: 80ff8000 00000000 00000000 00000000
   mmc0: starting CMD2 arg 00000000 flags 00000067
   mmc0: req done (CMD2): 0/0/0: 1d41444d 494e4953 10310001 9a005500
   mmc0: starting CMD3 arg 00000000 flags 00000065
   mmc0: req done (CMD3): 0/0/0: 019a0055 00000000 00000000 00000000
   mmc0: host does not support reading read-only switch. assuming write-enable.
   mmc0: starting CMD2 arg 00000000 flags 00000067
   mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: clock 450000Hz busmode 2 powermode 2 cs 0 Vdd 15 width 0
   mmc0: starting CMD9 arg 019a0000 flags 00000007
   mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000
   mmc0: selected 24.000MHz transfer rate
   mmc0: clock 24000000Hz busmode 2 powermode 2 cs 0 Vdd 15 width 0
   mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0

It seems that the driver doesn't recognize the card.

Any suggestions? Do you think that the controller is talking with the
card?

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
