Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 01:36:57 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:59184 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdCOAgugTqh8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 01:36:50 +0100
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E1B4133F92FE;
        Tue, 14 Mar 2017 17:36:46 -0700 (PDT)
Date:   Tue, 14 Mar 2017 17:36:45 -0700 (PDT)
Message-Id: <20170314.173645.1126342566528886979.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     david.daney@cavium.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, james.hogan@imgtec.com, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        steven.hill@cavium.com
Subject: Re: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1d09f001-aa15-e3bf-be85-a13b1132a12a@caviumnetworks.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
        <20170314.172937.1289357366273291363.davem@davemloft.net>
        <1d09f001-aa15-e3bf-be85-a13b1132a12a@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Mar 2017 17:36:46 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: David Daney <ddaney@caviumnetworks.com>
Date: Tue, 14 Mar 2017 17:34:02 -0700

> On 03/14/2017 05:29 PM, David Miller wrote:
>> From: David Daney <david.daney@cavium.com>
>> Date: Tue, 14 Mar 2017 14:21:39 -0700
>>
>>> Changes from v1:
>>>
>>>   - Use unsigned access for SKF_AD_HATYPE
>>>
>>>   - Added three more patches for other problems found.
>>>
>>>
>>> Testing the BPF JIT on Cavium OCTEON (mips64) with the test-bpf module
>>> identified some failures and unimplemented features.
>>>
>>> With this patch set we get:
>>>
>>>      test_bpf: Summary: 305 PASSED, 0 FAILED, [85/297 JIT'ed]
>>>
>>> Both big and little endian tested.
>>>
>>> We still lack eBPF support, but this is better than nothing.
>>
>> What tree are you targetting with these changes?  Do you expect
>> them to go via the MIPS or the net-next tree?
>>
>> Please be explicit about this in the future.
>>
> 
> Sorry I didn't mention it.
> 
> My expectation is that Ralf would merge it via the MIPS tree, as it is
> fully contained within arch/mips/*

Great, thanks for letting me know.
