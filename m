Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76Fdjw13527
	for linux-mips-outgoing; Mon, 6 Aug 2001 08:39:45 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76FdiV13522
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 08:39:44 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4A20A125C3; Mon,  6 Aug 2001 08:39:43 -0700 (PDT)
Date: Mon, 6 Aug 2001 08:39:42 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806083942.A16047@lucon.org>
References: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de> <997108890.1773.22.camel@ghostwheel.cygnus.com> <20010806082904.C15666@lucon.org> <997112036.2480.14.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997112036.2480.14.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Aug 06, 2001 at 04:33:54PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 04:33:54PM +0100, Eric Christopher wrote:
> 
> > Yes. Gcc won't even compile since cpp uses MAX_WCHAR_TYPE_SIZE, which
> > is defined as WCHAR_TYPE_SIZE and has be to a constant. But mips'
> > BITS_PER_WORD is not avaiable for cpp. Besides, we use 32bit wchar_t
> > on most of the 64bit Linux targets. Why do we want to use 64 for
> > mips64? Check out WCHAR_TYPE_SIZE on ia64 and alpha, which are all
> > 64bit Linux targets.
> > 
> 
> Right.  alpha doesn't define WCHAR_TYPE_SIZE, ia64 seems to do what you
> want...

alpha does:

# grep WCHAR_TYPE defaults.h config/alpha/linux.h
defaults.h:#ifndef WCHAR_TYPE_SIZE
defaults.h:#define WCHAR_TYPE_SIZE INT_TYPE_SIZE
config/alpha/linux.h:#undef WCHAR_TYPE
config/alpha/linux.h:#define WCHAR_TYPE "int"
# grep INT_TYPE_SIZE config/alpha/*.h
config/alpha/alpha.h:#define INT_TYPE_SIZE 32

So WCHAR_TYPE_SIZE is 32 for Linux/alpha.


H.J.
