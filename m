Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 11:23:46 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:47063 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993124AbeDCJXitnyBD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 11:23:38 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 03 Apr 2018 09:23:02 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 3 Apr
 2018 02:23:12 -0700
Subject: Re: [PATCH v4 3/3] MIPS: use generic GCC library routines from lib/
To:     James Hogan <jhogan@kernel.org>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
 <1522320083-27818-3-git-send-email-matt.redfearn@mips.com>
 <20180403085354.GC31222@saruman>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <b0eaccce-a316-0515-cab7-a026be1720b1@mips.com>
Date:   Tue, 3 Apr 2018 10:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403085354.GC31222@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1522747382-298552-8656-22664-1
X-BESS-VER: 2018.4-r1803302247
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191650
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63386
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



On 03/04/18 09:53, James Hogan wrote:
> On Thu, Mar 29, 2018 at 11:41:23AM +0100, Matt Redfearn wrote:
>> This commit removes several generic GCC library routines from
>> arch/mips/lib/ in favour of similar routines from lib/.
> 
>> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
>> index e84e12655fa8..6537e022ef62 100644
>> --- a/arch/mips/lib/Makefile
>> +++ b/arch/mips/lib/Makefile
>> @@ -16,5 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>>   obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>>   
>>   # libgcc-style stuff needed in the kernel
>> -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o multi3.o \
>> -	 ucmpdi2.o
>> +obj-y += bswapsi.o bswapdi.o multi3.o
> 
> Have you missed deleting the files?

Oops, got lost during the rebase :-/

Thanks,
Matt

> 
> Cheers
> James
> 
