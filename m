Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 13:53:43 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:42210 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1123253AbSJDLxn>;
	Fri, 4 Oct 2002 13:53:43 +0200
Received: from mudchute.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g94BrRr05492;
	Fri, 4 Oct 2002 12:53:28 +0100 (BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id MAA12052;
	Fri, 4 Oct 2002 12:53:22 +0100 (BST)
Date: Fri, 4 Oct 2002 12:53:22 +0100 (BST)
Message-Id: <200210041153.MAA12052@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
In-Reply-To: <3D9D484B.4C149BD8@mips.com>
References: <3D9D484B.4C149BD8@mips.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Return-Path: <dom@mudchute.algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Carsten Langgaard (carstenl@mips.com) writes:

> I think we have a problem with the PREF instructions spread out in the
> memcpy function.

Not really.  The MIPS32 manual (for example):

 "PREF does not cause addressing-related exceptions. If it does happen
  to raise an exception condition, the exception condition is
  ignored. If an addressing-related exception condition is raised and
  ignored, no data movement occurs."
  
  PREF never generates a memory operation for a location with an
  uncached memory access type."

For a Linux user program, at least, memory pages are "memory-like":
reads are guaranteed to be side-effect free, so any outlying
prefetches are harmless.  It's hard to see any circumstance where an
accessible cacheable location would lead to bad side-effects on read.

-- 
Dominic Sweetman, 
MIPS Technologies (UK) - formerly Algorithmics
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
