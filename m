Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 19:50:15 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:24283 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225355AbSLRTuP>;
	Wed, 18 Dec 2002 19:50:15 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gBIJo2Nf017784;
	Wed, 18 Dec 2002 11:50:02 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA05920;
	Wed, 18 Dec 2002 11:50:04 -0800 (PST)
Received: from coplin09.mips.com (IDENT:root@coplin09 [192.168.205.79])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gBIJo4b15265;
	Wed, 18 Dec 2002 20:50:04 +0100 (MET)
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id gBIJo4B11893;
	Wed, 18 Dec 2002 20:50:04 +0100
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200212181950.gBIJo4B11893@coplin09.mips.com>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
To: lindahl@keyresearch.com (Greg Lindahl)
Date: Wed, 18 Dec 2002 20:50:04 +0100 (CET)
Cc: linux-mips@linux-mips.org (linux mips mailing list)
In-Reply-To: <20021218114220.A2217@wumpus.internal.keyresearch.com> from "Greg Lindahl" at Dec 18, 2002 11:42:20 
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvige@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvige@mips.com
Precedence: bulk
X-list: linux-mips

Sometimes you don't care whether you do only "half" a macro instruction
if the branch is taken. Usually though, the warning is a good thing - I
remember having spent many hours finding bugs like this with assemblers
that don't issue warnings.

/Hartvig

Greg Lindahl writes:
> 
> On Wed, Dec 18, 2002 at 07:47:31PM +0100, Maciej W. Rozycki wrote:
> 
> >  A few warnings are unavoidable -- e.g. there is no way to shut up gas
> > complaining about macros expanding into multiple instructions in branch
> > delay slots.  Too bad.
> 
> ... why isn't that a bug?
> 
> greg
