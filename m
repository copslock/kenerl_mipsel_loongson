Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f739xem04393
	for linux-mips-outgoing; Fri, 3 Aug 2001 02:59:40 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f739xcV04389
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 02:59:38 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id LAA133555
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 11:59:36 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15Sbjz-0000m0-00
	for <linux-mips@oss.sgi.com>; Fri, 03 Aug 2001 11:59:35 +0200
Date: Fri, 3 Aug 2001 11:59:35 +0200
To: linux-mips@oss.sgi.com
Subject: Re: xtime declaration
Message-ID: <20010803115935.B26278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010803024501.A27708@bacchus.dhis.org>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
[snip]
> > timer.c:35: conflicting types for `xtime'
> > /local/chua/public/linux-mips-latest/include/linux/sched.h:540: previous
> > declaration of `xtime'
> > 
> > in include/linux/sched.h:
> > extern struct timeval xtime;
> > 
> > int timer.c:
> > volatile struct timeval xtime __attribute__ ((aligned (16)));
> > 
> > I am using gcc 3.0 and binutils 2.11.2, both of the released versions.
> > I do not know if my kernel actually runs yet with this toolchain...
> 
> That's a bug which got fixed in the latest kernels by removing the
> volatile from the sched.h declaration.

And since timer.c kept the volatile definition, it does not compile
now. The volatile should either be removed in timer.c or added in
sched.h, I don't know what is right.


Thiemo
