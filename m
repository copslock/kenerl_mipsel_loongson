Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 18:19:44 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25488 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1122169AbSJNQTo>; Mon, 14 Oct 2002 18:19:44 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9EGJTP18758;
	Mon, 14 Oct 2002 12:19:30 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9EGJTxB008477;
	Mon, 14 Oct 2002 14:19:29 -0200
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9EGJSuZ008473;
	Mon, 14 Oct 2002 14:19:28 -0200
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021012113423.A27894@lucon.org>
	<20021013145423.A10174@lucon.org> <20021014082810.A28682@lucon.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 14 Oct 2002 14:19:28 -0200
In-Reply-To: <20021014082810.A28682@lucon.org>
Message-ID: <ord6qd3sdr.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 14, 2002, "H. J. Lu" <hjl@lucon.org> wrote:

> 2. Is noreorder/nomacro really needed for gas? If I remeber right, it
> is safe for gas to use

If you've already filled in delay slots, yes.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
