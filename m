Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 23:27:15 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:23056 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225325AbVBAX07>; Tue, 1 Feb 2005 23:26:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E1FD2E1CD3; Wed,  2 Feb 2005 00:26:51 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28240-08; Wed,  2 Feb 2005 00:26:51 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BE00EE1CA4; Wed,  2 Feb 2005 00:26:51 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j11NQvjl018162;
	Wed, 2 Feb 2005 00:26:57 +0100
Date:	Tue, 1 Feb 2005 23:27:11 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix Kconfig for Broadcom SWARM
In-Reply-To: <420008BA.6070104@mvista.com>
Message-ID: <Pine.LNX.4.61L.0502012311290.18883@blysk.ds.pg.gda.pl>
References: <20050201202835.GA10788@prometheus.mvista.com>
 <Pine.LNX.4.61L.0502012241010.18883@blysk.ds.pg.gda.pl> <420008BA.6070104@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 1 Feb 2005, Manish Lachwani wrote:

> libs-$(CONFIG_SIBYTE_CFE)       += arch/mips/sibyte/cfe/
> 
> in arch/mips/Makefile
> 
> So, without the above, contents of arch/mips/sibyte/cfe/ are not compiled.
> 
> SIBYTE_HAS_LDT is needed for the LDT specific stuff in
> arch/mips/pci/pci-sb1250.c

 Both options are taken care of in arch/mips/sibyte/Kconfig, thus any fix 
should be sought there.

> Btw, there are other issues as well. More options need to be defined to
> compile in the serial driver, ethernet driver and to compile for a PASS 2 CPU.

 Likewise.

> For example, the ethernet driver drivers/net/sb1250-mac.c compiles only if
> SIBYTE_SB1xxx_SOC is defined. And SIBYTE_SB1xxx_SOC no longer exists in
> arch/mips/Kconfig.

 This one is missing indeed.

 I'll have a look at how to get the mess resolved.

  Maciej
