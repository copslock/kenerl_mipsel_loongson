Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 19:16:50 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:34566 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224935AbUKRTQo>; Thu, 18 Nov 2004 19:16:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3786EF59AF; Thu, 18 Nov 2004 20:16:37 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30969-02; Thu, 18 Nov 2004 20:16:37 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 73468E1CB6; Thu, 18 Nov 2004 20:16:34 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAIJGhoP028423;
	Thu, 18 Nov 2004 20:16:43 +0100
Date: Thu, 18 Nov 2004 19:16:38 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@prometheus.mvista.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Compile in the serial driver for TX4927
In-Reply-To: <20041118184950.GA3482@prometheus.mvista.com>
Message-ID: <Pine.LNX.4.58L.0411181916130.30376@blysk.ds.pg.gda.pl>
References: <20041118184950.GA3482@prometheus.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/590/Wed Nov 17 22:03:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 18 Nov 2004, Manish Lachwani wrote:

> Attached small patch compiles in the serial driver (serial_txx9.c) for
> Toshiba TX4927.
> Thanks for Ralf Roesch for pointing this out

 Applied as obvious, thanks.

  Maciej
