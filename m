Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 11:19:41 +0100 (BST)
Received: from adsl-72-19.38-151.net24.it ([IPv6:::ffff:151.38.19.72]:3208
	"EHLO zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225351AbVEFKT1>; Fri, 6 May 2005 11:19:27 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DTzvY-0006oQ-00
	for <linux-mips@linux-mips.org>; Fri, 06 May 2005 12:19:24 +0200
Date:	Fri, 6 May 2005 12:19:24 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: Useful (missing) patches for DB1100
Message-ID: <20050506101924.GC25371@enneenne.com>
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
X-archive-position: 7877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

As described in this message
«http://www.spinics.net/lists/mips/msg18375.html» I suggest to you to
apply the patches to files au1000_generic.c and au1000_generic.h (in
the current CVS version) in order to avoid a run time error in the
PCMCIA support and a compilation warning. :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127
