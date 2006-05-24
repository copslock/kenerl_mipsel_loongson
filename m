Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 18:29:57 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32006 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133765AbWEXQ3s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 18:29:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id AE9F2F5E66;
	Wed, 24 May 2006 18:29:41 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21953-02; Wed, 24 May 2006 18:29:41 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5B6CEF5E54;
	Wed, 24 May 2006 18:29:41 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4OGTpRF003915;
	Wed, 24 May 2006 18:29:51 +0200
Date:	Wed, 24 May 2006 17:29:45 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	art <art@sigrand.ru>, linux-mips@linux-mips.org
Subject: Re: Problem with TLB mcheck!
In-Reply-To: <20060524155207.GB25452@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0605241659440.7887@blysk.ds.pg.gda.pl>
References: <19691.060524@sigrand.ru> <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl>
 <20060524144917.GA11657@linux-mips.org> <Pine.LNX.4.64N.0605241605120.7887@blysk.ds.pg.gda.pl>
 <20060524155207.GB25452@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1479/Wed May 24 07:17:23 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 May 2006, Ralf Baechle wrote:

> >  We have got PRId to filter out these.  Though rev. 2 of the architecture 
> > limits conditions when to raise the exception so it may eventually be a 
> > non-issue.
> 
> Doesn't really help, the exception is asynchronous by definition, so the
> CPU can be far away by the time it's struck be the lightning bolt.
> Machine check is just a _bad_ place to be.

 It does help -- while it is asynchronous indeed, TLB writes are far rarer 
than reads and happen in well defined places and a machine check will 
happen within limited time after such a write attempt, at the very worst.  
With the 4Kc the machine check looks synchronous.

  Maciej
