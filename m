Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PIiZRw022237
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 11:44:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PIiZQT022236
	for linux-mips-outgoing; Thu, 25 Jul 2002 11:44:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PIiRRw022227
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 11:44:28 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17Xnbz-0002TJ-00; Thu, 25 Jul 2002 20:45:19 +0200
Date: Thu, 25 Jul 2002 20:45:19 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
Message-ID: <20020725184519.GB9302@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
	linux-mips@oss.sgi.com
References: <00ce01c229a4$a7d4ed40$10eca8c0@grendel> <20020719123828.GA5521@convergence.de> <20020725162539.GA8804@convergence.de> <3D40302F.40806@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D40302F.40806@mvista.com>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 25, 2002 at 10:06:55AM -0700, Jun Sun wrote:
> Johannes Stezenbach wrote:
> >sysmips:
> >        real    1m19.358s
> >        user    0m28.150s
> >        sys     0m47.250s
> >
> >LL/SC emulation:
> >        real    0m41.246s
> >        user    0m25.390s
> >        sys     0m12.240s
> >
> >branch-likely hack (hm, still without kernel patch...):
> >        real    0m25.126s
> >        user    0m17.240s
> >        sys     0m2.310s
> 
> Johannes,
> 
> This is great stuff!  Can you explain what are "real", "user", and "sys"? 
> Also, what is your initial conclusion?

This are results from simple 'time ./testapp' testing, so its real time
and user/system time reported by wait(4).

Also, I have an interactive gtk+directfb applicaton running. The
difference in response time is quite noticable.

On reason for the big differences is that the Glib-2.0/GObject library
does a lot of locking in its internal type system for every object
created. Other software might not suffer as badly from a slow mutex
implementation.

My conclusion is that it is good for glibc to always use ll/sc,
emulated or not, and for my specific needs I will use the branch-likely
hack. So next I will study kernel source to decide what MAGIC_COOKIE
is best for the branch-likely hack, and where to add 'move k1,$0'
before eret.

OTOH I doubt it's worth it to add the branch-likely hack to
stock glibc. How many people are using Linux/MIPS on embedded
CPU's without LL/SC?


Johannes
