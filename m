Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 23:59:41 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:15623 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225219AbUJaX7h>; Sun, 31 Oct 2004 23:59:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D7E0EF5AC5; Mon,  1 Nov 2004 00:59:26 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15252-10; Mon,  1 Nov 2004 00:59:26 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 69403F5AC4; Mon,  1 Nov 2004 00:59:26 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id i9VNxjs3019397;
	Mon, 1 Nov 2004 00:59:45 +0100
Date: Sun, 31 Oct 2004 23:59:31 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Dennis Grevenstein <dennis@pcde.inka.de>
Cc: linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
In-Reply-To: <20041031223612.GA15091@aton.pcde.inka.de>
Message-ID: <Pine.LNX.4.58L.0410312354350.22630@blysk.ds.pg.gda.pl>
References: <20041031184233.GA11120@aton.pcde.inka.de>
 <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl>
 <20041031191631.GB11681@aton.pcde.inka.de> <20041031192653.GG2094@lug-owl.de>
 <20041031195550.GA12397@aton.pcde.inka.de> <20041031201335.GH2094@lug-owl.de>
 <20041031223612.GA15091@aton.pcde.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/552/Tue Oct 26 16:28:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 31 Oct 2004, Dennis Grevenstein wrote:

>         struct tty_struct *tty = up->port.info->tty;    /* XXX info==NULL? */

 It looks up->port.info is null for some reason (and unhandled as noted 
in the comment).

  Maciej
