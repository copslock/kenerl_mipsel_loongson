Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 11:43:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:48142 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225198AbVITKn1>; Tue, 20 Sep 2005 11:43:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 48991F596A; Tue, 20 Sep 2005 12:43:23 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27059-02; Tue, 20 Sep 2005 12:43:23 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C0557F5969; Tue, 20 Sep 2005 12:43:22 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j8KAhL1q001223;
	Tue, 20 Sep 2005 12:43:22 +0200
Date:	Tue, 20 Sep 2005 11:43:27 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix TCP/UDP checksums on the Broadcom SB-1
In-Reply-To: <20050920032818.GA7199@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0509201140160.23494@blysk.ds.pg.gda.pl>
References: <20050920032818.GA7199@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1090/Mon Sep 19 23:29:31 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 Sep 2005, Daniel Jacobowitz wrote:

> This caused incorrect checksums in some UDP packets for NFS root.  The
> problem was mild when using a 10.0.1.x IP address, but severe when
> using 192.168.1.x.

 Ah!  So *that* is the reason for the absolutely abysmal NFS performance 
of the SWARM with 2.6!  I have had no time to track it down -- thanks a 
lot!

  Maciej
