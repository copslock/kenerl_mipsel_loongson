Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 12:15:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12891 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009945AbbGIKPBdqdJh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 12:15:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5D5AE5C6F1BE6;
        Thu,  9 Jul 2015 11:14:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 11:14:55 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 9 Jul
 2015 11:14:54 +0100
Subject: Re: [PATCH 02/19] MIPS: Add cases for CPU_I6400
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
 <1436434853-30001-3-git-send-email-markos.chandras@imgtec.com>
 <20150709100340.GB31002@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <559E499E.1040504@imgtec.com>
Date:   Thu, 9 Jul 2015 11:14:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150709100340.GB31002@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 07/09/2015 11:03 AM, Ralf Baechle wrote:
> On Thu, Jul 09, 2015 at 10:40:36AM +0100, Markos Chandras wrote:
> 
>> index d41e8e284825..abee2bfd10dc 100644
>> --- a/arch/mips/include/asm/cpu-type.h
>> +++ b/arch/mips/include/asm/cpu-type.h
>> @@ -77,6 +77,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
>>  	 */
>>  #endif
>>  
>> +#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R6
>> +	case CPU_I6400:
>> +#endif
>> +
> 
> To ensure best possible optimization you may want to introduce a new
> CPU type CPU_I6400 in Kconfig then change above code segment to
> 
> #ifdef CONFIG_SYS_HAS_CPU_I6400
> 	case CPU_I6400:
> #endif
> 

Why? That function uses MIPS32_XX and MIPS64_XX in other places as well.

I don't think it's a good idea to have a Kconfig symbol for I6400. It's
just a MIPSR6 processor so we do the same thing we did for other
processors like P5600, interAptiv etc.

> __get_cpu_type is ideally meant to get folded to a constant on any
> particular platform which then will allow the compiler to discard lots
> of other code.
> 
> Of course Malta being as hetergenous as it is that's not goint help
> with Malta but it will make a noticable difference for SOCs which usually
> come only with a single supported CPU type.
> 
>   Ralf
> 
Then it's best if we use platform Kconfig symbols in that function
instead of introducing a new symbol per processor.

-- 
markos
