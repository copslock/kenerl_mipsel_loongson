Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 21:59:16 +0200 (CEST)
Received: from mx2.redhat.com ([12.150.115.133]:11794 "EHLO mx2.redhat.com")
	by linux-mips.org with ESMTP id <S1122978AbSJOT7P>;
	Tue, 15 Oct 2002 21:59:15 +0200
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id g9FJwRs14927;
	Tue, 15 Oct 2002 15:58:27 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g9FJx0l10139;
	Tue, 15 Oct 2002 15:59:01 -0400
Received: from tonopah.toronto.redhat.com (tonopah.toronto.redhat.com [172.16.14.91])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g9FJwwD09263;
	Tue, 15 Oct 2002 12:58:58 -0700
Received: (from wilson@localhost)
	by tonopah.toronto.redhat.com (8.11.6/8.11.6) id g9FJwv418168;
	Tue, 15 Oct 2002 15:58:57 -0400
X-Authentication-Warning: tonopah.toronto.redhat.com: wilson set sender to wilson@redhat.com using -f
To: "H. J. Lu" <hjl@lucon.org>
Cc: Alexandre Oliva <aoliva@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021014082810.A28682@lucon.org>
	<wvnit05ovct.fsf@talisman.cambridge.redhat.com>
	<20021014091649.A29353@lucon.org>
	<wvnfzv9ou6j.fsf@talisman.cambridge.redhat.com>
	<20021014101640.A30133@lucon.org>
	<orhefo3oht.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014105055.B30830@lucon.org>
	<orzntg298z.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014110118.B30940@lucon.org>
	<orelas24n2.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014123940.A32333@lucon.org>
From: Jim Wilson <wilson@redhat.com>
Date: 15 Oct 2002 15:58:57 -0400
In-Reply-To: <20021014123940.A32333@lucon.org>
Message-ID: <xwusmz7xym6.fsf@tonopah.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wilson@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@redhat.com
Precedence: bulk
X-list: linux-mips

>Can gcc not to emit nop nor noreorder when it tries to fill the delay
>slot with nop?

You never want the assembler to try to fill delay slots.  Consider a compiler
optimization like software pipelining.  The compiler will schedule instructions
inside a loop with full knowledge of the target pipeline to give maximum
performance.  Then the assembler picks a random instruction from the loop,
puts it in a branch delay slot, and now your code runs twice as slow because
the assembler introduced pipeline stalls.  Of course, gcc isn't good enough
yet to have this problem yet, but we will get there eventually.  Meanwhile, we
need to get out of the habit of relying on assembler optimizations.  In the
long run, assembler optimizations are bad, and we need to stop using them as
soon as possible.  Gcc should emit .set nomacro/noreorder/noat/etc at the
begining of its assembly output, and never turn them on.

Jim
