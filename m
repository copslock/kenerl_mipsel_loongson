Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14KSWV23268
	for linux-mips-outgoing; Mon, 4 Feb 2002 12:28:32 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14KSNA23073;
	Mon, 4 Feb 2002 12:28:23 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g14JQGB12611;
	Mon, 4 Feb 2002 11:26:16 -0800
Message-ID: <3C5EE0D0.F2CC94CE@mvista.com>
Date: Mon, 04 Feb 2002 11:28:16 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: gcc 3.x, -ansi and "static inline"
References: <20020201115206.A18085@mvista.com> <20020203180151.A5371@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Fri, Feb 01, 2002 at 11:52:06AM -0800, Jun Sun wrote:
> 
> > BTW, the inclusion of "mipsregs.h" file in bitops.h seems unnecessary
> > and caused a bunch of similar errors.
> 
> Indeed, it was pointless and I therefore removed it.
> 

What about ffz()?  We can do:

diff -Nru include/asm-mips/bitops.h.orig include/asm-mips/bitops.h
--- include/asm-mips/bitops.h.orig      Mon Feb  4 11:07:31 2002
+++ include/asm-mips/bitops.h   Mon Feb  4 11:21:14 2002
@@ -675,7 +675,7 @@
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline unsigned long ffz(unsigned long word)
+static __inline__ unsigned long ffz(unsigned long word)
 {
        int b = 0, s;
 

or 

diff -Nru include/asm-mips/bitops.h.orig include/asm-mips/bitops.h
--- include/asm-mips/bitops.h.orig      Mon Feb  4 11:07:31 2002
+++ include/asm-mips/bitops.h   Mon Feb  4 11:27:55 2002
@@ -669,6 +669,8 @@
 
 #endif /* !(__MIPSEB__) */
 
+#ifdef __KERNEL__
+
 /*
  * ffz - find first zero in word.
  * @word: The word to search
@@ -689,8 +691,6 @@
        return b;
 }
 
-
-#ifdef __KERNEL__
 
 /**
  * ffs - find first bit set


Jun
