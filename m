Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 15:20:24 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([IPv6:::ffff:81.174.11.161]:11705 "EHLO
	zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225313AbVGVOUD>; Fri, 22 Jul 2005 15:20:03 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DvyPd-0005Eg-00
	for <linux-mips@linux-mips.org>; Fri, 22 Jul 2005 16:22:05 +0200
Date:	Fri, 22 Jul 2005 16:22:05 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: Battery status
Message-ID: <20050722142205.GE21044@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'd like to implement a way to allow userspace to read battery status
(or percentage).  I notice this port of APM interface for ARM
architecture «arch/arm/kernel/apm.c» and I think I can use comething
similar... what do you think about that?

Do someone know a better way to resolve this problem into MIPS
subtree?

Thanks,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127
