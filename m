Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2005 19:51:40 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:45319 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225406AbVBXTvY>; Thu, 24 Feb 2005 19:51:24 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 60B63E1CBC; Thu, 24 Feb 2005 20:51:16 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06942-07; Thu, 24 Feb 2005 20:51:16 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 14065E1CB5; Thu, 24 Feb 2005 20:51:16 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1OJpGpt002603;
	Thu, 24 Feb 2005 20:51:16 +0100
Date:	Thu, 24 Feb 2005 19:51:26 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	libc-alpha@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
In-Reply-To: <421DE686.6040003@gentoo.org>
Message-ID: <Pine.LNX.4.61L.0502241449210.22251@blysk.ds.pg.gda.pl>
References: <421BCF34.90308@jg555.com> <421BD616.4030101@avtrex.com>
 <Pine.LNX.4.61L.0502231300200.11922@blysk.ds.pg.gda.pl> <421DE686.6040003@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 24 Feb 2005, Kumba wrote:

> The debian patch I referenced is what we require for glibc to generate a
> proper syscalls.h for 2.4 kernels.  Unknown on the 2.6 kernel front how that

 Well, glibc 2.3.4 works out of the box with 2.4.  Perhaps you've had 
problems with an older revision.

> patch affects things.  I'll have to see if this patch affects/changes anything
> for either headers version.

 It works for me with current 2.6.  It requires a small obvious update due 
to changes to _MIPS_SIM macros.

  Maciej
