Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GKhZx28121
	for linux-mips-outgoing; Mon, 16 Jul 2001 13:43:35 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GKhYV28118
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 13:43:34 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 73543125BC; Mon, 16 Jul 2001 13:43:33 -0700 (PDT)
Date: Mon, 16 Jul 2001 13:43:33 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Mike McDonald <mikemac@mikemac.com>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010716134333.A2045@lucon.org>
References: <20010716130913.A1412@lucon.org> <Pine.GSO.3.96.1010716222350.22824A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010716222350.22824A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 16, 2001 at 10:33:42PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 16, 2001 at 10:33:42PM +0200, Maciej W. Rozycki wrote:
> On Mon, 16 Jul 2001, H . J . Lu wrote:
> 
> > ls shouldn't bother with clock_gettime, which is in librt and librt
> > needs libpthreads. RedHat 7.1 has a similar patch to make 3.79.1 to
> > get around it. Otherwise, make won't work right due to the 2MB stack
> > limit imposed by libpthreads.
> 
>  ls.c contains an explicit reference to clock_gettime() in its
> get_current_time() function.  The reference was added quite recently but
> ChangeLog does not contain a relevant entry.  In any case clock_gettime()
> provides a better resolution than gettimeofday() does.  Did you or someone
> else contacted the maintainer to clarify the issue?  RedHat isn't the
> whole world. 

I am happy to let Red Hat deal with it. FWIW, RedHat 7.1 has
fileutils 4.0.36.


H.J.
