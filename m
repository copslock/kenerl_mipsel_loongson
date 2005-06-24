Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 13:13:38 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:21253 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225550AbVFXMNX>; Fri, 24 Jun 2005 13:13:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DBD6CF596B; Fri, 24 Jun 2005 14:12:27 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26708-06; Fri, 24 Jun 2005 14:12:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8AB73E1CA6; Fri, 24 Jun 2005 14:12:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5OCATsZ000593;
	Fri, 24 Jun 2005 14:10:29 +0200
Date:	Fri, 24 Jun 2005 13:10:36 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: CONFIG_HZ for mips
In-Reply-To: <20050624072214.42175.qmail@web25802.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0506241306300.28452@blysk.ds.pg.gda.pl>
References: <20050624072214.42175.qmail@web25802.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/955/Thu Jun 23 23:08:42 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 24 Jun 2005, moreau francis wrote:

> hmm, each time I sent a patch, it goes into /dev/null. So I believe that is
> because of my poor programming skills, I prefer the job done by someone
> skiller than me ;)

 Then you need to find someone who is interested in writing that stuff for 
you.  Frankly I can't recall any patch addressing HZ from you, but perhaps 
I haven't watched carefully enough.

> I grep for HZ in mips arch and can find only 100, 128 and 1000 values.

 These are values that are currently in use.

> What is the difference between 100 and 128 ?

 -28

  Maciej
