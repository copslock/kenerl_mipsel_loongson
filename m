Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f51Bj6u11440
	for linux-mips-outgoing; Fri, 1 Jun 2001 04:45:06 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f51Bj0h11434
	for <linux-mips@oss.sgi.com>; Fri, 1 Jun 2001 04:45:00 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 101041E4BB; Fri,  1 Jun 2001 13:44:54 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>, Jun Sun <jsun@mvista.com>
Subject: Re: [patch] RFC: A sys__test_and_set() implementation, 2nd iteration
References: <Pine.GSO.3.96.1010531094603.11865B-100000@delta.ds2.pg.gda.pl>
From: Andreas Jaeger <aj@suse.de>
Date: 01 Jun 2001 13:44:51 +0200
In-Reply-To: <Pine.GSO.3.96.1010531094603.11865B-100000@delta.ds2.pg.gda.pl> ("Maciej W. Rozycki"'s message of "Fri, 1 Jun 2001 13:32:29 +0200 (MET DST)")
Message-ID: <howv6w5sr0.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> On 31 May 2001, Andreas Jaeger wrote:
> 
>> Do it the following way:
>> - Define in sysdeps/unix/sysv/linux/kernel-features a new macro, e.g.
>>   __ASSUME_TEST_AND_SET with the appropriate guards
>> - Do *both* implementations like this:
>> #include <kernel-features.h>
>> #if __ASSUME_TEST_AND_SET
>> fast code without fallback
>> #else
>> slow code that first tries kernel call and then falls back to sysmips
>> #endif
>> This way you get the fast one if you configure glibc with
>> --enable-kernel=2.4.6 if we assume that 2.4.6 is the first kernel with
>> those features. 
> 
>  Thanks for the tip.  It's reasonable, indeed.  Now the point is to get
> Linux changes (once introduced) back to Linus' tree.  It would be bad to
> to tie a kernel version with a feature that would be present in the CVS at
> oss. 
> 
>> Check other places in glibc for details how this can be done.
> 
>  OK, how about this patch then (the kernel version has to be set once
> known)?
> 
>   Maciej

diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/_test_and_set.c glibc-2.2.3/sysdeps/unix/sysv/linux/mips/_test_and_set.c
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Fri Jul 28 13:37:25 2000
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/_test_and_set.c	Thu May 31 23:21:50 2001
@@ -21,6 +21,12 @@
    defined in sys/tas.h  */
 
 #include <features.h>
+#include <sgidefs.h>
+#include <unistd.h>
+#include <sysdep.h>
+#include <sys/sysmips.h>
+
+#include "kernel-features.h"
 
 #define _EXTERN_INLINE
 #ifndef __USE_EXTERN_INLINES
@@ -28,3 +34,46 @@
 #endif
 
 #include "sys/tas.h"
+
+#ifdef __NR__test_and_set
+# ifdef __ASSUME__TEST_AND_SET
+#  define __have_no__test_and_set 0

Don't add this, compare how we do it in similar cases.
diff -up --recursive --new-file glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/sys/tas.h glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/tas.h
--- glibc-2.2.3.macro/sysdeps/unix/sysv/linux/mips/sys/tas.h	Sun Jan  7 04:35:41 2001
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/sys/tas.h	Wed May 30 02:18:19 2001
@@ -22,11 +22,11 @@
 
 #include <features.h>
 #include <sgidefs.h>
-#include <sys/sysmips.h>
 
 __BEGIN_DECLS
 
 extern int _test_and_set (int *p, int v) __THROW;
+extern int ___test_and_set (int *p, int v) __THROW;

Why do you export this here?

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
