Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 16:28:39 +0200 (CEST)
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48039 "EHLO
	lacrosse.corp.redhat.com") by linux-mips.org with ESMTP
	id <S1122978AbSJOO2i>; Tue, 15 Oct 2002 16:28:38 +0200
Received: from free.redhat.lsd.ic.unicamp.br (aoliva2.cipe.redhat.com [10.0.1.156])
	by lacrosse.corp.redhat.com (8.11.6/8.9.3) with ESMTP id g9FESHP06844;
	Tue, 15 Oct 2002 10:28:17 -0400
Received: from free.redhat.lsd.ic.unicamp.br (localhost.localdomain [127.0.0.1])
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5) with ESMTP id g9FESFGj025422;
	Tue, 15 Oct 2002 11:28:16 -0300
Received: (from aoliva@localhost)
	by free.redhat.lsd.ic.unicamp.br (8.12.5/8.12.5/Submit) id g9FDmsSh025957;
	Tue, 15 Oct 2002 10:48:54 -0300
To: Dominic Sweetman <dom@algor.co.uk>
Cc: "H. J. Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
	rsandifo@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com, nigel@algor.co.uk
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021014123940.A32333@lucon.org>
	<20021014.123510.00003943.davem@redhat.com>
	<20021014125549.A32575@lucon.org>
	<20021014.125134.98070597.davem@redhat.com>
	<20021014130932.A32693@lucon.org>
	<orwuokzs9k.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014132352.A489@lucon.org>
	<orof9wzq5r.fsf@free.redhat.lsd.ic.unicamp.br>
	<20021014141442.A1158@lucon.org>
	<orbs5wz48c.fsf@free.redhat.lsd.ic.unicamp.br>
	<15787.52889.454591.611223@gladsmuir.algor.co.uk>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 15 Oct 2002 10:48:53 -0300
In-Reply-To: <15787.52889.454591.611223@gladsmuir.algor.co.uk>
Message-ID: <oradlfx16i.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Oct 15, 2002, Dominic Sweetman <dom@algor.co.uk> wrote:

> Alexandre,

>> I know the problem that branch relaxation [aka delay-slot filling by
>> the assembler] is intended to solve

You got something wrong when you added this editor note.  Branch
relaxation and delay-slot filling are an entirely different issues.
Compare branch relaxation, that turns:

beq $t4,foo
[.... lots of code such that the branch is out of range....]
foo:

into

bne $t4,0f,foo
nop
j foo
nop
0:
[.... lots of code that won't make the jump out of range....]
foo:


with delay-slot filling, that turns:

move $a0,$s3
jal foo

into

jal foo
move $a0,$s3


See any resemblance?  Me neither.


The rest of your posting seems to be based on the mis-assumption that
branch relaxation and delay-slot filling are the same thing, so I'll
refrain from making further comments.


As for schedule, it's definitely not for 3.1, since 3.1 is already
out, and so is 3.2, and even 3.3 is already feature-frozen.  As the
name of the mips rewrite branch says, it's targeted at 3.4.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer
