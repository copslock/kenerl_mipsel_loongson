Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VNfCd13026
	for linux-mips-outgoing; Thu, 31 Jan 2002 15:41:12 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VNf4d13023
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 15:41:04 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2CE0A125C3; Thu, 31 Jan 2002 14:41:00 -0800 (PST)
Date: Thu, 31 Jan 2002 14:41:00 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
Message-ID: <20020131144100.A24634@lucon.org>
References: <20020131123547.A22759@lucon.org> <Pine.GSO.3.96.1020131230104.9069A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020131230104.9069A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jan 31, 2002 at 11:17:21PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 31, 2002 at 11:17:21PM +0100, Maciej W. Rozycki wrote:
> On Thu, 31 Jan 2002, H . J . Lu wrote:
> 
> > 	(__compare_and_swap): Return 0 when failed to compare or swap.
> [...]
> > 	* sysdeps/mips/atomicity.h (compare_and_swap): Return 0 when
> > 	failed to compare or swap.
> 
>  Looking at the i486 implementation these are not expected to fail. 
> Unless I am missing something... 

Why can't it fail?

static inline char
__attribute__ ((unused))
compare_and_swap (volatile long int *p, long int oldval, long int newval)
{
  char ret;
  long int readval;

  __asm__ __volatile__ ("lock; cmpxchgl %3, %1; sete %0"
                        : "=q" (ret), "=m" (*p), "=a" (readval)
                        : "r" (newval), "1" (*p), "a" (oldval));
  return ret;
}

It will fail if *p is not same as oldval.

> 
> > 	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set): Fill
> > 	the delay slot.
> 
>  What's the difference?  The code looks the same after changes.  Also you
> forgot to indent instructions in delay slots, which worsens readability. 

Are we looking at the same file? Here is the patched version:

_EXTERN_INLINE int
_test_and_set (int *p, int v) __THROW 
{
  int r, t;

  __asm__ __volatile__
    (".set      push\n\t"
     ".set      noreorder\n"
     "1:\n\t"
     "ll        %0,%3\n\t"
     "beq       %0,%4,2f\n\t"
     "move      %1,%4\n\t"
     "sc        %1,%2\n\t"
     "beqz      %1,1b\n\t"
     "nop\n" 
     "2:\n\t"
     ".set      pop"    
     : "=&r" (r), "=&r" (t), "=m" (*p)
     : "m" (*p), "r" (v) 
     : "memory");

  return r;
}


H.J.
