Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 21:05:28 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:33664 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225484AbSLSVF1>;
	Thu, 19 Dec 2002 21:05:27 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 9914ED657; Thu, 19 Dec 2002 22:11:33 +0100 (CET)
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
References: <m2el8dixmr.fsf@demo.mitica>
	<20021219210103.GJ449@rembrandt.csv.ica.uni-stuttgart.de>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20021219210103.GJ449@rembrandt.csv.ica.uni-stuttgart.de>
Date: 19 Dec 2002 22:11:33 +0100
Message-ID: <m2wum5hfy2.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "thiemo" == Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> writes:

thiemo> Juan Quintela wrote:
>> 
>> Hi
>> this small patch made possible to compile a 64bit kernel for
>> people that have old proms that only accept ecoff.  As usual
>> stolen from the 32 bits version.
>> 
>> The easiest way is creating the file in arch/mips/boot,
>> otherwise we need to copy elf2ecoff.c to mips64.

thiemo> Sorry, but I plainly doubt you have tested this.

thiemo> I tried such a method today, and elf2ecoff failed to work on ELF64 files.
thiemo> Maybe a recent enough objcopy is the better choice for this purpose.

I tested it and it works :)

Notice that I am using egcs for MIPS64 as I am not able to compile the
kernel with gcc-3.2 :(

Later, Juan.




-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
