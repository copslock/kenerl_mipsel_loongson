Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 12:41:46 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:26849 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030366AbXKGMlh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 12:41:37 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9534D40094;
	Wed,  7 Nov 2007 13:41:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id NX8eOQjJ1C6Y; Wed,  7 Nov 2007 13:41:29 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id CE4444007E;
	Wed,  7 Nov 2007 13:41:29 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lA7CfWJP026006;
	Wed, 7 Nov 2007 13:41:32 +0100
Date:	Wed, 7 Nov 2007 12:41:29 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][au1000] Remove useless EXTRA_CFLAGS
In-Reply-To: <20071029151010.GA3953@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0711071239560.14970@blysk.ds.pg.gda.pl>
References: <200710252108.43357.florian.fainelli@telecomint.eu>
 <20071029151010.GA3953@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4691/Wed Nov  7 06:39:41 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 29 Oct 2007, Ralf Baechle wrote:

> And to ensure it will stay that way I'll keep -Werror.  It seems only
> little PITAs like this keep everybody on their toes :-)

 Yeah...  If only GCC had no bugs and always had a clue of what to warn 
about...

  Maciej
