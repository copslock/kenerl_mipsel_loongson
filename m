Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2010 00:13:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50712 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492375Ab0F3WNu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jul 2010 00:13:50 +0200
Date:   Wed, 30 Jun 2010 23:13:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
cc:     Phil Staub <phils@windriver.com>,
        Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org
Subject: Re: How to detect STACKOVEFLOW on mips
In-Reply-To: <20100630181627.GB20597@dvomlehn-lnx2.corp.sa.net>
Message-ID: <alpine.LFD.2.00.1006302301080.13070@eddie.linux-mips.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com> <4C2B543E.2010309@windriver.com> <20100630181627.GB20597@dvomlehn-lnx2.corp.sa.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 30 Jun 2010, David VomLehn wrote:

> > How about something like:
> > 
> > {
> > 	long x;
> > 	...
> > 	asm("move %0,$29":"=g"(x));
> > 	...
> > }
> 
> Depending on the version of gcc you are using, you should also be able
> to use __builtin_frame_address(), though I haven't tried this in the kernel.

 It works just fine with a zero argument; the usual restrictions apply to 
non-zero arguments.  Or alternatively an explicit register variable will 
do as suggested by Ralf.  Both approaches result in a bit better code than 
an explicit move; the former is portable to other platforms even. :)

  Maciej
