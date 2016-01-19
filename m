Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 16:34:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63405 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010763AbcASPesH-PJx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 16:34:48 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id BF92549D0FC57;
        Tue, 19 Jan 2016 15:34:38 +0000 (GMT)
Received: from [192.168.167.98] (192.168.167.98) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 19 Jan
 2016 15:34:41 +0000
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mips: scache: fix scache init with invalid line size.
References: <1453126706-24299-1-git-send-email-Govindraj.Raja@imgtec.com>
 <20160118150519.GC25510@jhogan-linux.le.imgtec.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>
Message-ID: <569E5790.4060704@imgtec.com>
Date:   Tue, 19 Jan 2016 15:34:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160118150519.GC25510@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.167.98]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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


Hi James,

On 18/01/16 15:05, James Hogan wrote:
> Hi Govindraj,
>
> On Mon, Jan 18, 2016 at 02:18:26PM +0000, Govindraj Raja wrote:
>> In current scache init cache line_size is determined from
>> cpu config register, however if there there no scache
>> then mips_sc_probe_cm3 function populates a invalid line_size of 2.
>>
>> The invalid line_size can cause a NULL pointer deference
>> during r4k_dma_cache_inv as r4k_blast_scache is populated based on
>> line_size. Scache line_size of 2 is invalid option in r4k_blast_scache_setup.
>>
>> This issue was faced during a MIPS I6400 based virtual platform bring up
>> where scache was not available in virtual platform model.
>>
>> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
>> ---
>>  arch/mips/mm/sc-mips.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
>> index 3bd0597..6e422bc 100644
>> --- a/arch/mips/mm/sc-mips.c
>> +++ b/arch/mips/mm/sc-mips.c
>> @@ -168,7 +168,8 @@ static int __init mips_sc_probe_cm3(void)
>>  
>>  	line_sz = cfg & CM_GCR_L2_CONFIG_LINE_SIZE_MSK;
>>  	line_sz >>= CM_GCR_L2_CONFIG_LINE_SIZE_SHF;
>> -	c->scache.linesz = 2 << line_sz;
>> +	if (line_sz)
>> +		c->scache.linesz = 2 << line_sz;
> It seems wrong to clear MIPS_CACHE_NOT_PRESENT if we know there isn't a
> cache actually present.
>
> Cheers
> James
>
>
Does this patch[1] makes sense?

I will repost v2 is its ok?

--
Thanks,
Govindraj.R

[1]:

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 3bd0597..68c48f4 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -164,11 +164,13 @@ static int __init mips_sc_probe_cm3(void)
 
        sets = cfg & CM_GCR_L2_CONFIG_SET_SIZE_MSK;
        sets >>= CM_GCR_L2_CONFIG_SET_SIZE_SHF;
-       c->scache.sets = 64 << sets;
+       if (sets)
+               c->scache.sets = 64 << sets;
 
        line_sz = cfg & CM_GCR_L2_CONFIG_LINE_SIZE_MSK;
        line_sz >>= CM_GCR_L2_CONFIG_LINE_SIZE_SHF;
-       c->scache.linesz = 2 << line_sz;
+       if (line_sz)
+               c->scache.linesz = 2 << line_sz;
 
        assoc = cfg & CM_GCR_L2_CONFIG_ASSOC_MSK;
        assoc >>= CM_GCR_L2_CONFIG_ASSOC_SHF;
@@ -176,7 +178,8 @@ static int __init mips_sc_probe_cm3(void)
        c->scache.waysize = c->scache.sets * c->scache.linesz;
        c->scache.waybit = __ffs(c->scache.waysize);
 
-       c->scache.flags &= ~MIPS_CACHE_NOT_PRESENT;
+       if (c->scache.linesz)
+               c->scache.flags &= ~MIPS_CACHE_NOT_PRESENT;
 
        return 1;
 }
