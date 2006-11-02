Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 11:39:23 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:59399 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039014AbWKBLjQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Nov 2006 11:39:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 81349F5945;
	Thu,  2 Nov 2006 12:39:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3AMumYVMIbW; Thu,  2 Nov 2006 12:39:08 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 34513E1C73;
	Thu,  2 Nov 2006 12:39:08 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id kA2BdF6P012855;
	Thu, 2 Nov 2006 12:39:15 +0100
Date:	Thu, 2 Nov 2006 11:39:12 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips irq cleanups
In-Reply-To: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0611021134030.7700@blysk.ds.pg.gda.pl>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.5/2146/Thu Nov  2 07:58:29 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Nov 2006, Atsushi Nemoto wrote:

> Though whole this patch is quite large, changes in each irq_chip are
> not quite simple.  Please review and test on your platform.  Thanks.

 You have removed a couple of spinlocks protecting accesses to some 
resources on the DECstation.  This makes me suspicious -- after all I put 
all of them there for a reason, e.g. to make sure shadow variables are 
consistent with write-only registers.  But perhaps you had a valid reason 
to believe with your changes in place they are no needed anymore.  I'll 
have a closer look as soon as possible and will let you know if the 
changes are fine.  Thanks for your work.

 But for now it's a NAK for the DECstation part.

  Maciej
