Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Mar 2009 20:12:36 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60126 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21367157AbZCJUMe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Mar 2009 20:12:34 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2AKCSH0015973;
	Tue, 10 Mar 2009 21:12:29 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2AKCPj0015970;
	Tue, 10 Mar 2009 21:12:25 +0100
Date:	Tue, 10 Mar 2009 21:12:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	VomLehn <dvomlehn@cisco.com>
Cc:	Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] Use CP0 Count register to implement more
	granular ndelay
Message-ID: <20090310201224.GA12379@linux-mips.org>
References: <20090227230950.GA29546@cuplxvomd02.corp.sa.net> <7d1d9c250902281310o7c03da24jcb8760fdfef4d46b@mail.gmail.com> <20090310191828.GA30449@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090310191828.GA30449@cuplxvomd02.corp.sa.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 10, 2009 at 12:18:28PM -0700, VomLehn wrote:

> > > +config CP0_COUNT_NDELAY
> > > +       bool "Use coprocessor 0 Count register for ndelay functionality"
> > > +       default n
> > 
> > Does there need to be some sort of depends here to cover off any
> > limitations where it is known that it won't work?
> 
> I don't have the breadth of knowledge required to say what processors have
> a CP0 Count register. Any suggestions?

All MIPS III, MIPS IV, MIPS32 and MIPS64 processors have a 32-bit count
register which typically is clocked at half the maximum instruction issue
rate, more rarely at the full rate.  A few processors like the RM53230
family can select the increment rate at reset-time to either the full or
half instruction issue rate.  Others have the option of totally halting
it in special low-power, low-performance modes.  The count rate might also
be affected by clock scaling.

  Ralf
