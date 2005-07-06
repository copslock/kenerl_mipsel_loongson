Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 10:01:41 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:14871 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226317AbVGFJBX>; Wed, 6 Jul 2005 10:01:23 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6691ecY007744;
	Wed, 6 Jul 2005 10:01:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6691cTr007743;
	Wed, 6 Jul 2005 10:01:38 +0100
Date:	Wed, 6 Jul 2005 10:01:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	djohnson+linuxmips@sw.starentnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
Message-ID: <20050706090138.GC3226@linux-mips.org>
References: <17093.19241.353160.946039@cortez.sw.starentnetworks.com> <20050703.005921.25910131.anemo@mba.ocn.ne.jp> <20050705200308.GE18772@linux-mips.org> <20050706.122912.71087098.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706.122912.71087098.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 06, 2005 at 12:29:12PM +0900, Atsushi Nemoto wrote:

> >>>>> On Tue, 5 Jul 2005 21:03:09 +0100, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> If the WCHAN column of ps axl is supposed to be any useful we
> ralf> need to unwind the stack until we find the caller of the
> ralf> sleeping or scheduling function.  Very useful for debugging.
> 
> Yes, but many sleeping/scheduling (such as schedule_timeout(),
> __down(), etc.)  are compiled without -fno-omit-frame-pointer, so
> you can not find the caller of such functions anyway.

Without additional information a framepointer isn't terribly useful on
MIPS.  Unfortunately it's stored at a non-constant offset in a function's
stackframe.

> And some sleeping/scheduling functions which are compiled with
> -fno-omit-frame-pointer are static or deprecated (sleep_on(), etc.)
> 
> You can find the caller of "schedule()" even with simple
> thread_saved_pc().  I think it is enough so I do not think it is worth
> to fix (and maintain) current minfo[].

The alternative would be to finally bite the bullet and add a wchan field
to thread_struct and initialize it in all the sleeping functions.

The IA-64 people have something like a DWARF-based frame unwinder but
that just seems to heavy.

  Ralf
