Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:34:33 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:46846 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123916AbSJDMeP>;
	Fri, 4 Oct 2002 14:34:15 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g94CXxNf016266;
	Fri, 4 Oct 2002 05:33:59 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA29757;
	Fri, 4 Oct 2002 05:34:28 -0700 (PDT)
Message-ID: <00dd01c26ba2$b18f55b0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Dominic Sweetman" <dom@algor.co.uk>,
	"Carsten Langgaard" <carstenl@mips.com>
Cc: "Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <3D9D484B.4C149BD8@mips.com> <200210041153.MAA12052@mudchute.algor.co.uk>
Subject: Re: Promblem with PREF (prefetching) in memcpy
Date: Fri, 4 Oct 2002 14:36:39 +0200
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
X-archive-position: 357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Dominic Sweetman" <dom@algor.co.uk>
> Carsten Langgaard (carstenl@mips.com) writes:
> 
> > I think we have a problem with the PREF instructions spread out in the
> > memcpy function.
> 
> Not really.  The MIPS32 manual (for example):
> 
>  "PREF does not cause addressing-related exceptions. If it does happen
>   to raise an exception condition, the exception condition is
>   ignored. If an addressing-related exception condition is raised and
>   ignored, no data movement occurs."
>   
>   PREF never generates a memory operation for a location with an
>   uncached memory access type."
> 
> For a Linux user program, at least, memory pages are "memory-like":
> reads are guaranteed to be side-effect free, so any outlying
> prefetches are harmless.  It's hard to see any circumstance where an
> accessible cacheable location would lead to bad side-effects on read.

In case Carsten's reply wasn't clear enough, there is a loophole
in the spec:  kseg0.  There is no TLB access to cause a TLB
exception (which would suppress the operation and be nullifed),
If the prefetch address is correctly aligned, so that there is no
address exception.  In typical use, kseg0 is cacheable, which
means that the second paragraph you quote does not apply.
A prefetch to a well-formed, cacheable kseg0 address which 
has no primary storage behind it (e.g. 0x04000000 on a system
with 64M of physical memory) should, according to the spec,
cause a cache fill to be initiated for the line at that address,
which will result in a bus error, if not a flat-out system hang.

            Regards,

            Kevin K.
