Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4EL5g923174
	for linux-mips-outgoing; Mon, 14 May 2001 14:05:42 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4EL5cF23169
	for <linux-mips@oss.sgi.com>; Mon, 14 May 2001 14:05:39 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4EKsux10013;
	Mon, 14 May 2001 17:54:56 -0300
Date: Mon, 14 May 2001 17:54:55 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: Rafal Boni <rafal.boni@eDial.com>, linux-mips@oss.sgi.com
Subject: Re: SGI O2 Port
Message-ID: <20010514175455.B9383@bacchus.dhis.org>
References: <20010512185211.C3092@foobazco.org> <200105141204.IAA19260@ninigret.metatel.office> <20010514081039.B18935@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010514081039.B18935@foobazco.org>; from wesolows@foobazco.org on Mon, May 14, 2001 at 08:10:39AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 14, 2001 at 08:10:39AM -0700, Keith M Wesolowski wrote:

> > What CPU's are supported currently?  Just the R5000, or are the R10k/R12k
> > supported as well?  (I realize that the latter two are harder to support,
> > but thought I'd ask nevertheless).
> 
> I have never built it for anything but r5k.  It's very likely that
> 52x0 will also run fine.  In theory r10k/r12k should work.  In
> practice, however, I suspect that differences in the crime controllers
> will make it impossible to boot; I can probably fix that.  As we run
> uncached only at this time anyway, the spec writes thing should not be
> an issue.

Only an issue for R10k; R12k and beyond are sane in that respect.

  Ralf
