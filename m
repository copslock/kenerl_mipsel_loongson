Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 17:45:44 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:38120 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225338AbSLRRpo>;
	Wed, 18 Dec 2002 17:45:44 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 753DED657; Wed, 18 Dec 2002 18:51:43 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
References: <Pine.GSO.3.96.1021218173810.5977D-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021218173810.5977D-100000@delta.ds2.pg.gda.pl>
Date: 18 Dec 2002 18:51:43 +0100
Message-ID: <m2vg1rnrkg.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 18 Dec 2002, Juan Quintela wrote:
>> this patch does:
>> 
>> * redefine SETCX to only set cx
>> * define a new macre SETANDTESTCX for the few cases when we also want to
>> test the value set.

maciej> Is it needed?  The part that returns .mx should be optimized away by the
maciej> compiler automagically if unused. 

Idea was to make things compile without warnings, that way when you
change anything, you search for warnings :(

With the changes that I sent, I have put the warnings levels down to
(for IP22) to:
     - 7 C warnings
     - 2 Asm warnings

And some of the remaining warnings are printk(), where we mix ints &
longs all around (no problem if the code is not the same than in 64
bits, otherwise, problem :(

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
