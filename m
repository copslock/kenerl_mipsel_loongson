Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 22:34:57 +0200 (CEST)
Received: from nixon.xkey.com ([209.245.148.124]:18657 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1123891AbSJZUe4>;
	Sat, 26 Oct 2002 22:34:56 +0200
Received: (qmail 22448 invoked from network); 26 Oct 2002 20:34:49 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 26 Oct 2002 20:34:49 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g9QKW9702281
	for linux-mips@linux-mips.org; Sat, 26 Oct 2002 13:32:09 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Sat, 26 Oct 2002 13:32:09 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: your mail
Message-ID: <20021026133209.B2153@wumpus.attbi.com>
References: <37A3C2F21006D611995100B0D0F9B73CBFE312@tnint11.telogy.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73CBFE312@tnint11.telogy.design.ti.com>; from nmckee@telogy.com on Sat, Oct 26, 2002 at 03:48:27PM -0400
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Sat, Oct 26, 2002 at 03:48:27PM -0400, Zajerko-McKee, Nick wrote:

> I'm porting some code from x86 to mips(32) and noticed that in
> include/asm-mips/siginfo.h differs from include/asm-i386/siginfo.h in the
> order of elements of the sigchld structure.  Was this an oversight or a
> design decision?  I would think that it would be desirable to be almost the
> same as the x86 for userland ease of portability...

User programs normally get recompiled, so anything using the proper
includes IS portable.

The issue only appears if you are using binary translation of x86
programs on mips. For example, this is one:

http://www.transitives.com/products.htm

For this, you need to write a system call translation layer which
rearranges things appropriately. An existing example is the o32 layer
in mips64, and soon the n32 layer in mips64.

-- greg
