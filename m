Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f51Dmod21399
	for linux-mips-outgoing; Fri, 1 Jun 2001 06:48:50 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f51Dmhh21394
	for <linux-mips@oss.sgi.com>; Fri, 1 Jun 2001 06:48:44 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 4B7611E1BF; Fri,  1 Jun 2001 15:48:38 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
References: <Pine.GSO.3.96.1010601135550.26484B-100000@delta.ds2.pg.gda.pl>
From: Andreas Jaeger <aj@suse.de>
Date: 01 Jun 2001 15:48:36 +0200
In-Reply-To: <Pine.GSO.3.96.1010601135550.26484B-100000@delta.ds2.pg.gda.pl> ("Maciej W. Rozycki"'s message of "Fri, 1 Jun 2001 14:18:04 +0200 (MET DST)")
Message-ID: <hoelt4xqdn.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> On 1 Jun 2001, Andreas Jaeger wrote:
> 
>>  #include "sys/tas.h"
>> +
>> +#ifdef __NR__test_and_set
>> +# ifdef __ASSUME__TEST_AND_SET
>> +#  define __have_no__test_and_set 0
>> 
>> Don't add this, compare how we do it in similar cases.
> 
>  Hmm, I looked at sysdeps/unix/sysv/linux/getcwd.c.  It does it in a
> similar way.  What's wrong with this approach?  I'm just asking -- it
> looks I do not always guess glibc rules right and not everything is
> documented.
We normally do not define anything to 0 - unless there's no other
way.  And looking briefly over your code there should be other
solutions.  Sorry, I'm limited in time currently, otherwise I would
rewrite it myself.

Look at i386/lockf64.c for a cleaner example.

>  Actually I tried to avoid macros if at all possible but gcc refuses to
> eliminate code even if that's something like:
> 
> static const int var = 1;
> <...>
> if (var)
> <...>
> 
> It still generates the code to check the value of var, sigh...
> 
>  Also I feel a bit uneasy about placing the "#ifdef
> __ASSUME__TEST_AND_SET" condition outside -- __NR__test_and_set might be
> undefined due to outdated kernel headers even if someone specified the
> --enable-kernel option.  Is it considered justified within glibc to bail
> out at the compilation time in this case? 

We check that for the kernel headers in configure.

>>  extern int _test_and_set (int *p, int v) __THROW;
>> +extern int ___test_and_set (int *p, int v) __THROW;
>> 
>> Why do you export this here?
> 
>  It's a syscall wrapper.  We want to export syscall wrappers, don't
>  we? 

No, not everything - we already export _test_and_set and that should
be enough.
> And if we export a symbol, we should also declare it -- programs declaring
> library symbols themselves are broken and doomed to fail sooner or later
> -- have you seen what happens on glibc systems to old programs which
> declare <string.h> functions due to the lack of appropriate declarations
> in system headers at one time?
> 
>  If we don't want to export the wrapper, then fine -- I'll remove both the
> symbol and the declaration. 


Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
