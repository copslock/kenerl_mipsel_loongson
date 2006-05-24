Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 17:11:25 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:13319 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133716AbWEXPLR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 17:11:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 97E7EF5965;
	Wed, 24 May 2006 17:11:09 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17574-04; Wed, 24 May 2006 17:11:09 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 35568E1C61;
	Wed, 24 May 2006 17:11:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4OFBIuN008859;
	Wed, 24 May 2006 17:11:18 +0200
Date:	Wed, 24 May 2006 16:11:12 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	art <art@sigrand.ru>, linux-mips@linux-mips.org
Subject: Re: Problem with TLB mcheck!
In-Reply-To: <20060524144917.GA11657@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0605241605120.7887@blysk.ds.pg.gda.pl>
References: <19691.060524@sigrand.ru> <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl>
 <20060524144917.GA11657@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1479/Wed May 24 07:17:23 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 May 2006, Ralf Baechle wrote:

> Depends on when exactly a CPU will raise the machine check.  On some cores
> the information in registers is totally useless if not even missloading.

 We have got PRId to filter out these.  Though rev. 2 of the architecture 
limits conditions when to raise the exception so it may eventually be a 
non-issue.

> But generally a good idea, patch below.

 Except Index would be a bit more useful than HI. ;-)

  Maciej
