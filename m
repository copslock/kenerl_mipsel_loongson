Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:34:14 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:46590 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123253AbSJDMeN>;
	Fri, 4 Oct 2002 14:34:13 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g94CXrNf016262;
	Fri, 4 Oct 2002 05:33:53 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA29752;
	Fri, 4 Oct 2002 05:34:23 -0700 (PDT)
Received: (from hartvige@localhost)
	by copfs01.mips.com (8.11.4/8.9.0) id g94CXrQ29071;
	Fri, 4 Oct 2002 14:33:53 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200210041233.g94CXrQ29071@copfs01.mips.com>
Subject: Re: Promblem with PREF (prefetching) in memcpy
To: dom@algor.co.uk (Dominic Sweetman)
Date: Fri, 4 Oct 2002 14:33:53 +0200 (MEST)
Cc: carstenl@mips.com (Carsten Langgaard),
	ralf@linux-mips.org (Ralf Baechle), linux-mips@linux-mips.org
In-Reply-To: <200210041153.MAA12052@mudchute.algor.co.uk> from "Dominic Sweetman" at Oct 04, 2002 12:53:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvige@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvige@mips.com
Precedence: bulk
X-list: linux-mips

Hi Dom,

this problem occurs in kernel space (kseg0), not user space. In user space
there is no problem due to the TLB "protection" of PREFs going outside the
process working set, but that doesn't help in kernel mode.

/Hartvig

Dominic Sweetman writes:
> 
> 
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
> 
> -- 
> Dominic Sweetman, 
> MIPS Technologies (UK) - formerly Algorithmics
> The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
> phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
> http://www.algor.co.uk
