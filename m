Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 16:43:19 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19816 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24008388AbYLRQnQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 16:43:16 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494a7d930000>; Thu, 18 Dec 2008 11:42:59 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Dec 2008 08:42:07 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Dec 2008 08:42:07 -0800
Message-ID: <494A7D5F.6060103@caviumnetworks.com>
Date:	Thu, 18 Dec 2008 08:42:07 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus.
References: <1229546644-3030-1-git-send-email-ddaney@caviumnetworks.com> <20081218080740.GA15338@linux-mips.org>
In-Reply-To: <20081218080740.GA15338@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2008 16:42:07.0284 (UTC) FILETIME=[90862F40:01C9612F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Dec 17, 2008 at 12:44:04PM -0800, David Daney wrote:
> 
>> Some CPUs implement mipsr2, but because they are a super-set of
>> mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
>> this category.  We would still like to use the optimized
>> implementation, so since we have already checked for
>> CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
>> CONFIG_CPU_MIPS64_R2 is sufficient.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  arch/mips/include/asm/byteorder.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/byteorder.h b/arch/mips/include/asm/byteorder.h
>> index 2988d29..92ec1e1 100644
>> --- a/arch/mips/include/asm/byteorder.h
>> +++ b/arch/mips/include/asm/byteorder.h
>> @@ -46,7 +46,7 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>>  }
>>  #define __arch_swab32 __arch_swab32
>>  
>> -#ifdef CONFIG_CPU_MIPS64_R2
>> +#ifdef CONFIG_64BIT
> 
> This breaks every non-R2 64-bit processor.
> 
I disagree. As I said before, the entire block is wrapped by #ifdef 
MIPS_R2.  non-R2 processors will not get any of the optimized byte 
swapping code.  I just want to allow all 64 bit R2 processors to use the 
optimized code.

David Daney
