Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2005 12:28:48 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:59652 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224772AbVIBL22>; Fri, 2 Sep 2005 12:28:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4BD9EE1CB1
	for <linux-mips@linux-mips.org>; Fri,  2 Sep 2005 13:34:51 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30519-05 for <linux-mips@linux-mips.org>;
 Fri,  2 Sep 2005 13:34:51 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1EF2BE1C84
	for <linux-mips@linux-mips.org>; Fri,  2 Sep 2005 13:34:51 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j82BYrLj000506
	for <linux-mips@linux-mips.org>; Fri, 2 Sep 2005 13:34:53 +0200
Date:	Fri, 2 Sep 2005 12:35:00 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050902095417Z8224772-3678+8160@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0509021231390.19580@blysk.ds.pg.gda.pl>
References: <20050902095417Z8224772-3678+8160@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1053/Fri Sep  2 09:01:53 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 2 Sep 2005 ths@linux-mips.org wrote:

> Modified files:
> 	arch/mips/mm   : c-r4k.c 
> 
> Log message:
> 	Fix r4600 revision bitmask.

 This change is broken.  The new masked out value may match a 
MIPS32/MIPS64 architecture CPU.  What was wrong with the old mask?

  Maciej
