Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 19:43:41 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48880 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1122169AbSJNRnk>; Mon, 14 Oct 2002 19:43:40 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9EHhUP03017;
	Mon, 14 Oct 2002 13:43:30 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9EHhTxB010739;
	Mon, 14 Oct 2002 15:43:29 -0200
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9EHhQEi010735;
	Mon, 14 Oct 2002 14:43:26 -0300
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
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 14 Oct 2002 14:43:26 -0300
In-Reply-To: <20021014101640.A30133@lucon.org>
Message-ID: <orhefo3oht.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 14, 2002, "H. J. Lu" <hjl@lucon.org> wrote:

> The problem here is when gcc fills the delay slot with nop, it kills
> branch relaxation.

It wouldn't if only the delay slot was enclosed in .set nomacro.
Could we change this?

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
