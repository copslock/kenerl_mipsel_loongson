Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9D0a4G01390
	for linux-mips-outgoing; Fri, 12 Oct 2001 17:36:04 -0700
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9D0ZwD01387
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 17:35:58 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id RAA03766;
	Fri, 12 Oct 2001 17:35:52 -0700
Date: Fri, 12 Oct 2001 17:35:52 -0700
From: Jun Sun <jsun@mvista.com>
To: Dan Aizenstros <dan@quicklogic.com>
Cc: Hanks Li <hli@quicklogic.com>, linux-mips@oss.sgi.com
Subject: Re: Big endian problem
Message-ID: <20011012173552.B3689@mvista.com>
References: <APEOLACBIPNAFKJDDFIIIEBLCBAA.hli@quicklogic.com> <3BC72CCC.3604FEC8@mvista.com> <3BC74EFE.9020109@quicklogic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC74EFE.9020109@quicklogic.com>; from dan@quicklogic.com on Fri, Oct 12, 2001 at 04:13:50PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 12, 2001 at 04:13:50PM -0400, Dan Aizenstros wrote:
> Hello Jun,
> 
> The file is the common time.c from linux/arch/mips/kernel as you
> can see from the third to last line of Hanshi's email.  The tools
> he is using are from H. J. Lu's RedHat 7.1 RPMs on the oss.sgi.com
> ftp site.  The file compiles just fine with the little endian version
> of the same tools from the same place.
> 
> Hanshi and I will look at the USECS_PER_JIFFY_FRAC macro.  Thanks for
> the pointer.
> 
> -- Dan A.
>

It is indeed a strange problem as it only shows up in BE tools.  
Some tool gurus want to look into it?

Meanwhile the following patch seems to fix it (and a couple of other
time.c files)

Jun 

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="time_JIFFY_FRAC.patch"

diff -Nru linux/arch/mips/dec/time.c.orig linux/arch/mips/dec/time.c
--- linux/arch/mips/dec/time.c.orig	Thu Aug 23 15:24:23 2001
+++ linux/arch/mips/dec/time.c	Fri Oct 12 17:35:51 2001
@@ -8,6 +8,7 @@
  * found in some MIPS systems.
  *
  */
+#include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -44,7 +45,7 @@
 
 /* This is for machines which generate the exact clock. */
 #define USECS_PER_JIFFY (1000000/HZ)
-#define USECS_PER_JIFFY_FRAC ((1000000ULL << 32) / HZ & 0xffffffff)
+#define USECS_PER_JIFFY_FRAC ((u32)((1000000ULL << 32) / HZ))
 
 /* Cycle counter value at the previous timer interrupt.. */
 
diff -Nru linux/arch/mips/kernel/time.c.orig linux/arch/mips/kernel/time.c
--- linux/arch/mips/kernel/time.c.orig	Sat Oct  6 22:04:40 2001
+++ linux/arch/mips/kernel/time.c	Fri Oct 12 17:35:17 2001
@@ -30,7 +30,7 @@
 
 /* This is for machines which generate the exact clock. */
 #define USECS_PER_JIFFY (1000000/HZ)
-#define USECS_PER_JIFFY_FRAC ((1000000ULL << 32) / HZ & 0xffffffff)
+#define USECS_PER_JIFFY_FRAC ((u32)((1000000ULL << 32) / HZ))
 
 /*
  * forward reference

--EeQfGwPcQSOJBaQU--
