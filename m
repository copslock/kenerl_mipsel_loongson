Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2004 22:47:05 +0000 (GMT)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:2058 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8224954AbUKOWrA> convert rfc822-to-8bit; Mon, 15 Nov 2004 22:47:00 +0000
Received: from SNaIlmail.Peter (217.249.200.252)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Mon, 15 Nov 2004 23:45:17 +0100
Received: from Opal.Peter (pf@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id iAFMiEbr000547;
	Mon, 15 Nov 2004 23:44:15 +0100
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id XAA01128;
	Mon, 15 Nov 2004 23:43:40 +0100
Date: Mon, 15 Nov 2004 23:43:40 +0100 (CET)
From: peter fuerst <pf@net.alphadv.de>
To: macrohat <emblinux@macrohat.com>
cc: linux-mips <linux-mips@linux-mips.org>
Subject: On Sat, 13 Nov 2004, macrohat wrote...
In-Reply-To: <20041113134735Z8224907-1751+1490@linux-mips.org>
Message-ID: <Pine.LNX.4.21.0411152319310.990-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hello !

BogoMips is most useful as a benchmark, if the main purpose of your
machine is to calculate BogoMips' ... (see BogoMips Mini-HOWTO :))
However - since there seems to be such a strong desire to see large
BogoMips values - here is some help:

Your BogoMips factor of 0.66, instead of the usual 0.99..., indicates
that the delay loop is misaligned, i.e. there's a instruction-cache-block
boundary inmidst the loop. (Recently i managed somehow to achieve this on
a R10000 :)
A ".align 3\n\t" at the begin of __delay() will keep the branch and its
delay-slot together.

You should even be able to double the BogoMips value (factor 1.99...) by
unrolling the delay loop (at least on R10k):

  static __inline__ void
  __delay(unsigned long loops)
  {
      loops |= 1;
      __asm__ __volatile__ (
          ".align 4\n\t"  /* only the paranoid survive. */
          ".set\tnoreorder\n"
          "1:\n\t"
          "dsubu\t%0,1\n\t"
          "bnez\t%0,1b\n\t"
          "dsubu\t%0,1\n\t"
          ".set\treorder"
          :"=r" (loops)
            :"0" (loops));
  }

Nevertheless, despite all this trickery, your machine will run exactly
as fast (slow), as it did before.

with kind regards

pf



  "I have been a happy man ever since January 1, 1990, when I no longer
  had an email address. ..."

                                                        Donald E. Knuth
                  (http://www-cs-faculty.stanford.edu/~knuth/email.html)


On Sat, 13 Nov 2004, macrohat wrote:

> Date: Sat, 13 Nov 2004 21:47:02 +0800
> From: macrohat <emblinux@macrohat.com>
> To: linux-mips <linux-mips@linux-mips.org>
> Cc: linux-cvs <linux-cvs@linux-mips.org>
> 
> Hello linux-mips:
> 
> I have a question to ask you: why BCM1250 CPU Bogomips is so much lower than CPU clock frequency,such as:
> CPU 700MHz - 465.30 Bogomips, CPU 800MHZ - 532.48 BogoMIPS.And i find out that CPU Bogomips is a fixed value regardless L2 cache open or closed,
> 
> Enclosed is the log from the console
> 
> Regards!
>  				
> 
> 　　　　　　　　macrohat
> 　　　　　　　　emblinux@macrohat.com
> 　　　　　　　　　　2004-11-13
> 
