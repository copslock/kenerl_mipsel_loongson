Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 10:47:27 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:15243 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1121744AbSKTJr1>;
	Wed, 20 Nov 2002 10:47:27 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gAK9lENf014278;
	Wed, 20 Nov 2002 01:47:14 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA20772;
	Wed, 20 Nov 2002 01:47:11 -0800 (PST)
Message-ID: <007f01c2907a$58064150$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Umesh Suryawanshi" <umesh.suryawanshi@tatainfotech.com>,
	<linux-mips@linux-mips.org>
References: <NFBBLKAGHEEGPLCBPPCLOEHADEAA.umesh.suryawanshi@tatainfotech.com>
Subject: Re: IDT79S334A MIPS evaluation board 
Date: Wed, 20 Nov 2002 10:50:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> Anybody has succsessfully booted IDT79S334 MIPS board with Linux? 
> I trying to boot it using TFTP.
> Please can you forward me that linux image ? 

While not strictly speaking MIPS32-compatible processors,
the RC32334 will probably run a kernel configured with the
"MIPS32" processor option.  The trick is drivers for the board,
and in particular, support for the integrated PCI controller.
30 seconds searching the IDT web site (which you should 
really have done yourself before asking the question here a 
second time) turns up the following:

http://www.idt.com/news/Jun02/06_17_02_1.html

which announces Linux support for the 79S334 from
MontaVista.  I'm sure one of the MontaVista guys
will correct me if I'm wrong, but my understanding
is that the MontaVista Linux Professional Edition
is only available under a paid subscription program,
though after some period of time, a lot of their work
does find its way into the linux-mips.org repository.

So you can wait, you can pay, or you can roll up
your sleeves and start hacking driver code.  ;-)

            Kevin K.
