Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 14:21:30 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:20232 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133401AbWEKMVW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 14:21:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D6B7DF5F85;
	Thu, 11 May 2006 14:21:17 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15766-07; Thu, 11 May 2006 14:21:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6A0BAF5F2E;
	Thu, 11 May 2006 14:21:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4BCLN6L023860;
	Thu, 11 May 2006 14:21:24 +0200
Date:	Thu, 11 May 2006 13:21:20 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	karsten@excalibur.cologne.de, linux-mips@linux-mips.org
Subject: Re: pmag* drivers don't build on 2.6
In-Reply-To: <20060510204601.GA23786@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0605111305490.20004@blysk.ds.pg.gda.pl>
References: <20060510204601.GA23786@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1456/Thu May 11 07:57:31 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 May 2006, Martin Michlmayr wrote:

> The pmag* fb drivers (DECstation) don't build on 2.6.  Can someone
> port them to the 2.6 api (and possibly merge both files into one)?

 The pmag-ba-fb and pmagb-b-fb drivers have been ported.  If there is any 
problem with them, then I'd like to know about that.

 The pmag-aa-fb driver has not been ported.  I may have a look at it, but 
I have no hardware to test any changes with.

 I don't see any point in merging any set of these drivers together -- 
they support cards of completely different architecture each.  OTOH, 
merging the pmagb-b-fb driver with tgafb may make sense one day.

  Maciej
