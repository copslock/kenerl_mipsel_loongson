Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4V9D9nC024229
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 02:13:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4V9D9Gw024228
	for linux-mips-outgoing; Fri, 31 May 2002 02:13:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4V9CxnC024225
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 02:13:03 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA12950;
	Fri, 31 May 2002 13:14:26 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA16977; Fri, 31 May 2002 13:07:27 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA11423; Fri, 31 May 2002 13:11:22 +0400 (MSK)
Message-ID: <3CF73F2A.BA1C747E@niisi.msk.ru>
Date: Fri, 31 May 2002 13:15:22 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Daniel Jacobowitz <dan@debian.org>, Justin Carlson <justinca@cs.cmu.edu>,
   linux-mips@oss.sgi.com
Subject: Re: Function pointers and #defines
References: <1022787167.14210.472.camel@ldt-sj3-022.sj.broadcom.com> <20020530195052.GA10587@branoic.them.org> <023001c2081f$95a397d0$10eca8c0@grendel>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> From: "Daniel Jacobowitz" <dan@debian.org>
> > On Thu, May 30, 2002 at 12:32:47PM -0700, Justin Carlson wrote:
> > > A fair number of places in the headers, we have stuff like this:
> > >
> > > void (*_some_fn)(int arg1, int arg2);
> > > #define some_fn(arg1, arg2) _some_fn(arg1, arg2)
> > >
> > > Why do we do this, as opposed to:
> > >
> > > void (*some_fn)(int arg1, int arg2);
> > >
> > > Both syntaxes result in being able to say
> > >
> > > some_fn(1, 2);
> > >
> > > but the latter is both clearer and shorter.  Is there some deep,
> > > mystical C reason that we use the former, or did someone do it that way
> > > a long time ago and no one has changed it?
> >
> > At a guess, this prevents taking the address of the function
> > unintentionally...
> 
> More likely, some ancient early version of the code was
> written with a single global function, some_fn(), and it
> was easier to override it with a pointer indirection in
> the header than to hunt down and change all invocations.
> Sometimes that's good software engineering.  Sometimes
> it's just laziness...
> 
>             Kevin K.

Just remove the declaration, compile, and look at the code generated.
So, #define is just a safety belt.

Regards,
Gleb.
