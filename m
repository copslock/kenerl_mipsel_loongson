Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 10:21:03 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:42465 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009111AbcAEJVAp9UMR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2016 10:21:00 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19B33ABE5;
        Tue,  5 Jan 2016 09:20:59 +0000 (UTC)
Subject: Re: [PATCH -next] MIPS: VDSO: Fix build error with binutils 2.24 and
 earlier
To:     James Hogan <james.hogan@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <1450933471-7357-1-git-send-email-linux@roeck-us.net>
 <20151224124812.GA5376@jhogan-linux.le.imgtec.org>
 <20151224125726.GB5376@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@imgtec.com>,
        Andi Kleen <ak@linux.intel.com>
From:   Michal Marek <mmarek@suse.cz>
Message-ID: <568B8AFB.1020403@suse.cz>
Date:   Tue, 5 Jan 2016 10:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151224125726.GB5376@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <mmarek@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
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

On 2015-12-24 13:57, James Hogan wrote:
> On Thu, Dec 24, 2015 at 12:48:12PM +0000, James Hogan wrote:
>> Hi Guenter,
>>
>> On Wed, Dec 23, 2015 at 09:04:31PM -0800, Guenter Roeck wrote:
>>> Commit 2a037f310bab ("MIPS: VDSO: Fix build error") tries to fix a build
>>> error seen with binutils 2.24 and earlier. However, the fix does not work,
>>> and again results in the already known build errors if the kernel is built
>>> with an earlier version of binutils.
>>>
>>> CC      arch/mips/vdso/gettimeofday.o
>>> /tmp/ccnOVbHT.s: Assembler messages:
>>> /tmp/ccnOVbHT.s:50: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
>>> /tmp/ccnOVbHT.s:374: Error: can't resolve `_start' {*UND* section} - `L0 {.text section}
>>> scripts/Makefile.build:258: recipe for target 'arch/mips/vdso/gettimeofday.o' failed
>>> make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1
>>>
>>> Fixes: 2a037f310bab ("MIPS: VDSO: Fix build error")
>>> Cc: Qais Yousef <qais.yousef@imgtec.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> Tested with binutils 2.25 and 2.22.
>>>
>>>  arch/mips/vdso/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
>>> index 018f8c7b94f2..14568900fc1d 100644
>>> --- a/arch/mips/vdso/Makefile
>>> +++ b/arch/mips/vdso/Makefile
>>> @@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
>>>  # the comments on that file.
>>>  #
>>>  ifndef CONFIG_CPU_MIPSR6
>>> -  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
>>> +  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
>>
>> I agree this is semantically correct, but there is something more evil
>> going on here.
>>
>> Originally the check was version <= 2.24
>> Qais' patch changed it to version >= 2.25 (intending version < 2.25)
>> Your patch changes it to version < 2.25
>>
>> I think the reason this fixed the problem for Qais is actually that he
>> probably had a similar toolchain version to what I'm using:
>>
>> GNU ld (Codescape GNU Tools 2015.06-05 for MIPS MTI Linux) 2.24.90
>>
>> ./scripts/ld-version.sh does this:
>>
>> print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
>>
>> which changes that version number into:
>>  20000000
>> + 2400000
>> +  900000 = 23300000
>>
>> I.e. it doesn't expect a[3] to be >= 10.
>>
>> Should we do something like this (increase multipliers on a[1] and
>> a[2])?:
>>
>> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
>> index 198580d245e0..0b67edc5bc6f 100755
>> --- a/scripts/ld-version.sh
>> +++ b/scripts/ld-version.sh
>> @@ -3,6 +3,6 @@
>>  	{
>>  	gsub(".*)", "");
>>  	split($1,a, ".");
>> -	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
>> +	print a[1]*100000000 + a[2]*1000000 + a[3]*10000 + a[4]*100 + a[5];
>>  	exit
>>  	}
>>
>> which gives 2.24.90 => 224900000.
>>
>> All call sites would need updating too to add the extra 0, but a quick
>> git grep isn't showing any other ones than this one.
> 
> Actually, linux-next includes this commit which uses ld-ifversion too:
> 
> 19a3cc83353e3bb4bc28769f8606139a3d350d2d
> "Kbuild, lto: Add Link Time Optimization support v3"

That commit needs updating for other reasons, so feel free to fix
ld-ifversion and its usage in arch/mips.

Michal
