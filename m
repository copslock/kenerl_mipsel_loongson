Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 13:51:00 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:10477 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225446AbSLSNvA>;
	Thu, 19 Dec 2002 13:51:00 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 5AD98D657; Thu, 19 Dec 2002 14:57:03 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: unaligned
References: <m27ke6mgux.fsf@demo.mitica>
	<20021219143115.A24914@linux-mips.org>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20021219143115.A24914@linux-mips.org>
Date: 19 Dec 2002 14:57:03 +0100
Message-ID: <m27ke6jemo.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Thu, Dec 19, 2002 at 11:40:38AM +0100, Juan Quintela wrote:
>> - asm wants a unsigned long
>> - verify_area wants a void *
>> one of the two places need a cast.

ralf> Making emulate_load_store take a void * as the address argument was much
ralf> nicer instead.

I didn't wanted to touch asm() parts yet :)

>> Once there, ralf? forgot that emulate_load_store returns void, then
>> nuke the return 1 part.

ralf> Already did that.

nice.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
