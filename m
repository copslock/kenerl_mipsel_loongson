Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2009 11:32:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28863 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21102784AbZCMLcn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2009 11:32:43 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2DBWeHB023954;
	Fri, 13 Mar 2009 12:32:40 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2DBWcud023952;
	Fri, 13 Mar 2009 12:32:38 +0100
Date:	Fri, 13 Mar 2009 12:32:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	VomLehn <dvomlehn@cisco.com>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] Use CP0 Count register to implement more
	granular ndelay
Message-ID: <20090313113238.GA30049@linux-mips.org>
References: <20090312032850.GA9379@cuplxvomd02.corp.sa.net> <20090313092906.GA6526@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090313092906.GA6526@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 13, 2009 at 10:29:07AM +0100, Thomas Bogendoerfer wrote:

> > +config MIPS4
> > +	bool
> > +	default y if CPU_R8000 || CPU_R10000
> > +
> 
> what about all the R5k CPUs ?

There is cpu_has_counter which return if a processor actually has a cp0
counter.  Also cpu_has_mfc0_count_bug() which indicates usability of
the counter.  The cp0 counter should rather not be used on early R4000
processors, for example.

  Ralf
