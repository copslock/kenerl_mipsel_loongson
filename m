Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PH57L21462
	for linux-mips-outgoing; Mon, 25 Mar 2002 09:05:07 -0800
Received: from rwcrmhc54.attbi.com (rwcrmhc54.attbi.com [216.148.227.87])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PH54q21456
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 09:05:04 -0800
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc54.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020325170719.JYKU1214.rwcrmhc54.attbi.com@ocean.lucon.org>;
          Mon, 25 Mar 2002 17:07:19 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D1778125C1; Mon, 25 Mar 2002 09:07:17 -0800 (PST)
Date: Mon, 25 Mar 2002 09:07:17 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Peter Hartley <PDHartley@sonicblue.com>
Cc: Andrew Morton <akpm@zip.com.au>, tytso@thunk.org, linux-mips@oss.sgi.com,
   linux kernel <linux-kernel@vger.kernel.org>,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020325090717.A13707@lucon.org>
References: <37D1208A1C9BD511855B00D0B772242C011C7F13@corpmail1.sc.sonicblue.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <37D1208A1C9BD511855B00D0B772242C011C7F13@corpmail1.sc.sonicblue.com>; from PDHartley@sonicblue.com on Mon, Mar 25, 2002 at 02:52:24AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Mar 25, 2002 at 02:52:24AM -0800, Peter Hartley wrote:
> H J Lu wrote:
> > I look at the glibc code. It uses a constant RLIM_INFINITY for a given
> > arch. The user always passes (~0UL) to glibc on x86. glibc will check
> > if the kernel supports the new getrlimit at the run time. If it
> > doesn't, glibc will adjust the RLIM_INFINITY for setrlimit. I 
> > don't see
> > how glibc 2.2.5 compiled under kernel 2.2 will fail under 2.4 due to
> > this unless glibc is misconfigureed or miscompiled.
> 
> It's not a question of which kernel glibc is compiled under, it's a question
> of which version of the kernel headers (/usr/include/{linux,asm}) glibc is
> compiled against.
> 

What are you talking about? It doesn't matter which kernel header
is used. glibc doesn't even use /usr/include/asm/resource.h nor
should any user space applications.



H.J.
