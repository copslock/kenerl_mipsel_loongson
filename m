Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 15:16:10 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:54068 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbeDXNQD2R1qw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2018 15:16:03 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 24 Apr 2018 13:15:41 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 24
 Apr 2018 06:15:59 -0700
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, <oprofile-list@lists.sf.net>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
Date:   Tue, 24 Apr 2018 14:15:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424130511.GB28813@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524575740-637137-13540-10775-1
X-BESS-VER: 2018.5-r1804232011
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192328
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
X-archive-position: 63728
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



On 24/04/18 14:05, James Hogan wrote:
> On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
>> Since it appears that MIPS oprofile support is currently broken, core
>> oprofile is not getting many updates and not as many architectures
>> implement support for it compared to perf, remove the MIPS support.
> 
> That sounds reasonable to me. Any idea how long its been broken?

Sorry, not yet. I haven't yet looked into where/how it's broken that 
would narrow that down...

The other thing to bear in mind is that the userspace tools have not 
seen any MIPS additions since 2010, the last commit being to add 1004K 
and 34K support:
https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/events/mips/

Though I'm not sure if anyone is maintaining a vendor specific fork 
containing further support.

> 
> I'll let it sit on the list for a bit in case anybody does object and
> wants to fix it instead.

Cool, sounds good.

Thanks,
Matt

> 
> Thanks
> James
> 
