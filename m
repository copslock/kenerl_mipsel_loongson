Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 03:52:58 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:58889 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225395AbULPDwx>; Thu, 16 Dec 2004 03:52:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D2506F5995; Thu, 16 Dec 2004 04:52:41 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14318-08; Thu, 16 Dec 2004 04:52:41 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 96013F5994; Thu, 16 Dec 2004 04:52:41 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iBG3qf9X014509;
	Thu, 16 Dec 2004 04:52:41 +0100
Date: Thu, 16 Dec 2004 03:52:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: sjhill@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20041216030425Z8225321-1751+3720@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0412160345400.26904@blysk.ds.pg.gda.pl>
References: <20041216030425Z8225321-1751+3720@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/617/Sun Dec  5 16:25:39 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 16 Dec 2004 sjhill@linux-mips.org wrote:

> Modified files:
> 	drivers/i2c    : Kconfig 
> 	drivers/i2c/chips: adm1021.c 
> Removed files:
> 	drivers/i2c    : i2c-max1617.c 
> 
> Log message:
> 	Remove obsolete MAX1617 driver code. The 'adm1021' driver handles both
> 	the 1617 and 1617a with a minor modification. This chip now works properly
> 	on SiByte Swarm boards.

 The removal is welcome, but the change to adm1021.c is broken.  You
should set I2C_CLASS_HWMON for the SiByte I2C adapter instead.  Please fix
your commit.  Thanks.

  Maciej
