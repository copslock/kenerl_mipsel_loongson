Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 13:56:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:11027 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225225AbUHWM4v>; Mon, 23 Aug 2004 13:56:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1D6FBE1C91; Mon, 23 Aug 2004 14:56:47 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18882-01; Mon, 23 Aug 2004 14:56:47 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DEF54E1C63; Mon, 23 Aug 2004 14:56:46 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i7NCutot013954;
	Mon, 23 Aug 2004 14:56:56 +0200
Date: Mon, 23 Aug 2004 14:56:49 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Srinivas Kommu <kommu@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: mips32 kernel memory mapping
In-Reply-To: <20040820081832.GD15543@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0408231455250.19572@blysk.ds.pg.gda.pl>
References: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com>
 <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl> <20040723202439.GA3711@linux-mips.org>
 <Pine.LNX.4.58L.0407261258010.3873@blysk.ds.pg.gda.pl>
 <20040820081832.GD15543@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 20 Aug 2004, Ralf Baechle wrote:

> I have 1GB and that's where 32-bit kernels are beginning to look really
> like a bad idea on MIPS.  Fortunately on the BCM1250 and all the other
> 64-bit processors there is an easy way out.  Better even, some of the
> embedded application performance numbers suggest significant performance
> gains for 64-bit processing contrary to conventional wisdom about 64-bit
> computing.

 But large memory holes are not necessarily nice anyway.

  Maciej
