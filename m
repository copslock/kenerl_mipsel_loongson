Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 21:35:03 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:24041 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225360AbSLRVfD>;
	Wed, 18 Dec 2002 21:35:03 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 76186D657; Wed, 18 Dec 2002 22:41:03 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]:
References: <m2smwwqf0e.fsf@demo.mitica>
	<20021218202931.B20144@linux-mips.org>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20021218202931.B20144@linux-mips.org>
Date: 18 Dec 2002 22:41:03 +0100
Message-ID: <m2ptrzngy8.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Wed, Dec 18, 2002 at 02:42:25AM +0100, Juan Quintela wrote:
>> PD. Someone can explain me what mean:
>> __attribute__ ((__mode__ (__SI__)));
>> 
>> The SI part don't appear in the gcc info pages :(

ralf> Single Integer, a 32-bit integer.

Changing the code to u32 & friends will be acepted?

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
