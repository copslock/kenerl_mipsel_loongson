Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 17:36:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:64782 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133569AbWDGQg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Apr 2006 17:36:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D8849F7F15;
	Fri,  7 Apr 2006 18:47:41 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18035-06; Fri,  7 Apr 2006 18:47:41 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A2AE0F6F50;
	Fri,  7 Apr 2006 18:46:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k37GkCC0027642;
	Fri, 7 Apr 2006 18:46:12 +0200
Date:	Fri, 7 Apr 2006 17:46:06 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] use CONFIG_HZ
In-Reply-To: <20060408.010348.41197502.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0604071742220.12718@blysk.ds.pg.gda.pl>
References: <20060407.011000.77652835.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0604071156350.25570@blysk.ds.pg.gda.pl>
 <20060407115323.GB5909@linux-mips.org> <20060408.010348.41197502.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.1/1381/Fri Apr  7 14:54:35 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 8 Apr 2006, Atsushi Nemoto wrote:

> Make HZ configurable (DECSTATION can select 128/256/1024 HZ, JAZZ can
> only select 100 HZ, others can select 48/100/128/250/256/1000/1024
> HZ).  Also remove all mach-xxx/param.h files and update all defconfigs
> according to current HZ value.

 Thanks.  I've got a suggestion SEAD (sead_defconfig) should use 100Hz by 
default too and given its usual setup I can't agree more.

  Maciej
