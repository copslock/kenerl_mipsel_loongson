Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f73Fdos13791
	for linux-mips-outgoing; Fri, 3 Aug 2001 08:39:50 -0700
Received: from dea.waldorf-gmbh.de (u-54-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.54])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f73FdjV13767
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 08:39:47 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f73DU4x30746;
	Fri, 3 Aug 2001 15:30:04 +0200
Date: Fri, 3 Aug 2001 15:30:04 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: xtime declaration
Message-ID: <20010803153004.B30319@bacchus.dhis.org>
References: <20010803024501.A27708@bacchus.dhis.org> <20010803115935.B26278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010803115935.B26278@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, Aug 03, 2001 at 11:59:35AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 03, 2001 at 11:59:35AM +0200, Thiemo Seufer wrote:

> > That's a bug which got fixed in the latest kernels by removing the
> > volatile from the sched.h declaration.
> 
> And since timer.c kept the volatile definition, it does not compile
> now. The volatile should either be removed in timer.c or added in
> sched.h, I don't know what is right.

Remove the volatile from timer.c; that's what's in 2.4.7.

  Ralf
