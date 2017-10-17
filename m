Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 09:19:38 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.233]:38644 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990429AbdJQHTbddWpW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Oct 2017 09:19:31 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 17 Oct 2017 07:19:05 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 17 Oct
 2017 00:18:26 -0700
Subject: Re: [PATCH 4.4 36/50] MIPS: IRQ Stack: Unwind IRQ stack onto task
 stack
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <stable@vger.kernel.org>, Matt Redfearn <matt.redfearn@imgtec.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        "Chris Metcalf" <cmetcalf@mellanox.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
References: <20171006083705.157012217@linuxfoundation.org>
 <20171006083711.033827562@linuxfoundation.org>
 <1508189305.22379.54.camel@codethink.co.uk>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <599a61c7-b25c-47a7-7664-443666d2d8bd@mips.com>
Date:   Tue, 17 Oct 2017 08:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1508189305.22379.54.camel@codethink.co.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1508224670-452059-5275-388414-10
X-BESS-VER: 2017.12.1-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186048
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
X-archive-position: 60418
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



On 16/10/17 22:28, Ben Hutchings wrote:
> On Fri, 2017-10-06 at 10:53 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Matt Redfearn <matt.redfearn@imgtec.com>
>>
>>
>> [ Upstream commit db8466c581cca1a08b505f1319c3ecd246f16fa8 ]
> [...]
>
> There was a follow-up to this which I suspect is also needed on the 4.4
> and 4.9 branches: commit 5fdc66e04620 ("MIPS: Fix minimum alignment
> requirement of IRQ stack").
>
> Ben.
>
Hi Ben,

Yes you are correct, I missed tagging that one for stable. Please apply it.

Thanks,
Matt
