Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4ULB0nC002847
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 14:11:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4ULAx1L002846
	for linux-mips-outgoing; Thu, 30 May 2002 14:10:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4ULAtnC002843
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 14:10:55 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id OAA19029;
	Thu, 30 May 2002 14:12:21 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA11959;
	Thu, 30 May 2002 14:12:19 -0700 (PDT)
Message-ID: <023001c2081f$95a397d0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>,
   "Justin Carlson" <justinca@cs.cmu.edu>
Cc: <linux-mips@oss.sgi.com>
References: <1022787167.14210.472.camel@ldt-sj3-022.sj.broadcom.com> <20020530195052.GA10587@branoic.them.org>
Subject: Re: Function pointers and #defines
Date: Thu, 30 May 2002 23:18:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Daniel Jacobowitz" <dan@debian.org>
> On Thu, May 30, 2002 at 12:32:47PM -0700, Justin Carlson wrote:
> > A fair number of places in the headers, we have stuff like this:
> > 
> > void (*_some_fn)(int arg1, int arg2);
> > #define some_fn(arg1, arg2) _some_fn(arg1, arg2)
> > 
> > Why do we do this, as opposed to:
> > 
> > void (*some_fn)(int arg1, int arg2);
> > 
> > Both syntaxes result in being able to say
> > 
> > some_fn(1, 2);
> > 
> > but the latter is both clearer and shorter.  Is there some deep,
> > mystical C reason that we use the former, or did someone do it that way
> > a long time ago and no one has changed it?
> 
> At a guess, this prevents taking the address of the function
> unintentionally...

More likely, some ancient early version of the code was
written with a single global function, some_fn(), and it
was easier to override it with a pointer indirection in
the header than to hunt down and change all invocations.
Sometimes that's good software engineering.  Sometimes
it's just laziness...

            Kevin K.
