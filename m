Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2004 17:44:24 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:36107 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225281AbUK1RoT>; Sun, 28 Nov 2004 17:44:19 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 40826F5971; Sun, 28 Nov 2004 18:44:12 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05295-03; Sun, 28 Nov 2004 18:44:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E9972F596B; Sun, 28 Nov 2004 18:44:11 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iASHiONT026781;
	Sun, 28 Nov 2004 18:44:25 +0100
Date: Sun, 28 Nov 2004 17:44:16 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: sjhill@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20041128115336.GB14004@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411281722090.18191@blysk.ds.pg.gda.pl>
References: <20041127061929Z8224786-1751+2584@linux-mips.org>
 <Pine.LNX.4.58L.0411272202100.12787@blysk.ds.pg.gda.pl>
 <20041127231543.GA14252@linux-mips.org> <Pine.LNX.4.58L.0411280138200.27645@blysk.ds.pg.gda.pl>
 <20041128115336.GB14004@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/605/Wed Nov 24 15:09:47 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 28 Nov 2004, Ralf Baechle wrote:

> >  Anyone is free to bump their console/syslog loglevel to get rid of less
> > important messages to suit there preferences.  And INFO, which is what the
> > message uses, is the lowest level for stuff for non-developers.
> 
> As a deterring example why I try to cut down on system messages checkout:
> 
>   http://www.linux-mips.org/wiki/index.php/IP27_boot_messages
> 
> 70kB of little information crawling over a 19k2 console making kernel
> startup an entertaining experience for the whole family ;-)

 Why don't you boot at 115200bps then?  I do that with my DECstations
(well, since I've fixed their serial console to support it).  Otherwise
there's that "quiet" argument to bump the console loglevel.

 Besides the SWARM and friends boot at 115200bps by default anyway and
their average bootstrap log size is around 7kB... ;-)

  Maciej
