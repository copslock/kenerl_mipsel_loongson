Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Feb 2005 16:48:25 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:11027 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225411AbVBYQsG>; Fri, 25 Feb 2005 16:48:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 723ABE1C84
	for <linux-mips@linux-mips.org>; Fri, 25 Feb 2005 17:47:55 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28818-04 for <linux-mips@linux-mips.org>;
 Fri, 25 Feb 2005 17:47:55 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 26E7DE1C6B
	for <linux-mips@linux-mips.org>; Fri, 25 Feb 2005 17:47:55 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1PGlwuu027572
	for <linux-mips@linux-mips.org>; Fri, 25 Feb 2005 17:47:59 +0100
Date:	Fri, 25 Feb 2005 16:48:06 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050225131124Z8225457-1340+3673@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0502251647090.9216@blysk.ds.pg.gda.pl>
References: <20050225131124Z8225457-1340+3673@linux-mips.org>
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
X-archive-position: 7341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 25 Feb 2005 ths@linux-mips.org wrote:

> Modified files:
> 	arch/mips/mm   : pg-sb1.c 
> 
> Log message:
> 	Fix initialization. Unbreak the wait-for-completion loops. Code cleanup.

 Don't use a cast on IOADDR() -- it already returns "void *".  The casts 
obfuscate code and make it difficult to spot incorrect use if the API ever 
changes.

  Maciej
