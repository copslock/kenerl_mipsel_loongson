Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 14:45:22 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:50657 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133530AbWEDNpL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 14:45:11 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1Fbe8j-0007l8-00
	for <linux-mips@linux-mips.org>; Thu, 04 May 2006 15:45:09 +0200
Date:	Thu, 4 May 2006 15:45:09 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: [PATCH] 8250_early console support for au1x00
Message-ID: <20060504134509.GE19913@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Done! :)

Here the patch (against «linux-2.6.16-stable» and tested with au1100
based board):

   http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-patch-au1x00-early-console

My kernel command line has now:

   console=uart,au,0x11100000,115200

so, I suppose, it's important that the serial lines physical addresses
are specified as 0x11100000 and not as 0xB1100000!

Please, note also the «know bugs» section.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
