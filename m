Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IKQ3D24922
	for linux-mips-outgoing; Mon, 18 Jun 2001 13:26:03 -0700
Received: from dea.waldorf-gmbh.de (u-95-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.95])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IKQ1V24910
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 13:26:01 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5IKPsp27314;
	Mon, 18 Jun 2001 22:25:54 +0200
Date: Mon, 18 Jun 2001 22:25:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Brian Murphy <brian@murphy.dk>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Profiling support in glibc?
Message-ID: <20010618222554.B26781@bacchus.dhis.org>
References: <3B2E5163.D130FA01@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B2E5163.D130FA01@murphy.dk>; from brian@murphy.dk on Mon, Jun 18, 2001 at 09:07:15PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 18, 2001 at 09:07:15PM +0200, Brian Murphy wrote:

> What is the status of profiling in glibc? Our (egcs-1.1.2 based)
> compiler fails with a missing symbol
> _start (glibc 2.0.6) but even if one fixes this up there are more
> fundamental problems.
> 
> Is there a later glibc for which profiling works?

I've never tried profiling but remember from looking at the source of
glibc 2.0.6 that there were rather obvious bugs.  Also you shouldn't
assume that anybody of the core developers has interest in wasting any
work into 2.0.6 since 2.2 is so much better so you may want to upgrade
anyway.

The other issue is of course gprof ...

  Ralf
