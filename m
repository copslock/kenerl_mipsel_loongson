Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id BAA176322 for <linux-archive@neteng.engr.sgi.com>; Sat, 7 Feb 1998 01:16:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA10848 for linux-list; Sat, 7 Feb 1998 01:13:17 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA10842 for <linux@cthulhu.engr.sgi.com>; Sat, 7 Feb 1998 01:13:15 -0800
Received: from godzilla.taec.com (godzilla.taec.com [204.162.152.130]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id BAA03165
	for <linux@cthulhu.engr.sgi.com>; Sat, 7 Feb 1998 01:13:15 -0800
	env-from (sasahm@taec.toshiba.com)
Received: from mailint.taec.com by godzilla.taec.com
          via smtpd (for SGI.COM [192.48.153.1]) with SMTP; 7 Feb 1998 09:13:14 UT
Received: from oita (oita.taec.com [198.232.207.41])
	by sol-x86-1.taec.com (8.8.8/8.8.8) with ESMTP id BAA10209
	for <linux@cthulhu.engr.sgi.com>; Sat, 7 Feb 1998 01:13:04 -0800 (PST)
Message-Id: <199802070913.BAA10209@sol-x86-1.taec.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Trouble in making swap area
In-Reply-To: Your message of "Fri, 06 Feb 1998 17:41:59 -0800"
References: <199802070141.RAA03417@sol-x86-1.taec.com>
X-Mailer: Mew version 1.68 on Emacs 19.28.1 / Mule 2.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Feb 1998 01:13:04 -0800
From: Masashi Sasahara/=?ISO-2022-JP?B?GyRCOns4NkA1O0obKEI=?=  <sasahm@taec.toshiba.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > What happened when you tried to run the installer?
> 
>   It simply says "Command not found" though I could execute
> other binaries like ls or whatever came with root-be-0.03.tar.gz.

  I think I see what's happened.

  I extracted root-b-0.03.cpio come with Linux-installer-0.1d.tar.gz 
again and did "file ld*" in lib.
----------------------------
% file ld*
ld-2.0.4.so:    ELF 32-bit MSB dynamic lib MIPS RS3000 Big-Endian Version 1, dynamically linked, not stripped
ld-linux.so.1:  ELF 32-bit LSB dynamic lib 80386 Version 1, dynamically linked, not stripped
ld-linux.so.1.9.5:      ELF 32-bit LSB dynamic lib 80386 Version 1, dynamically linked, not stripped
ld.so:          ELF 32-bit LSB executable 80386 Version 1, statically linked, not stripped
ld.so.1:        ELF 32-bit MSB dynamic lib MIPS RS3000 Big-Endian Version 1, dynamically linked, not stripped
ld.so.1.9.5:    ELF 32-bit LSB executable 80386 Version 1, statically linked, not stripped
-----------------

  Probably ld.so for x86 was called when I tried to start
installer.

# Why x86 is here???

  Anyway, I got mkswap from util-linux and everything is ok now.
(though I couldn't find it in root-be 0.03.)

  Thank you, Alex.

-Masashi Sasahara
