Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 22:21:57 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:36585 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225368AbSLRWV5>;
	Wed, 18 Dec 2002 22:21:57 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id D868DD657; Wed, 18 Dec 2002 23:27:57 +0100 (CET)
To: Greg Lindahl <lindahl@keyresearch.com>
Cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
References: <200212181950.gBIJo4B11893@coplin09.mips.com>
	<Pine.GSO.3.96.1021218220828.14826A-100000@delta.ds2.pg.gda.pl>
	<20021218132726.A2572@wumpus.internal.keyresearch.com>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20021218132726.A2572@wumpus.internal.keyresearch.com>
Date: 18 Dec 2002 23:27:57 +0100
Message-ID: <m28yynnes2.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "greg" == Greg Lindahl <lindahl@keyresearch.com> writes:

>> > Sometimes you don't care whether you do only "half" a macro instruction
>> > if the branch is taken. Usually though, the warning is a good thing - I
>> > remember having spent many hours finding bugs like this with assemblers
>> > that don't issue warnings.
>> 
>> This is exactly what ".set nomacro" is for -- I can't see any reason for
>> such warnings when ".set macro" is active.

greg> While in general I like playing with sharp knives (you should see my
greg> cluster admin toolkit), and I like my kernel to run fast, and the only
greg> thing that gets trashed is usually at, I still think I'd prefer to
greg> have nops in those delay slots in the kernel. Hand-written assembly is
greg> unlikely to use ".set nomacro" properly.

In the kernel for IP22 (I suppose the same for other architectures),
it has only two Assembler warnings.  And they are all in the fast
path :(

one is in entry.S:excetp_vec3_r4000


and the other is in head.S:ejtag_debug_handler

I am not sure about the first one, but the second one shouldn't be
performance critical :(

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
