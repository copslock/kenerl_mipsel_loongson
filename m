Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 12:51:45 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:57360 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225004AbUGWLvj>; Fri, 23 Jul 2004 12:51:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E9997E1C7E; Fri, 23 Jul 2004 13:51:33 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21901-02; Fri, 23 Jul 2004 13:51:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B0C59E1C66; Fri, 23 Jul 2004 13:51:33 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i6NBpfU5022235;
	Fri, 23 Jul 2004 13:51:42 +0200
Date: Fri, 23 Jul 2004 13:51:34 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Srinivas Kommu <kommu@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mips32 kernel memory mapping
In-Reply-To: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com>
Message-ID: <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl>
References: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 23 Jul 2004, Srinivas Kommu wrote:

> Can a 32-bit mips kernel access beyond KSEG0 contiguously? I have a Sibyte 
> 1250 with 1 Gig RAM, but only 256 MB is located at phyical 0x0. The rest is 
> all located at 0x8000_0000. Does that mean the kernel can access only 256 
> meg contiguously? Do I need to enabled CONFIG_HIGHMEM to even reach the 
> remaining RAM? It appears Highmem gives me only a 4 meg window at a time. 

 The BCM1250A is a 64-bit processor.  What's the problem with using 64-bit
Linux avoiding the hassle altogether?

> Can't I set up a page mapping into KSEG2 for the rest of the memory? KSEG2 
> seems to be unused from what I read.

 KSEG2 is used for modules.

  Maciej
