Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 02:17:28 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27693 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1122978AbSJPAR1>; Wed, 16 Oct 2002 02:17:27 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9G0GiP22602;
	Tue, 15 Oct 2002 20:16:45 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9G0GiGj008455;
	Tue, 15 Oct 2002 21:16:44 -0300
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9G0GeI9008451;
	Tue, 15 Oct 2002 21:16:40 -0300
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <Pine.GSO.3.96.1021015203905.20626A-100000@delta.ds2.pg.gda.pl>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 15 Oct 2002 21:16:40 -0300
In-Reply-To: <Pine.GSO.3.96.1021015203905.20626A-100000@delta.ds2.pg.gda.pl>
Message-ID: <ork7kjqluf.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 15, 2002, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

>  I think at least for the former case gas should be let relax jumps and
> branches freely, so the ".set nomacro" statement should be moved to affect
> instructions in delay slots only, as you suggested.

Except that, with the current implementation of branch relaxation,
when you enable it, each branch will mark the end of a frag, so the
assembler will be effectively unable to fill delay slots anyway, since
it won't bring instructions from the previous frag to the beginning of
the new frag.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
