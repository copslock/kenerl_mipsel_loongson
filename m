Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g115xNE23801
	for linux-mips-outgoing; Thu, 31 Jan 2002 21:59:23 -0800
Received: from ns6.sony.co.jp (NS6.Sony.CO.JP [146.215.0.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g115xJd23798
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 21:59:19 -0800
Received: from mail1.sony.co.jp (mail1.sony.co.jp [43.0.1.201])
	by ns6.sony.co.jp (R8/Sony) with ESMTP id g114x7F12839;
	Fri, 1 Feb 2002 13:59:07 +0900 (JST)
Received: from mail1.sony.co.jp (localhost [127.0.0.1])
	by mail1.sony.co.jp (R8) with ESMTP id g114x6l01500;
	Fri, 1 Feb 2002 13:59:06 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail1.sony.co.jp (R8) with ESMTP id g114x6g01492;
	Fri, 1 Feb 2002 13:59:06 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id OAA06256; Fri, 1 Feb 2002 14:03:45 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id NAA19403; Fri, 1 Feb 2002 13:59:05 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g114x3J09502; Fri, 1 Feb 2002 13:59:03 +0900 (JST)
Date: Fri, 01 Feb 2002 13:59:03 +0900 (JST)
Message-Id: <20020201.135903.123568420.machida@sm.sony.co.jp>
To: kaz@ashi.footprints.net
Cc: hjl@lucon.org, macro@ds2.pg.gda.pl, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
From: Hiroyuki Machida <machida@sm.sony.co.jp>
In-Reply-To: <Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net>
References: <20020201.123523.50041631.machida@sm.sony.co.jp>
	<Pine.LNX.4.33.0201311952440.2305-100000@ashi.FootPrints.net>
X-Mailer: Mew version 2.1.51 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


From: Kaz Kylheku <kaz@ashi.footprints.net>
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
Date: Thu, 31 Jan 2002 20:02:25 -0800 (PST)

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

I mean that this patch breaks the spec of compare_and_swap().

In most case, this patch may works as Kaz said. If this patch have
no side-effect to any application, it's ok to apply the patch. But
we can't know how to use compare_and_swap() in all aplications in a
whole world. So we have to follow the spec.  


---
Hiroyuki Machida
Sony Corp.
