Received:  by oss.sgi.com id <S42229AbQIZSF0>;
	Tue, 26 Sep 2000 11:05:26 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:11515 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42276AbQIZSE5>;
	Tue, 26 Sep 2000 11:04:57 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e8QI3fx19179;
	Tue, 26 Sep 2000 11:03:41 -0700
Message-ID: <39D0E51C.79A0BE50@mvista.com>
Date:   Tue, 26 Sep 2000 11:04:12 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>, ralf@oss.sgi.com
CC:     Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> >
> > If we have to use "-mips2" option, is there a clean way which allows us
> > to "uld/usw" instructions (instead of manually twicking the compilation
> > for each file that uses them)?
>

Ralf, before the perfect solution is found, the following patch makes
the gcc complain go away.  It just use ".set mips3" pragma.
 
> It's clear that I'll have to do
> something similar with the unaligned accesses in the USB
> support code before it will run on the MIPS 4Kc and
> similar CPUs.
> 

I am pretty close to get USB running with the v2.4-test5.  The unaligned
access is the minor problem.  The bigger problem I am fighting with now
is bus_to_virt()/virt_to_bus() and USB interrupt.

Jun

=====================================

--- linux/include/asm-mips/unaligned.h.orig     Mon Sep 25 14:02:52 2000
+++ linux/include/asm-mips/unaligned.h  Tue Sep 26 10:53:31 2000
@@ -19,7 +19,7 @@
 {
        unsigned long long __res;
 
-       __asm__("uld\t%0,(%1)"
+       __asm__(".set\tmips3\n\tuld\t%0,(%1)"
                :"=&r" (__res)
                :"r" (__addr));
 
@@ -33,7 +33,7 @@
 {
        unsigned long __res;
 
-       __asm__("ulw\t%0,(%1)"
+       __asm__(".set\tmips3\n\tulw\t%0,(%1)"
                :"=&r" (__res)
                :"r" (__addr));
 
@@ -47,7 +47,7 @@
 {
        unsigned long __res;
 
-       __asm__("ulh\t%0,(%1)"
+       __asm__(".set\tmips3\n\tulh\t%0,(%1)"
                :"=&r" (__res)
                :"r" (__addr));
 
@@ -60,7 +60,7 @@
 extern __inline__ void stq_u(unsigned long __val, unsigned long long *
__addr)
 {
        __asm__ __volatile__(
-               "usd\t%0,(%1)"
+               ".set\tmips3\n\tusd\t%0,(%1)"
                : /* No results */
                :"r" (__val),
                 "r" (__addr));
@@ -72,7 +72,7 @@
 extern __inline__ void stl_u(unsigned long __val, unsigned int *
__addr)
 {
        __asm__ __volatile__(
-               "usw\t%0,(%1)"
+               ".set\tmips3\n\tusw\t%0,(%1)"
                : /* No results */
                :"r" (__val),
                 "r" (__addr));
@@ -84,7 +84,7 @@
 extern __inline__ void stw_u(unsigned long __val, unsigned short *
__addr)
 {
        __asm__ __volatile__(
-               "ush\t%0,(%1)"
+               ".set\tmips3\n\tush\t%0,(%1)"
                : /* No results */
                :"r" (__val),
                 "r" (__addr));
