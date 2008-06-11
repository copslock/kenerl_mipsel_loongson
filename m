Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 18:56:48 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:54486 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20041731AbYFKRoM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 18:44:12 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 13CE931DBFF;
	Wed, 11 Jun 2008 17:44:13 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 11 Jun 2008 17:44:12 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 11 Jun 2008 10:43:58 -0700
Message-ID: <48500EDD.404@avtrex.com>
Date:	Wed, 11 Jun 2008 10:43:57 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	GCC Mailing List <gcc@gcc.gnu.org>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>
Subject: Re: Resend: [PATCH] [MIPS] Fix asm constraints for 'ins'	instructions.
References: <48500599.9080807@avtrex.com> <20080611172950.GA16600@linux-mips.org>
In-Reply-To: <20080611172950.GA16600@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2008 17:43:58.0766 (UTC) FILETIME=[BA40E4E0:01C8CBEA]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Jun 11, 2008 at 10:04:25AM -0700, David Daney wrote:
> 
>> The third operand to 'ins' must be a constant int, not a register.
>>
>> Signed-off-by: David Daney <ddaney@avtrex.com>
>> ---
>> include/asm-mips/bitops.h |    6 +++---
>> 1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
>> index 6427247..9a7274b 100644
>> --- a/include/asm-mips/bitops.h
>> +++ b/include/asm-mips/bitops.h
>> @@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
>> 		"2:	b	1b					\n"
>> 		"	.previous					\n"
>> 		: "=&r" (temp), "=m" (*m)
>> -		: "ir" (bit), "m" (*m), "r" (~0));
>> +		: "i" (bit), "m" (*m), "r" (~0));
>> #endif /* CONFIG_CPU_MIPSR2 */
>> 	} else if (cpu_has_llsc) {
>> 		__asm__ __volatile__(
> 
> An old trick to get gcc to do the right thing.  Basically at the stage when
> gcc is verifying the constraints it may not yet know that it can optimize
> things into an "i" argument, so compilation may fail if "r" isn't in the
> constraints.  However we happen to know that due to the way the code is
> written gcc will always be able to make use of the "i" constraint so no
> code using "r" should ever be created.
> 
> The trick is a bit ugly; I think it was used first in asm-i386/io.h ages ago
> and I would be happy if we could get rid of it without creating new problems.
> Maybe a gcc hacker here can tell more?

It is not nice to lie to GCC.

CCing GCC and Richard in hopes that a wider audience may shed some light on the issue.

David Daney
