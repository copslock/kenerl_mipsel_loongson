Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2005 20:25:48 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:17584
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225399AbVAHUZn>; Sat, 8 Jan 2005 20:25:43 +0000
Received: (qmail 9503 invoked from network); 8 Jan 2005 03:10:00 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 8 Jan 2005 03:10:00 -0800
Message-ID: <41E041BF.1020405@total-knowledge.com>
Date: Sat, 08 Jan 2005 12:25:35 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: ralf@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
References: <20050108180025Z8225397-1340+834@linux-mips.org>
In-Reply-To: <20050108180025Z8225397-1340+834@linux-mips.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips




ralf@linux-mips.org wrote:

>CVSROOT:	/home/cvs
>Module name:	linux
>Changes by:	ralf@ftp.linux-mips.org	05/01/08 18:00:18
>
>Modified files:
>	include/asm-mips: bitops.h 
>
>Log message:
>	Fix int vs. long bugs breaking the non-ll/sc case on 64-bit.
>
>diff -urN linux/include/asm-mips/bitops.h linux/include/asm-mips/bitops.h
>--- linux/include/asm-mips/bitops.h	2004/10/12 01:45:51	1.55
>+++ linux/include/asm-mips/bitops.h	2005/01/08 18:00:18	1.56
>@@ -92,7 +92,7 @@
> 		__bi_flags;
> 
> 		a += nr >> SZLONG_LOG;
>-		mask = 1 << (nr & SZLONG_MASK);
>+		mask = 1UL << (nr & SZLONG_MASK);
> 		__bi_local_irq_save(flags);
> 		*a |= mask;
> 		__bi_local_irq_restore(flags);
>@@ -385,7 +385,7 @@
> 		__bi_flags;
> 
> 		a += nr >> SZLONG_LOG;
>-		mask = 1 << (nr & SZLONG_MASK);
>+		mask = 1UL << (nr & SZLONG_MASK);
> 		__bi_local_irq_save(flags);
> 		retval = (mask & *a) != 0;
> 		*a &= ~mask;
>
>  
>
Any reason why same change wasn't applied to rest of bitops functions?

Index: include/asm/bitops.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/bitops.h,v
retrieving revision 1.56
diff -U5 -r1.56 bitops.h
--- include/asm/bitops.h        8 Jan 2005 18:00:18 -0000       1.56
+++ include/asm/bitops.h        8 Jan 2005 20:21:59 -0000
@@ -150,11 +150,11 @@
                volatile unsigned long *a = addr;
                unsigned long mask;
                __bi_flags;

                a += nr >> SZLONG_LOG;
-               mask = 1 << (nr & SZLONG_MASK);
+               mask = 1UL << (nr & SZLONG_MASK);
                __bi_local_irq_save(flags);
                *a &= ~mask;
                __bi_local_irq_restore(flags);
        }
 }
@@ -212,11 +212,11 @@
                volatile unsigned long *a = addr;
                unsigned long mask;
                __bi_flags;

                a += nr >> SZLONG_LOG;
-               mask = 1 << (nr & SZLONG_MASK);
+               mask = 1UL << (nr & SZLONG_MASK);
                __bi_local_irq_save(flags);
                *a ^= mask;
                __bi_local_irq_restore(flags);
        }
 }
@@ -291,11 +291,11 @@
                unsigned long mask;
                int retval;
                __bi_flags;

                a += nr >> SZLONG_LOG;
-               mask = 1 << (nr & SZLONG_MASK);
+               mask = 1UL << (nr & SZLONG_MASK);
                __bi_local_irq_save(flags);
                retval = (mask & *a) != 0;
                *a |= mask;
                __bi_local_irq_restore(flags);

@@ -318,11 +318,11 @@
        volatile unsigned long *a = addr;
        unsigned long mask;
        int retval;

        a += nr >> SZLONG_LOG;
-       mask = 1 << (nr & SZLONG_MASK);
+       mask = 1UL << (nr & SZLONG_MASK);
        retval = (mask & *a) != 0;
        *a |= mask;

        return retval;
 }
@@ -472,11 +472,11 @@
                volatile unsigned long *a = addr;
                unsigned long mask, retval;
                __bi_flags;

                a += nr >> SZLONG_LOG;
-               mask = 1 << (nr & SZLONG_MASK);
+               mask = 1UL << (nr & SZLONG_MASK);
                __bi_local_irq_save(flags);
                retval = (mask & *a) != 0;
                *a ^= mask;
                __bi_local_irq_restore(flags);
