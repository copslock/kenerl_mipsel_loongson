Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Dec 2002 11:01:31 +0100 (MET)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:510 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S869536AbSLHKBV>;
	Sun, 8 Dec 2002 11:01:21 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB89vRNf013068;
	Sun, 8 Dec 2002 01:57:27 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA23258;
	Sun, 8 Dec 2002 01:57:25 -0800 (PST)
Message-ID: <006d01c29ea0$d0d15190$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Gilad" <giladb@riverhead.com>, <linux-mips@linux-mips.org>
References: <ECEPLLMMNGHMFBLHCLMACEALDGAA.giladb@riverhead.com>
Subject: Re: Prefetches in memcpy
Date: Sun, 8 Dec 2002 11:01:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> As someone rather new to this list, and to mips-linux in general,
> can someone explain the problem, as well as how one can avoid 
> it or limit it's effects to a minimum ?

The problem is that memcpy() uses prefetch to pre-load the
cache from the copy source, but does so very naively, such
that it continues prefetching beyond the end of the block to
be copied.  This is a Bad Idea for a couple of reasons.
The first to be commented upon was the fact that it can
result in bus hangs/bus errors if the kernel is trying to copy
from the last few hundred bytes of physical memory, but 
the really nasty one is that it screws up cache coherence
for DMA I/O.

The no-brainer solution which has been proposed as a
stopgap is simply to stop doing prefetch in memcpy()
altogether.  The "correct" solution would be to have a
slightly more complex memcpy() loop which only does
prefetch up to the end of the source block, which is
what is now done in the x86 port.
