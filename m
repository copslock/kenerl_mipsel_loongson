Received:  by oss.sgi.com id <S42267AbQGaAjK>;
	Sun, 30 Jul 2000 17:39:10 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40831 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42277AbQGaAjA>; Sun, 30 Jul 2000 17:39:00 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA00777
	for <linux-mips@oss.sgi.com>; Sun, 30 Jul 2000 17:44:49 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA28350
	for <linux@engr.sgi.com>;
	Sun, 30 Jul 2000 17:38:37 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-101.karlsruhe.ipdial.viaginterkom.de (u-101.karlsruhe.ipdial.viaginterkom.de [62.180.19.101]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA00745
	for <linux@engr.sgi.com>; Sun, 30 Jul 2000 17:38:35 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868832AbQG3L31>;
        Sun, 30 Jul 2000 13:29:27 +0200
Date:   Sun, 30 Jul 2000 13:29:27 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, jpuhlman@mvista.com
Subject: Re: Bus error of gdb 5.0 with MIPS patch
Message-ID: <20000730132927.C6603@bacchus.dhis.org>
References: <398300E5.143F5370@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <398300E5.143F5370@mvista.com>; from jsun@mvista.com on Sat, Jul 29, 2000 at 09:05:57AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jul 29, 2000 at 09:05:57AM -0700, Jun Sun wrote:

> I started to play with gdb 5.0 + the MIPS patch at
> http://www.ds2.pg.gda.pl/~macro/gdb-5.0/, but I am having a bus error if
> I want to do 'next step'.  Setting breakpoints and continuing running
> seem to be fine.
> 
> The gdb 4.17 rpm from oss.sgi.com does not have this problem.
> 
> Any idea?

Possibly this was one of the cacheflush bugs I recently fixed.

> (gdb) n
> [tcsetpgrp failed in terminal_inferior: Not a typewriter]
> Bus error
> 
> -----------
> 
> P.S., Does anybody know how to fix "tcsetpgrp ..." error?

No idea, never seen / heared about this problem.

  Ralf
