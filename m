Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 15:53:13 +0000 (GMT)
Received: from mail.romat.com ([IPv6:::ffff:212.143.245.3]:47877 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8224911AbUKNPxJ>;
	Sun, 14 Nov 2004 15:53:09 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id D3E8CEB2EF
	for <linux-mips@linux-mips.org>; Sun, 14 Nov 2004 17:53:01 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40319-01 for <linux-mips@linux-mips.org>;
 Sun, 14 Nov 2004 17:52:54 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with SMTP id 6F55AEB2A9
	for <linux-mips@linux-mips.org>; Sun, 14 Nov 2004 17:52:48 +0200 (IST)
Message-ID: <0a2201c4ca62$25d37f80$a701a8c0@lan>
From: "Gilad Rom" <gilad@romat.com>
To: <linux-mips@linux-mips.org>
References: <20041112181335.13362.qmail@web81008.mail.yahoo.com> <09ac01c4ca24$e68a6740$a701a8c0@lan>
Subject: Re: GPIO on the Au1500
Date: Sun, 14 Nov 2004 17:53:49 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Replying to myself - 

I've composed a small program which mmap()'s
SYS_BASE and then tries to read at the appropriate
GPIO offset, as defined in the Au1500 databook.

For some reason, I keep getting that magical value, 
0x10000001 for EVERY address I try to read, be it 
SYS_BASE (0xB1900000) or every other address. (for example,
I've tried reading the MAC address from the MAC0 base address
of 0xB1500000, offset 0x0008, and I always get 0x10000001).

Any reason I shouldn't succeed in reading the au1500 
hardware addresses through /dev/mem?

Attached is the code I'm using:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>

#define SYS_BASE     0xB1900000

int
main () 
{
 volatile unsigned long *base;
 unsigned char val;
 int f, i;

 f = open ("/dev/mem", O_RDWR | O_SYNC);
 if (f < 0) {
  perror ("fopen");
  exit (-1);
 }
 
 base = (unsigned long *) mmap (NULL, 
   getpagesize (), 
   PROT_READ | PROT_WRITE, 
   MAP_SHARED, 
   f,
   SYS_BASE);

 if (base == (unsigned long *) (-1)) {
  perror ("mmap");
  exit (-1);
 }

 printf ("data at %p: 0x%x\n", base, (unsigned long) *base);
 *base = 0xffffffff;
        printf ("data at %p: 0x%x\n", base, (unsigned long) *base);
 close (f);
 return (0);
}

Thanks!
Gilad.

----- Original Message ----- 
From: "Gilad Rom" <gilad@romat.com>
To: <ppopov@embeddedalley.com>; <linux-mips@linux-mips.org>
Sent: Sunday, November 14, 2004 10:35 AM
Subject: Re: GPIO on the Au1500


> Thanks. 
> Can't I just mmap /dev/mem and use the
> GPIO offset from SYS_BASE?
> 
> Gilad.
> 
> ----- Original Message ----- 
> From: "Pete Popov" <ppopov@embeddedalley.com>
> To: "Gilad Rom" <gilad@romat.com>; <linux-mips@linux-mips.org>
> Sent: Friday, November 12, 2004 8:13 PM
> Subject: Re: GPIO on the Au1500
> 
> 
>> 
>> --- Gilad Rom <gilad@romat.com> wrote:
>> 
>>> Hello,
>>> 
>>> I am trying to use the au1000_gpio driver, but I'm a
>>> little clueless as to how it is meant to be used. 
>>> Can I use the GPIO ioctl's from a userland 
>>> program, or must I write a kernel module?
>> 
>> I'll see if I can dig up some docs and the example
>> userland program this weekend. That driver hasn't been
>> tested in a while though.
>> 
>> Pete
>> 
>>> Thank you,
>>> Gilad Rom
>>> Romat Telecom
>>> 
>>> 
>>> 
>>
>
