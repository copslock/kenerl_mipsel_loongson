Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94HOEa17725
	for linux-mips-outgoing; Thu, 4 Oct 2001 10:24:14 -0700
Received: from are.twiddle.net (are.twiddle.net [64.81.246.98])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94HOCD17722
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 10:24:12 -0700
Received: (from rth@localhost)
	by are.twiddle.net (8.11.6/8.11.6) id f94HO8O11435;
	Thu, 4 Oct 2001 10:24:08 -0700
Date: Thu, 4 Oct 2001 10:24:08 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Kjeld Borch Egevang <kjelde@mips.com>, "H . J . Lu" <hjl@lucon.org>,
   GNU C Library <libc-alpha@sourceware.cygnus.com>,
   linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Update sysdeps/mips/fpu/libm-test-ulps
Message-ID: <20011004102408.A11412@twiddle.net>
References: <20010914111751.A17316@lucon.org> <Pine.LNX.4.30.0110011106360.16270-100000@coplin19.mips.com> <20011001121053.F3251@sunsite.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011001121053.F3251@sunsite.ms.mff.cuni.cz>; from jakub@redhat.com on Mon, Oct 01, 2001 at 12:10:53PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 01, 2001 at 12:10:53PM +0200, Jakub Jelinek wrote:
> The way soft-fp interprets Quiet NaNs is not just Intel-way, e.g. SPARC,
> Alpha work the same way. E.g. on SPARC, signalling NaN is exp=max,
> f=.0xxxxxxxxxx...xxx where at least one of the x bits is set, quiet NaN is
> exp=max, f=.1xxxxxxxxxx...xxxxxx.
> If MIPS has it backwards,

Yes indeed.  From the Mips32 spec I have handy:

Unbiased E    f    s b1    Value V    Typical Single Bit Pattern
E_max+1	    != 0   x 1     SNaN        16#7fffffff 
E_max+1     != 0   x 0     QNaN        16#7fbfffff


r~
