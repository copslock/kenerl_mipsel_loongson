Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 22:03:00 +0200 (CEST)
Received: from cygnus.equallogic.com ([65.170.102.10]:32777 "HELO
	cygnus.equallogic.com") by linux-mips.org with SMTP
	id <S1123930AbSJOUC7>; Tue, 15 Oct 2002 22:02:59 +0200
Received: from cygnus.equallogic.com (localhost.localdomain [127.0.0.1])
	by cygnus.equallogic.com (8.11.6/8.11.6) with ESMTP id g9FK2qN05645
	for <linux-mips@linux-mips.org>; Tue, 15 Oct 2002 16:02:52 -0400
Received: from deneb.dev.equallogic.com (deneb.dev.equallogic.com [172.16.1.99])
	by cygnus.equallogic.com (8.11.6/8.11.6) with ESMTP id g9FK2pk05633;
	Tue, 15 Oct 2002 16:02:51 -0400
Received: from pkoning.dev.equallogic.com.equallogic.com (localhost.localdomain [127.0.0.1])
	by deneb.dev.equallogic.com (8.11.6/8.11.6) with ESMTP id g9FK2om19272;
	Tue, 15 Oct 2002 16:02:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15788.29802.865689.741487@pkoning.dev.equallogic.com>
Date: Tue, 15 Oct 2002 16:02:50 -0400
From: Paul Koning <pkoning@equallogic.com>
To: wilson@redhat.com
Cc: hjl@lucon.org, aoliva@redhat.com, rsandifo@redhat.com,
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
	<xwusmz7xym6.fsf@tonopah.toronto.redhat.com>
X-Mailer: VM 7.07 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Return-Path: <pkoning@equallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkoning@equallogic.com
Precedence: bulk
X-list: linux-mips

>>>>> "Jim" == Jim Wilson <wilson@redhat.com> writes:

 >> Can gcc not to emit nop nor noreorder when it tries to fill the
 >> delay slot with nop?

 Jim> You never want the assembler to try to fill delay slots.
 Jim> Consider a compiler optimization like software pipelining. ...
 Jim>  Meanwhile, we need to get out of
 Jim> the habit of relying on assembler optimizations.  In the long
 Jim> run, assembler optimizations are bad, and we need to stop using
 Jim> them as soon as possible.  Gcc should emit .set
 Jim> nomacro/noreorder/noat/etc at the begining of its assembly
 Jim> output, and never turn them on.

Makes sense to me.  As an assembly language programmer, I do the same
thing in handwritten code, for the same reasons.

      paul
