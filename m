Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 05:23:49 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:55286 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S1122118AbSKNEXs>;
	Thu, 14 Nov 2002 05:23:48 +0100
Received: from data.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id UAA16477;
	Wed, 13 Nov 2002 20:23:22 -0800
Received: from mvista.com (IDENT:george@localhost [127.0.0.1])
	by data.mvista.com (8.9.3/8.9.3) with ESMTP id UAA26412;
	Wed, 13 Nov 2002 20:23:10 -0800
Message-ID: <3DD3252E.8DB61CE6@mvista.com>
Date: Wed, 13 Nov 2002 20:23:10 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bradley Bozarth <bbozarth@cisco.com>
CC: linux-mips@linux-mips.org
Subject: Re: SEGEV defines
References: <Pine.LNX.4.44.0211131742480.11387-100000@bbozarth-lnx.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <george@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: george@mvista.com
Precedence: bulk
X-list: linux-mips

Bradley Bozarth wrote:
> 
> This presents a problem that I just ran into.  What should the solution
> be?  Either glibc or the kernel needs to change as far as I can tell, in
> order for programs compiled against glibc and using these SIGEV defines to
> work w/ the mips kernel.  Is this file currently wrong?
> 
> glibc-2.3.1/sysdeps/unix/sysv/linux/mips/bits/siginfo.h
> 
> Would this patch fix it?
> 
> --- siginfo.h.orig      Wed Nov 13 18:04:58 2002
> +++ siginfo.h   Wed Nov 13 18:11:15 2002
> @@ -295,11 +295,11 @@
>  /* `sigev_notify' values.  */
>  enum
>  {
> -  SIGEV_SIGNAL = 0,            /* Notify via signal.  */
> +  SIGEV_SIGNAL = 129,          /* Notify via signal.  */
>  # define SIGEV_SIGNAL  SIGEV_SIGNAL
> -  SIGEV_NONE,                  /* Other notification: meaningless.  */
> +  SIGEV_NONE = 128,            /* Other notification: meaningless.  */
>  # define SIGEV_NONE    SIGEV_NONE
> -  SIGEV_THREAD                 /* Deliver via thread creation.  */
> +  SIGEV_THREAD = 131           /* Deliver via thread creation.  */
>  # define SIGEV_THREAD  SIGEV_THREAD
>  };

I MUCH prefer a change to the kernel if one or the other
needs to change.  The issue is, of course, IRIX
compatability and what that means.  This comes up because I
want to use the definitions in combination and the common
bit makes a mess of things.  Still, it would be NICE if it
matched the rest of the platforms.

-g

> 
> On Fri, 8 Nov 2002, Tor Arntsen wrote:
> 
> > On Nov 7, 23:11, Daniel Jacobowitz wrote:
> > >Presumably they match IRIX... like the rest of MIPS's oddball
> > >definitions.  A little hard to change them now.
> >
> > FWIW: You are correct, those values come from IRIX.
> >
> > >On Thu, Nov 07, 2002 at 12:33:55PM -0800, Bradley Bozarth wrote:
> > >> Can these be changed?
> > >>
> > >> > Now a question, why does mips use these values:
> > >> >  #define SIGEV_SIGNAL   129     /* notify via signal */
> > >> >  #define SIGEV_CALLBACK 130     /* ??? */
> > >> >  #define SIGEV_THREAD   131     /* deliver via thread
> > >> > creation */
> > >> >
> > >> > It is the only platform that adds anything to the simple
> > >> > 1,2,3 values used on other platforms.  The reason I ask, is
> > >> > that I would like to change them to conform to all the
> > >> > others.
> >

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
