Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g118Afo25801
	for linux-mips-outgoing; Fri, 1 Feb 2002 00:10:41 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g118Add25797
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 00:10:39 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 13857125C3; Thu, 31 Jan 2002 23:10:36 -0800 (PST)
Date: Thu, 31 Jan 2002 23:10:36 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Kaz Kylheku <kaz@ashi.footprints.net>
Cc: Hiroyuki Machida <machida@sm.sony.co.jp>, macro@ds2.pg.gda.pl,
   libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
Message-ID: <20020131231036.D32690@lucon.org>
References: <20020201.123523.50041631.machida@sm.sony.co.jp> <Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net>; from kaz@ashi.footprints.net on Thu, Jan 31, 2002 at 08:02:25PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 31, 2002 at 08:02:25PM -0800, Kaz Kylheku wrote:
> On Fri, 1 Feb 2002, Hiroyuki Machida wrote:
> > Please note that "sc" may fail even if nobody write the
> > variable. (See P.211 "8.4.2 Load-Linked/Sotre-Conditional" of "See 
> > MIPS RUN" for more detail.) 
> > So, after your patch applied, compare_and_swap() may fail, even if
> > *p is equal to oldval.
> 
> I can't think of anything that will break because of this, as long
> as the compare_and_swap eventually succeeds on some subsequent trial.
> If the atomic operation has to abort for some reason other than *p being
> unequal to oldval, that should be cool.

Maybe we should document it in glibc, something like

compare_and_swap compares the contents of a variable with an old value.
If the values are equal and a new value is stored in the variable
atomically, 1 is returned; otherwise, 1 is returned.


H.J.
