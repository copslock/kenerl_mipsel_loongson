Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1180uZ25548
	for linux-mips-outgoing; Fri, 1 Feb 2002 00:00:56 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1180pd25544
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 00:00:51 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 59746125C3; Thu, 31 Jan 2002 23:00:50 -0800 (PST)
Date: Thu, 31 Jan 2002 23:00:50 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: kaz@ashi.footprints.net, macro@ds2.pg.gda.pl,
   libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
Message-ID: <20020131230050.C32690@lucon.org>
References: <20020201.123523.50041631.machida@sm.sony.co.jp> <Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net> <20020201.135903.123568420.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201.135903.123568420.machida@sm.sony.co.jp>; from machida@sm.sony.co.jp on Fri, Feb 01, 2002 at 01:59:03PM +0900
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 01:59:03PM +0900, Hiroyuki Machida wrote:
> 
> From: Kaz Kylheku <kaz@ashi.footprints.net>
> Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
> Date: Thu, 31 Jan 2002 20:02:25 -0800 (PST)
> 
> > On Fri, 1 Feb 2002, Hiroyuki Machida wrote:
> > > Please note that "sc" may fail even if nobody write the
> > > variable. (See P.211 "8.4.2 Load-Linked/Sotre-Conditional" of "See 
> > > MIPS RUN" for more detail.) 
> > > So, after your patch applied, compare_and_swap() may fail, even if
> > > *p is equal to oldval.
> > 
> > I can't think of anything that will break because of this, as long
> > as the compare_and_swap eventually succeeds on some subsequent trial.
> > If the atomic operation has to abort for some reason other than *p being
> > unequal to oldval, that should be cool.
> 
> I mean that this patch breaks the spec of compare_and_swap().
> In most case, this patch may works as Kaz said. If this patch have
> no side-effect to any application, it's ok to apply the patch. But
> we can't know how to use compare_and_swap() in all aplications in a
> whole world. So we have to follow the spec.  
> 

Please note that the old compare_and_swap is broken. If you use
compare_and_swap to check if *p == oldval, my patch doesn't help
you. But if you use it to swap old/new, my patch works fine. But I
don't think you can use it check if *p == oldval since *p can change
at any time. It is the same as simply using "*p == oldval". I don't
see my patch should break any sane applications.


H.J.
