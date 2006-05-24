Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 17:52:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:65474 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133723AbWEXPwH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2006 17:52:07 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4OFq76Z029711;
	Wed, 24 May 2006 16:52:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4OFq7h9029710;
	Wed, 24 May 2006 16:52:07 +0100
Date:	Wed, 24 May 2006 16:52:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	art <art@sigrand.ru>, linux-mips@linux-mips.org
Subject: Re: Problem with TLB mcheck!
Message-ID: <20060524155207.GB25452@linux-mips.org>
References: <19691.060524@sigrand.ru> <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl> <20060524144917.GA11657@linux-mips.org> <Pine.LNX.4.64N.0605241605120.7887@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0605241605120.7887@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 24, 2006 at 04:11:12PM +0100, Maciej W. Rozycki wrote:

> > Depends on when exactly a CPU will raise the machine check.  On some cores
> > the information in registers is totally useless if not even missloading.
> 
>  We have got PRId to filter out these.  Though rev. 2 of the architecture 
> limits conditions when to raise the exception so it may eventually be a 
> non-issue.

Doesn't really help, the exception is asynchronous by definition, so the
CPU can be far away by the time it's struck be the lightning bolt.
Machine check is just a _bad_ place to be.

> > But generally a good idea, patch below.
> 
>  Except Index would be a bit more useful than HI. ;-)

Index may not matter at all in case of a TLBWR.  But yes, will include
index in the patch.

  Ralf
