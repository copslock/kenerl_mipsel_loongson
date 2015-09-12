Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 08:13:10 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:40171
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27007342AbbILGNIW7DFy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Sep 2015 08:13:08 +0200
Subject: Re: [PATCH 6/6] MIPS: CPS: drop .set mips64r2 directives
To:     Paul Burton <paul.burton@imgtec.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
References: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
 <1438814560-19821-7-git-send-email-paul.burton@imgtec.com>
 <20150910180323.GA22682@NP-P-BURTON>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <55F3C273.3030704@phrozen.org>
Date:   Sat, 12 Sep 2015 08:13:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20150910180323.GA22682@NP-P-BURTON>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi Paul,

--> http://www.linux-mips.org/archives/linux-mips/2015-09/msg00057.html

	John

On 10/09/2015 20:03, Paul Burton wrote:
> Ralf: is there a reason you've only applied patch 1 of this series?
> 
> v4.2 is broken because these didn't get in (despite being submitted well
> before the release), and master is still broken because they still
> haven't gotten in. If there's a reason you didn't merge them please let
> me know, otherwise please can we get them in ASAP.
> 
> Thanks,
>     Paul
> 
> On Wed, Aug 05, 2015 at 03:42:40PM -0700, Paul Burton wrote:
>> Commit 977e043d5ea1 ("MIPS: kernel: cps-vec: Replace mips32r2 ISA level
>> with mips64r2") leads to .set mips64r2 directives being present in 32
>> bit (ie. CONFIG_32BIT=y) kernels. This is incorrect & leads to MIPS64
>> instructions being emitted by the assembler when expanding
>> pseudo-instructions. For example the "move" instruction can legitimately
>> be expanded to a "daddu". This causes problems when the kernel is run on
>> a MIPS32 CPU, as CONFIG_32BIT kernels of course often are...
>>
>> Fix this by dropping the .set <ISA> directives entirely now that Kconfig
>> should be ensuring that kernels including this code are built with a
>> suitable -march= compiler flag.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> Cc: Markos Chandras <markos.chandras@imgtec.com>
>> Cc: <stable@vger.kernel.org> # 3.16+
>> ---
>>
>>  arch/mips/kernel/cps-vec.S | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
>> index 209ded1..763d8b7 100644
>> --- a/arch/mips/kernel/cps-vec.S
>> +++ b/arch/mips/kernel/cps-vec.S
>> @@ -229,7 +229,6 @@ LEAF(mips_cps_core_init)
>>  	has_mt	t0, 3f
>>  
>>  	.set	push
>> -	.set	mips64r2
>>  	.set	mt
>>  
>>  	/* Only allow 1 TC per VPE to execute... */
>> @@ -348,7 +347,6 @@ LEAF(mips_cps_boot_vpes)
>>  	 nop
>>  
>>  	.set	push
>> -	.set	mips64r2
>>  	.set	mt
>>  
>>  1:	/* Enter VPE configuration state */
>> -- 
>> 2.5.0
>>
> 
