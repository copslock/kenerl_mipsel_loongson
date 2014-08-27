Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 00:52:42 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:65383 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006953AbaH0WwlnO3Da (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 00:52:41 +0200
Received: by mail-ig0-f169.google.com with SMTP id r2so83272igi.2
        for <multiple recipients>; Wed, 27 Aug 2014 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cfrtA41b1xNlVeY1P4Cpbd2wawy0vQUdvwd1+H87S+Q=;
        b=bIVcNGBS1iaoMUTyBnk5qjvdetjnieX2ZnKkdGm7zxI5JOvTeipfp8ImuT8YLx47t9
         m/l5kPsTpQ/RLrIY4BpiSp05NL7LCGSldllDq+fHioLx56KvE7cKg2SR0SRIhfIxdbmU
         gtJDh2l3Q9l+STrxgrbhsPFUw6dc0TpVLtoFesxw1aqbMeWRSVl12J/KldAwN/Gh5Bju
         JTD6IuZZSGzhQlvWT9uSyc5tp4RKEutpGdkjUp9UsaXUqbGERAsKq4N5lIgbaNgm1HWF
         OkxfrTs21D+hm7417cUE+Wo7Cz6wlabeOKV+HITsz2pfx2USxdUvXXBlKd0FbPcHIVMU
         nqbw==
X-Received: by 10.50.108.103 with SMTP id hj7mr33370647igb.5.1409179955508;
        Wed, 27 Aug 2014 15:52:35 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id j4sm8410350igx.20.2014.08.27.15.52.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 15:52:34 -0700 (PDT)
Message-ID: <53FE6131.5020201@gmail.com>
Date:   Wed, 27 Aug 2014 15:52:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Yong Zhang <yong.zhang0@gmail.com>,
        Yong Zhang <yong.zhang@windriver.com>,
        linux-mips@linux-mips.org, huawei.libin@huawei.com
Subject: Re: [PATCH] MIPS: change type of asid_cache to unsigned long
References: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com> <20140521053853.GC19655@pek-yzhang-d1> <20140521112936.GC17197@linux-mips.org> <20140522020611.GA6813@zhy> <20140522134245.GF10287@linux-mips.org>
In-Reply-To: <20140522134245.GF10287@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

Regarding this patch (commit e5eb925a1804c4a52994ba57f4f68ee7a9132905), 
the fix is fine for 64-bit systems, as it is impossible to overflow a 
64-bit ASID value.

For 32-bit systems, there is still a problem, we don't see the type 
truncation issue that was present on 64-bit systems, but there can still 
be badness on ASID generation wrap.


Scenario:

  o Long live process (p0) that sleeps for a long time.  It acquires 
what we will call ASID_0 and then is scheduled off the CPU

  o We cycle through 2^32 ASIDs, and the asid_cache wraps around  (not 
difficult to do, just write a program that does nothing but mmap() 
munmap() in a loop).  We have seen this happen every 6 days with ebizzy 
benchmark program.

  o Start new program (p1) that happens to also get ASID_0

  o p0 wakes up, and is now sharing tlb entries with p1, chaos ensues.

A workaround for this would be to use u64 for both 32-bit and 64-bit for 
all ASID related variables.  I have a patch for this, is it worth 
testing on 32-bit systems, and sending it in?

David Daney


On 05/22/2014 06:42 AM, Ralf Baechle wrote:
> On Thu, May 22, 2014 at 10:06:11AM +0800, Yong Zhang wrote:
>
>> On Wed, May 21, 2014 at 01:29:36PM +0200, Ralf Baechle wrote:
>>> On Wed, May 21, 2014 at 01:38:53PM +0800, Yong Zhang wrote:
>>>
>>>> Please check the V2 in which I add the reporter.
>>>> And thanks libin for reporting it :)
>>>
>>> The bug was introduced in 5636919b5c909fee54a6ef5226475ecae012ad02
>>> [MIPS: Outline udelay and fix a few issues.] in 2009 btw.  I think
>>> the intension was to avoid holes in the structure and minimize
>>> the bloat.  I instead applied aptch
>>
>> Could you please show the patch?
>>
>>> which also moves another member
>>> of the struct arond such that no hole will be created in the struct.
>>> This is important because the strcture it accessed fairly frequently
>>> so we want to fit the most important members into as few cache
>>> lines as possible.
>>
>> I have tried to move the struct member around, but I found that the
>> hole cann't be avoided completely because for exampe struct cache_desc
>> is a bit special.
>
> Yes, struct cache_desc is still a problem.  Easily solvable though -
> some of it's members are excessivly large; by using smaller data types
> both the struct and its required alignment will shrink.  But that's
> for another patch; as for this patch my goal to just not make things
> any worse.
>
>    Ralf
>
> ---
>   arch/mips/include/asm/cpu-info.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> index dc2135b..ff2707a 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -39,14 +39,14 @@ struct cache_desc {
>   #define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
>
>   struct cpuinfo_mips {
> -	unsigned int		udelay_val;
> -	unsigned int		asid_cache;
> +	unsigned long		asid_cache;
>
>   	/*
>   	 * Capability and feature descriptor structure for MIPS CPU
>   	 */
>   	unsigned long		options;
>   	unsigned long		ases;
> +	unsigned int		udelay_val;
>   	unsigned int		processor_id;
>   	unsigned int		fpu_id;
>   	unsigned int		msa_id;
>
>
