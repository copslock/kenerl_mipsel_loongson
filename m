Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 22:13:31 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:33001 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225368AbSLRWNX>;
	Wed, 18 Dec 2002 22:13:23 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 1DDD7D657; Wed, 18 Dec 2002 23:19:24 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: c-r4k.c, new gcc's don't like empty labels
References: <m2bs3kqez8.fsf@demo.mitica>
	<20021218225715.A32351@linux-mips.org>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20021218225715.A32351@linux-mips.org>
Date: 18 Dec 2002 23:19:24 +0100
Message-ID: <m2k7i7nf6b.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Wed, Dec 18, 2002 at 02:43:07AM +0100, Juan Quintela wrote:
>> patch is trivial to eliminate warnings from the compiler

ralf> And yet I didn't like it.  The new syntax requirement isn't only ugly code,
ralf> it's harder to read than a replacing the gotos with a simple return ...

I thought that the gotos to end was there for generation of code
reasons.

It is not good in the first place to have labels called out :(

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
