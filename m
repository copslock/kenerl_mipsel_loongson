Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 19:28:35 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:41466 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122958AbSIER2e>;
	Thu, 5 Sep 2002 19:28:34 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g85HRKXb015575;
	Thu, 5 Sep 2002 10:27:20 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA02077;
	Thu, 5 Sep 2002 10:27:15 -0700 (PDT)
Message-ID: <019601c25501$c5307250$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Daniel Jacobowitz" <dan@debian.org>
Cc: "Hartvig Ekner" <hartvige@mips.com>,
	"Tor Arntsen" <tor@spacetec.no>,
	"Carsten Langgaard" <carstenl@mips.com>,
	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <Pine.GSO.3.96.1020905181042.7444G-100000@delta.ds2.pg.gda.pl>
Subject: Re: 64-bit and N32 kernel interfaces
Date: Thu, 5 Sep 2002 19:29:12 +0200
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
X-archive-position: 127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > N32 supports saving and restoring 64-bit registers, which O32 doesn't -
> > according to some comments in GCC, O32 is in fact incompatible with
> > using 64-bit operations.
> 
>  But that old software wouldn't benefit as it didn't perform 64-bit
> operations unless manually coded in software using narrower data types. 
> There is no 64-bit C data type for o32 and long long is quite a recent
> invention -- it didn't exist in the 80s or even early 90s.

Well, actually,. as I recall from those days, "long long" *did*
exist in the very late 1980's, though it wasn't part of any standard,
and there were variant names proposed for it.  Certainly it had 
been  invented by the time the first 64-bit MIPS chips came out 
in 1991/1992.  Maybe not in GCC, but in other complers of 
the period.  The concensus was that "long" should be the largest
element that could be loaded/stored/used in an integer register,
which meant 32-bits for most of us in those days, yet there was
a need to represent 64-bit integers for the clearest expression
of some algorithms.  MIPS was rather unique in having made 
a "binary compatible" transition from 32 to 64-bits.  Does anyone 
know what's being done with C integer binding on the AMD
"Hammer" architecture?  They're looking at the same problem,
10 years further on.

            Kevin K.
