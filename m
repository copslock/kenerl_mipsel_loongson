Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11CD5A00414
	for linux-mips-outgoing; Fri, 1 Feb 2002 04:13:05 -0800
Received: from ns6.sony.co.jp (NS6.Sony.CO.JP [146.215.0.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11CCrd00410
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 04:12:53 -0800
Received: from mail2.sony.co.jp (mail2.sony.co.jp [43.0.1.202])
	by ns6.sony.co.jp (R8/Sony) with ESMTP id g11BChW17024;
	Fri, 1 Feb 2002 20:12:43 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id g11BCgH02200;
	Fri, 1 Feb 2002 20:12:42 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id g11BCfA02180;
	Fri, 1 Feb 2002 20:12:41 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id UAA24352; Fri, 1 Feb 2002 20:17:20 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id UAA04105; Fri, 1 Feb 2002 20:12:40 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g11BCeJ10159; Fri, 1 Feb 2002 20:12:40 +0900 (JST)
Date: Fri, 01 Feb 2002 20:12:40 +0900 (JST)
Message-Id: <20020201.201240.103027706.machida@sm.sony.co.jp>
To: hjl@lucon.org
Cc: kaz@ashi.footprints.net, macro@ds2.pg.gda.pl,
   libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
From: Hiroyuki Machida <machida@sm.sony.co.jp>
In-Reply-To: <20020131230050.C32690@lucon.org>
References: <Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net>
	<20020201.135903.123568420.machida@sm.sony.co.jp>
	<20020131230050.C32690@lucon.org>
X-Mailer: Mew version 2.1.51 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


From: "H . J . Lu" <hjl@lucon.org>
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
Date: Thu, 31 Jan 2002 23:00:50 -0800

> On Fri, Feb 01, 2002 at 01:59:03PM +0900, Hiroyuki Machida wrote:
> > 
> > From: Kaz Kylheku <kaz@ashi.footprints.net>
> > Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
> > Date: Thu, 31 Jan 2002 20:02:25 -0800 (PST)
> > 
> > > On Fri, 1 Feb 2002, Hiroyuki Machida wrote:
> > > > Please note that "sc" may fail even if nobody write the
> > > > variable. (See P.211 "8.4.2 Load-Linked/Sotre-Conditional" of "See 
> > > > MIPS RUN" for more detail.) 
> > > > So, after your patch applied, compare_and_swap() may fail, even if
> > > > *p is equal to oldval.
> > > 
> > > I can't think of anything that will break because of this, as long
> > > as the compare_and_swap eventually succeeds on some subsequent trial.
> > > If the atomic operation has to abort for some reason other than *p being
> > > unequal to oldval, that should be cool.
> > 
> > I mean that this patch breaks the spec of compare_and_swap().
> > In most case, this patch may works as Kaz said. If this patch have
> > no side-effect to any application, it's ok to apply the patch. But
> > we can't know how to use compare_and_swap() in all aplications in a
> > whole world. So we have to follow the spec.  
> > 
> 
> Please note that the old compare_and_swap is broken. If you use
> compare_and_swap to check if *p == oldval, my patch doesn't help
> you. But if you use it to swap old/new, my patch works fine. But I
> don't think you can use it check if *p == oldval since *p can change
> at any time. It is the same as simply using "*p == oldval". I don't
> see my patch should break any sane applications.
> 
> 
> H.J.
> 

I know the orinal compare_and_swap() is bad, and I believe  the
spec of compare_and_swap() as below;

compare_and_swap(p, oldval, newval)
{
	retval = 0;
	begin_atomic
	if (*p==oldval) {
	   *p = newval;
	   retval = 1;
	}
	end_atomic
	return retval;
}

So, compare_and_swap() should be ...

 __compare_and_swap (a0 long int oldval, long int newval)

a0: *p
a1: oldval
a2: newval
v0: return value

     .set	noreorder
retry:
     ll		v0, (a0)
     bne	v0, a1
      move	v0, zero
     move	v0, a2
     sc		v0, (a0)
     beqz	v0, retry
      nop
    j		ra



But, with your patch ...

     .set	noreorder

     ll		t0, (a0)
     bne	t0, a1
      move	v0, zero
     move	v0, a
     sc		v0, (a0)
    j		ra


In this way, compare_and_swap() was changed as

compare_and_swap(p, oldval, newval)
{
	retval = 0;
	begin_atomic
	if (*p==oldval) {

	   if "sc" was failed goto out;
	   
	   *p = newval;
	   retval = 1;
	}
out:
	end_atomic
	return retval;
}

---
Hiroyuki Machida
Sony Corp.
