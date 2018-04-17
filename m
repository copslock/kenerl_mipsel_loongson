Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 15:20:10 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:36022 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeDQNUBsGZ3P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2018 15:20:01 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 17 Apr 2018 13:19:52 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 17
 Apr 2018 06:20:09 -0700
Subject: Re: [PATCH 1/2] MIPS: memset.S: EVA & fault support for small_memset
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
 <1522315704-31641-2-git-send-email-matt.redfearn@mips.com>
 <20180416202234.GA23881@saruman>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <cc6ab882-6862-2cdc-fdaf-cf0d0ba22728@mips.com>
Date:   Tue, 17 Apr 2018 14:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416202234.GA23881@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1523971192-321457-31281-52157-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192080
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

On 16/04/18 21:22, James Hogan wrote:
> On Thu, Mar 29, 2018 at 10:28:23AM +0100, Matt Redfearn wrote:
>> @@ -260,6 +260,11 @@
>>   	jr		ra
>>   	andi		v1, a2, STORMASK
> 
> This patch looks good, well spotted!
> 
> But whats that v1 write about? Any ideas? Seems to go back to the git
> epoch, and $3 isn't in the clobber lists when __bzero* is called.

No idea what the original intent was, but I've verified that v1 does 
indeed get clobbered if this path is hit. Patch incoming!

Thanks,
Matt

> 
> Cheers
> James
> 
>>   
>> +.Lsmall_fixup\@:
>> +	PTR_SUBU	a2, t1, a0
>> +	jr		ra
>> +	 PTR_ADDIU	a2, 1
>> +
