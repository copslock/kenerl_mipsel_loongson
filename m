Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 21:34:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51825 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010002AbaI1TeYu0Sp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 21:34:24 +0200
Date:   Sun, 28 Sep 2014 20:34:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: gcc-4.8+ and R10000+
In-Reply-To: <540C165F.7030307@gentoo.org>
Message-ID: <alpine.LFD.2.11.1409282017540.21156@eddie.linux-mips.org>
References: <540C165F.7030307@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Joshua,

 I can't help you with the problem, but I can confirm one of your guesses:

> I am guessing at a few things here:
> 
> - Because ll/sc are atomic, gdb doesn't let you step through them, which is
> why the instruction pointer jumps over the 'li' and 'sc' insns.

-- this is exactly the case, GDB tries to be smart enough and when it sees 
an LL or LLD instruction it examines code that follows to find a matching 
SC or SCD instruction and any other exit points from the atomic section 
and sets internal breakpoints correctly to let the code fragment run at 
the full speed even if single stepping.  Otherwise the exception taken at 
each single step would cause the conditional store instruction to always 
fail -- which might not be a big issue if you were knowingly stepping code 
e.g. with `stepi', but would cause big harm in implicit stepping through 
unknown or unrelated code such as when a software watchpoint is active.

 See `deal_with_atomic_sequence' in gdb/mips-tdep.c if curious about the 
details.

  Maciej
