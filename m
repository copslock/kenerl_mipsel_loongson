Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:52:20 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:27143 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226182AbULBAwP>; Thu, 2 Dec 2004 00:52:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5901BE1C94; Thu,  2 Dec 2004 01:52:08 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11712-09; Thu,  2 Dec 2004 01:52:08 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DD581E1C61; Thu,  2 Dec 2004 01:52:07 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iB20qHG1015268;
	Thu, 2 Dec 2004 01:52:18 +0100
Date: Thu, 2 Dec 2004 00:52:04 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] 2.4: Preemption fixes for Broadcom DMA Page operations
In-Reply-To: <20041202003308.GA13085@prometheus.mvista.com>
Message-ID: <Pine.LNX.4.58L.0412020041420.20966@blysk.ds.pg.gda.pl>
References: <20041202003308.GA13085@prometheus.mvista.com>
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
X-archive-position: 6538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Dec 2004, Manish Lachwani wrote:

> The attached patch implements preempt_disable/preempt_enable around the
> SB1 DMA page operations. Please review ...

 Why is it needed?

 Also I think these:

-   if [ "$CONFIG_SIBYTE_SB1250" = "y" ]; then
+   if [ "$CONFIG_SIBYTE_BOARD" = "y" ]; then

are unrelated and inaccurate.  The devices are internal to the SoCs and 
not strictly board-dependent.  How about:

+   if [ "$CONFIG_SIBYTE_SB1250" = "y" || "$CONFIG_SIBYTE_BCM112X" = "y"]; then

at the very least, or perhaps using reverse dependencies?

 Maciej
