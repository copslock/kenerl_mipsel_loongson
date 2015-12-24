Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2015 16:24:16 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:42118 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014421AbbLXPYN6BDkH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Dec 2015 16:24:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=IHlMg2vOKaDUHkxqyF05DluikVLyXLwrYK0ysdmC0ew=; b=s0652IFRT5I1v6cHiS4UxR7/h2
        LA8ny9YCGYO85gL0Ix58uywtFOjyikJvP4FlbJPhD4Ww5IOFQUkg821JG0AW9EEntMhTMlXNhXP7X
        3x9yk7cr/0qjVowi4rg30fIZu9KzcQVz7jSviFSq4TVzyZVq6hFOgV7vJjaq+GRngXr8=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48652 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86)
        (envelope-from <linux@roeck-us.net>)
        id 1aC7kb-004EBw-C1; Thu, 24 Dec 2015 15:24:23 +0000
Subject: Re: [PATCH -next] MIPS: VDSO: Fix build error with binutils 2.24 and
 earlier
To:     James Hogan <james.hogan@imgtec.com>
References: <1450933471-7357-1-git-send-email-linux@roeck-us.net>
 <20151224124812.GA5376@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@imgtec.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <567C0E13.6000006@roeck-us.net>
Date:   Thu, 24 Dec 2015 07:24:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20151224124812.GA5376@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 12/24/2015 04:48 AM, James Hogan wrote:
> Hi Guenter,
>
> On Wed, Dec 23, 2015 at 09:04:31PM -0800, Guenter Roeck wrote:
>> Commit 2a037f310bab ("MIPS: VDSO: Fix build error") tries to fix a build
>> error seen with binutils 2.24 and earlier. However, the fix does not work,
>> and again results in the already known build errors if the kernel is built
>> with an earlier version of binutils.
>>
>> CC      arch/mips/vdso/gettimeofday.o
>> /tmp/ccnOVbHT.s: Assembler messages:
>> /tmp/ccnOVbHT.s:50: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
>> /tmp/ccnOVbHT.s:374: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
>> scripts/Makefile.build:258: recipe for target 'arch/mips/vdso/gettimeofday.o' failed
>> make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
>>
>> Fixes: 2a037f310bab ("MIPS: VDSO: Fix build error")
>> Cc: Qais Yousef <qais.yousef@imgtec.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Tested with binutils 2.25 and 2.22.
>>
>>   arch/mips/vdso/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
>> index 018f8c7b94f2..14568900fc1d 100644
>> --- a/arch/mips/vdso/Makefile
>> +++ b/arch/mips/vdso/Makefile
>> @@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
>>   # the comments on that file.
>>   #
>>   ifndef CONFIG_CPU_MIPSR6
>> -  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
>> +  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
>
> I agree this is semantically correct, but there is something more evil
> going on here.
>
> Originally the check was version <= 2.24
> Qais' patch changed it to version >= 2.25 (intending version < 2.25)
> Your patch changes it to version < 2.25
>
> I think the reason this fixed the problem for Qais is actually that he
> probably had a similar toolchain version to what I'm using:
>
> GNU ld (Codescape GNU Tools 2015.06-05 for MIPS MTI Linux) 2.24.90
>

My toolchains are yocto 1.3 (2.22) and yocto 2.0 (2.25).

> ./scripts/ld-version.sh does this:
>
> print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
>
> which changes that version number into:
>   20000000
> +  2400000
> +   900000 = 23300000
>
> I.e. it doesn't expect a[3] to be >= 10.
>
> Should we do something like this (increase multipliers on a[1] and
> a[2])?:
>
> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> index 198580d245e0..0b67edc5bc6f 100755
> --- a/scripts/ld-version.sh
> +++ b/scripts/ld-version.sh
> @@ -3,6 +3,6 @@
>   	{
>   	gsub(".*)", "");
>   	split($1,a, ".");
> -	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
> +	print a[1]*100000000 + a[2]*1000000 + a[3]*10000 + a[4]*100 + a[5];
>   	exit
>   	}
>
> which gives 2.24.90 => 224900000.
>
Yes, that makes sense, and from your description will be necessary.

Thanks,
Guenter
