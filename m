Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 18:51:36 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:16141 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225201AbVCPSvU>; Wed, 16 Mar 2005 18:51:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7D69EF5946; Wed, 16 Mar 2005 19:51:11 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18945-03; Wed, 16 Mar 2005 19:51:11 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 389B0E1CBD; Wed, 16 Mar 2005 19:51:11 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j2GIpGY2016620;
	Wed, 16 Mar 2005 19:51:16 +0100
Date:	Wed, 16 Mar 2005 18:51:26 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050304151343Z8225933-1340+3959@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0503161825470.11863@blysk.ds.pg.gda.pl>
References: <20050304151343Z8225933-1340+3959@linux-mips.org>
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
X-archive-position: 7449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 4 Mar 2005 ralf@linux-mips.org wrote:

> Log message:
> 	On Qube2700 Galileo hangs if we access slot #6.

 Device #31 is reserved with Galileo controllers for generating special 
cycles.  Thus it's a feature rather than an erratum and I think it's worth 
being properly documented in the sources.

  Maciej
