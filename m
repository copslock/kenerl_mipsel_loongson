Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5F0BVnC027860
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 14 Jun 2002 17:11:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5F0BVJG027859
	for linux-mips-outgoing; Fri, 14 Jun 2002 17:11:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-6.ka.dial.de.ignite.net [62.180.196.6])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5F0BPnC027849
	for <linux-mips@oss.sgi.com>; Fri, 14 Jun 2002 17:11:26 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5F0CEc22491
	for linux-mips@oss.sgi.com; Sat, 15 Jun 2002 02:12:14 +0200
Received: from smtp.inreach.com (smtp.inreach.com [209.142.2.34])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5EIClnC022138
	for <linux-mips@oss.sgi.com>; Fri, 14 Jun 2002 11:12:47 -0700
Received: (qmail 11332 invoked by uid 512); 14 Jun 2002 18:15:23 -0000
Received: from dpchrist@holgerdanske.com by smtp.inreach.com by uid 509 with qmail-scanner-1.11 (perlscanner 1.11: clear; processed in 0.04974 secs); 14 Jun 2002 18:15:23 -0000
Received: from unknown (HELO w2k30g) (209.142.39.228)
  by smtp.inreach.com with SMTP; 14 Jun 2002 18:15:23 -0000
Message-ID: <00a601c213cf$8bf56b30$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
Cc: "Domcan Sami" <domca_psg@email.com>
References: <20020614115049.16384.qmail@email.com>
Subject: Re: Kernel - arch support(mips)
Date: Fri, 14 Jun 2002 11:15:35 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux-mips@oss.sgi.com:

Domcan Sami <domca_psg@email.com> wrote:
> I am trying to compile a program using a MIPS-LINUX cross compiler
> (gcc). I've set up a connection between my i386 Linux machine and a
> MIPS(RM7000) processor. This is again connected to a WinNT Terminal
> where there should be an output from the MIPS processor.
>
> I have 2 kernels in my Linux machine under the directories:
> 1) /usr/src/linux - kernel version 2.2.14
> 2) /root/kernels/linux - kernel version 2.4.14
>
> I am using a boot image generated from the older kernel for booting.
> The problem is the older kernel doesn't support MIPS architecture.
> What should I do to upgrade my kernel so that it supports MIPS
> architecture & that I'll be able to cross-compile my programs
> properly.

Please provide more information:

1.  What is your target platform -- e.g. make of model of the board or
    computer that has the RM7000 processor on/in it?

2.  Does the target support Linux, does it have a ROM monitor, or is it
    a raw embedded target (e.g. requires crt0)?


David Christensen
dpchrist@holgerdanske.com
