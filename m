Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g114aBe22480
	for linux-mips-outgoing; Thu, 31 Jan 2002 20:36:11 -0800
Received: from ns6.sony.co.jp (NS6.Sony.CO.JP [146.215.0.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g114Zdd22467
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 20:36:02 -0800
Received: from mail5.sony.co.jp (mail5.sony.co.jp [43.0.1.204])
	by ns6.sony.co.jp (R8/Sony) with ESMTP id g113ZQF00638;
	Fri, 1 Feb 2002 12:35:27 +0900 (JST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id g113ZPh02539;
	Fri, 1 Feb 2002 12:35:25 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id g113ZPF02517;
	Fri, 1 Feb 2002 12:35:25 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id MAA02641; Fri, 1 Feb 2002 12:40:04 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id MAA15936; Fri, 1 Feb 2002 12:35:23 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id g113ZNJ09362; Fri, 1 Feb 2002 12:35:23 +0900 (JST)
Date: Fri, 01 Feb 2002 12:35:23 +0900 (JST)
Message-Id: <20020201.123523.50041631.machida@sm.sony.co.jp>
To: hjl@lucon.org
Cc: macro@ds2.pg.gda.pl, libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
From: Hiroyuki Machida <machida@sm.sony.co.jp>
In-Reply-To: <20020131144100.A24634@lucon.org>
References: <20020131123547.A22759@lucon.org>
	<Pine.GSO.3.96.1020131230104.9069A-100000@delta.ds2.pg.gda.pl>
	<20020131144100.A24634@lucon.org>
X-Mailer: Mew version 2.1.51 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



From: "H . J . Lu" <hjl@lucon.org>
Subject: Re: PATCH: Fix ll/sc for mips
Date: Thu, 31 Jan 2002 14:41:00 -0800

> On Thu, Jan 31, 2002 at 11:17:21PM +0100, Maciej W. Rozycki wrote:
> > On Thu, 31 Jan 2002, H . J . Lu wrote:
> > 
> > > 	(__compare_and_swap): Return 0 when failed to compare or swap.
> > [...]
> > > 	* sysdeps/mips/atomicity.h (compare_and_swap): Return 0 when
> > > 	failed to compare or swap.
> > 
> >  Looking at the i486 implementation these are not expected to fail. 
> > Unless I am missing something... 
> 
> Why can't it fail?
> 
> static inline char
> __attribute__ ((unused))
> compare_and_swap (volatile long int *p, long int oldval, long int newval)
> {
>   char ret;
>   long int readval;
> 
>   __asm__ __volatile__ ("lock; cmpxchgl %3, %1; sete %0"
>                         : "=q" (ret), "=m" (*p), "=a" (readval)
>                         : "r" (newval), "1" (*p), "a" (oldval));
>   return ret;
> }
> 
> It will fail if *p is not same as oldval.


Please note that "sc" may fail even if nobody write the
variable. (See P.211 "8.4.2 Load-Linked/Sotre-Conditional" of "See 
MIPS RUN" for more detail.) 
So, after your patch applied, compare_and_swap() may fail, even if
*p is equal to oldval.


> > 
> > > 	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set): Fill
> > > 	the delay slot.
> > 
> >  What's the difference?  The code looks the same after changes.  Also you
> > forgot to indent instructions in delay slots, which worsens readability. 
> 
> Are we looking at the same file? Here is the patched version:
> 
> _EXTERN_INLINE int
> _test_and_set (int *p, int v) __THROW 
> {
>   int r, t;
> 
>   __asm__ __volatile__
>     (".set      push\n\t"
>      ".set      noreorder\n"
>      "1:\n\t"
>      "ll        %0,%3\n\t"
>      "beq       %0,%4,2f\n\t"
>      "move      %1,%4\n\t"
>      "sc        %1,%2\n\t"
>      "beqz      %1,1b\n\t"
>      "nop\n" 
>      "2:\n\t"
>      ".set      pop"    
>      : "=&r" (r), "=&r" (t), "=m" (*p)
>      : "m" (*p), "r" (v) 
>      : "memory");
> 
>   return r;
> }

Gas will fill delay slots. Same object codes will be produced, so I
think you don't have to do that by hand. 

---
Hiroyuki Machida
Sony Corp.
