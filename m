Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f51CT3w14282
	for linux-mips-outgoing; Fri, 1 Jun 2001 05:29:03 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f51CKwh13501
	for <linux-mips@oss.sgi.com>; Fri, 1 Jun 2001 05:21:00 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA29612;
	Fri, 1 Jun 2001 14:18:05 +0200 (MET DST)
Date: Fri, 1 Jun 2001 14:18:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Jaeger <aj@suse.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
In-Reply-To: <howv6w5sr0.fsf@gee.suse.de>
Message-ID: <Pine.GSO.3.96.1010601135550.26484B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 1 Jun 2001, Andreas Jaeger wrote:

>  #include "sys/tas.h"
> +
> +#ifdef __NR__test_and_set
> +# ifdef __ASSUME__TEST_AND_SET
> +#  define __have_no__test_and_set 0
> 
> Don't add this, compare how we do it in similar cases.

 Hmm, I looked at sysdeps/unix/sysv/linux/getcwd.c.  It does it in a
similar way.  What's wrong with this approach?  I'm just asking -- it
looks I do not always guess glibc rules right and not everything is
documented.

 Actually I tried to avoid macros if at all possible but gcc refuses to
eliminate code even if that's something like:

static const int var = 1;
<...>
if (var)
<...>

It still generates the code to check the value of var, sigh...

 Also I feel a bit uneasy about placing the "#ifdef
__ASSUME__TEST_AND_SET" condition outside -- __NR__test_and_set might be
undefined due to outdated kernel headers even if someone specified the
--enable-kernel option.  Is it considered justified within glibc to bail
out at the compilation time in this case? 

>  extern int _test_and_set (int *p, int v) __THROW;
> +extern int ___test_and_set (int *p, int v) __THROW;
> 
> Why do you export this here?

 It's a syscall wrapper.  We want to export syscall wrappers, don't we? 
And if we export a symbol, we should also declare it -- programs declaring
library symbols themselves are broken and doomed to fail sooner or later
-- have you seen what happens on glibc systems to old programs which
declare <string.h> functions due to the lack of appropriate declarations
in system headers at one time?

 If we don't want to export the wrapper, then fine -- I'll remove both the
symbol and the declaration. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
