Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76FT6g12094
	for linux-mips-outgoing; Mon, 6 Aug 2001 08:29:06 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76FT5V12088
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 08:29:05 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id BCF2D125C3; Mon,  6 Aug 2001 08:29:04 -0700 (PDT)
Date: Mon, 6 Aug 2001 08:29:04 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010806082904.C15666@lucon.org>
References: <20010806164000.E400@rembrandt.csv.ica.uni-stuttgart.de> <997108890.1773.22.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <997108890.1773.22.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Aug 06, 2001 at 03:41:28PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 03:41:28PM +0100, Eric Christopher wrote:
> 
> > I don't know if this is an good idea. BITS_PER_WORD is 64bit for mips64,
> > this might be wrong for wchar_t. At least the code for irix6 defines
> > WCHAR_TYPE_SIZE == 32.
> > 
> 
> Hrm.  You might be right.  I was thinking that would be correct though.
> AFAICT from reading the c++ standard, it doesn't care about the size of
> wchar_t as long as it is large enough to hold the values from the
> supported locales.
> 
> Perhaps some c++ expert could help with this a bit?  Benjamin is there a
> problem if wchar_t becomes 64-bits?

Yes. Gcc won't even compile since cpp uses MAX_WCHAR_TYPE_SIZE, which
is defined as WCHAR_TYPE_SIZE and has be to a constant. But mips'
BITS_PER_WORD is not avaiable for cpp. Besides, we use 32bit wchar_t
on most of the 64bit Linux targets. Why do we want to use 64 for
mips64? Check out WCHAR_TYPE_SIZE on ia64 and alpha, which are all
64bit Linux targets.


H.J.
