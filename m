Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 15:39:30 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22073 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1123253AbSJPNj3>; Wed, 16 Oct 2002 15:39:29 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9GDbqP21139;
	Wed, 16 Oct 2002 09:37:56 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9GDbZjk004840;
	Wed, 16 Oct 2002 10:37:35 -0300
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9GDaS3C004822;
	Wed, 16 Oct 2002 10:36:28 -0300
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <Pine.GSO.3.96.1021016130338.14774E-100000@delta.ds2.pg.gda.pl>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 16 Oct 2002 10:36:28 -0300
In-Reply-To: <Pine.GSO.3.96.1021016130338.14774E-100000@delta.ds2.pg.gda.pl>
Message-ID: <ork7kiy083.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 16, 2002, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

> On 15 Oct 2002, Alexandre Oliva wrote:
>> Except that, with the current implementation of branch relaxation,
>> when you enable it, each branch will mark the end of a frag, so the
>> assembler will be effectively unable to fill delay slots anyway, since
>> it won't bring instructions from the previous frag to the beginning of
>> the new frag.

>  Too bad.  But the marking could get disabled if ".set nomacro" was on for
> a branch, couldn't it?

Err...  Yes, indeed, this is already the case, now that I think of
it.  Only when the branch is a relaxation candidate does it become the
end of a variable-sized frag.  Branches within nomacro sections are
not relaxed in the current implementation, so we handle them just as
before.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
