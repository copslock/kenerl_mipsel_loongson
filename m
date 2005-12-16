Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2005 16:18:18 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:18414 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133454AbVLPQSB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Dec 2005 16:18:01 +0000
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1EnII6-0007Qv-00
	for <linux-mips@linux-mips.org>; Fri, 16 Dec 2005 17:18:42 +0100
Date:	Fri, 16 Dec 2005 17:18:42 +0100
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: Irda support for au1100
Message-ID: <20051216161842.GN14341@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Doing:

   giometti@vvonth:/home/develop/linux.git$ rgrep CONFIG_AU1000_FIR *
   drivers/net/irda/Makefile:obj-$(CONFIG_AU1000_FIR)	+= au1k_ir.o

so I suppose that current Irda support for au1100 is broken... is that
right? :)

Some suggestions in order to help me to port it to the current kernel
release?

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
