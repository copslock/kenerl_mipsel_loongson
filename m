Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 21:37:55 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18802 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1122169AbSJNThz>; Mon, 14 Oct 2002 21:37:55 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9EJbgP22805;
	Mon, 14 Oct 2002 15:37:42 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9EJbfxB012456;
	Mon, 14 Oct 2002 17:37:41 -0200
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9EJbb6h012452;
	Mon, 14 Oct 2002 16:37:37 -0300
To: "H. J. Lu" <hjl@lucon.org>
Cc: Richard Sandiford <rsandifo@redhat.com>, linux-mips@linux-mips.org,
	gcc@gcc.gnu.org, binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021012113423.A27894@lucon.org>
	<20021013145423.A10174@lucon.org> <20021014082810.A28682@lucon.org>
	<wvnit05ovct.fsf@talisman.cambridge.redhat.com>
	<20021014091649.A29353@lucon.org>
	<wvnfzv9ou6j.fsf@talisman.cambridge.redhat.com>
	<20021014101640.A30133@lucon.org>
	<orhefo3oht.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014105055.B30830@lucon.org>
	<orzntg298z.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014110118.B30940@lucon.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 14 Oct 2002 16:37:37 -0300
In-Reply-To: <20021014110118.B30940@lucon.org>
Message-ID: <orelas24n2.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 14, 2002, "H. J. Lu" <hjl@lucon.org> wrote:

> Why do we need nop? Why do we need noreorder?

We need reorder to indicate that the delay slot is already filled.  I
used nop just because it was the easiest form of delay-slot filling I
could think of.  Think of any other valid delay-slot filling
instruction in there.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
