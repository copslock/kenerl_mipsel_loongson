Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6R3Ib906665
	for linux-mips-outgoing; Thu, 26 Jul 2001 20:18:37 -0700
Received: from dea.waldorf-gmbh.de (u-179-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.179])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6R3IYV06660
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 20:18:35 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6R3IOC15151;
	Fri, 27 Jul 2001 05:18:24 +0200
Date: Fri, 27 Jul 2001 05:18:24 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: [patch] fix profiling in glibc for Linux/MIPS
Message-ID: <20010727051823.B14716@bacchus.dhis.org>
References: <20010726103922.A6643@nevyn.them.org> <20010727024820.B27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010727024820.B27008@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, Jul 27, 2001 at 02:48:20AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 27, 2001 at 02:48:20AM +0200, Thiemo Seufer wrote:
> Date: Fri, 27 Jul 2001 02:48:20 +0200
> To: linux-mips@oss.sgi.com
> Subject: Re: [patch] fix profiling in glibc for Linux/MIPS
> From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
> 
> Daniel Jacobowitz wrote:
> > _mcount was doing awful things to its caller's stack frame.
> 
> Maybe I'm missing something, but both the old and the new code
> add 8 byte more to sp than they subtracted before. How is this
> supposed to work?

_mcount has some odd special calling convention.  I don't recall any official
standard that defines _mcount's calling convention but gcc uses it the
same way as the proprietary compiler I tried.

  Ralf
