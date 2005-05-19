Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2005 16:19:36 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:65039 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225993AbVESPTO>; Thu, 19 May 2005 16:19:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1A817F59E5; Thu, 19 May 2005 17:19:04 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02322-02; Thu, 19 May 2005 17:19:03 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BEE41F5945; Thu, 19 May 2005 17:19:03 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j4JFJ6UX022822;
	Thu, 19 May 2005 17:19:06 +0200
Date:	Thu, 19 May 2005 16:19:14 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Michael Belamina <belamina1@yahoo.com>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: 64 bit kernel for BCM1250
In-Reply-To: <20050519135207.7760.qmail@web32510.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0505191605350.10681@blysk.ds.pg.gda.pl>
References: <20050519135207.7760.qmail@web32510.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/886/Wed May 18 12:32:36 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 19 May 2005, Michael Belamina wrote:

>    I am still not sure about the following:
> 
>    1. Is this problem related only to kernels
> downloaded from linux-mips.org or it is a more general
> one?

 The problem is Linux 2.4 is generally in the maintenance mode, which 
means no new development is done on it (although still an occasional 
backport from 2.6 may happen).  As a result maintainers are rather 
hesitant about applying changes unless they fix critical bugs.  Bugs 
revealed by new versions of build tools are not usually considered as 
critical, because you may work them around by using an old version of the 
triggering tool.

 Still for the MIPS port what you can get from linux-mips.org is probably 
less behind than what there is at kernel.org.

>    2. Can someone point to a known to work 64 bit
> versions of gcc and binutil for BCM1250 (the problem
> that started this thread was actually a problem of the
> mip64-linux-ld I was using).

 For 64-bit builds you probably want to use fairly recent versions or you 
risk hitting serious bugs that used to exist in older versions.  Using 
David's patch (or preferably mine ;-) -- as available here: 
"http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.55.0406281509170.23162%40jurand.ds.pg.gda.pl"; 
which I keep using with GCC 4.0.0) is probably the lesser evil.

  Maciej
