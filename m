Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 08:20:01 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:54978 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbdLVHTwLzo6X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Dec 2017 08:19:52 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 22 Dec 2017 07:18:16 +0000
Received: from [192.168.159.66] (192.168.159.66) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Dec
 2017 23:18:15 -0800
Subject: Re: [RFC] MIPS memblock: Remove bootmem code and switch to NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <matt.redfearn@imgtec.com>, <james.hogan@imgtec.com>,
        <alexander.sverdlin@nokia.com>, <marcin.nowakowski@imgtec.com>,
        <f.fainelli@gmail.com>, <kumba@gentoo.org>
CC:     <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219201400.GA10185@mobilestation>
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
Message-ID: <eace1075-4e3f-1f0c-50ed-73a566ecd39b@mips.com>
Date:   Fri, 22 Dec 2017 08:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171219201400.GA10185@mobilestation>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.66]
X-BESS-ID: 1513927096-298552-20497-41087-1
X-BESS-VER: 2017.16-r1712182224
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188251
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@mips.com
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

Hi Serge,

On 19.12.2017 21:14, Serge Semin wrote:
> Hello folks,
> 
> Almost a year ago I sent a patchset to the Linux MIPS community. The main target of the patchset
> was to get rid from the old bootmem allocator usage at the MIPS architecture. Additionally I had
> a problem with CMA usage on my MIPS machine due to some struct page-related issue. Moving to the
> memblock allocator fixed the problem and gave us benefits like smaller memory consumption,
> powerful memblock API to be used within the arch code.
> 
> @marcin.nowakowski@imgtec.com. Could you confirm if you are still interested in the patchset and
> ready to update the Loongson64 platform code so one would be compatible with it?

I am currently working on different projects, but I will try to do my 
best to help with this (but just might require more time than I would 
otherwise need).
Given the scale of the task and the amount of testing required, I expect 
that it will take a while to get a complete set of patches reviewed and 
tested which should hopefully be enough to fix support for all platforms 
affected.

Marcin
