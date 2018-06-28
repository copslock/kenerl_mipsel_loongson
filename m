Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 22:03:55 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:34744 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993852AbeF1UDrt05vm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 22:03:47 +0200
Subject: Re: [PATCH 04/25] MIPS: ath79: fix register address in
 ath79_ddr_wb_flush()
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@nbd.name>, Alban Bedel <albeu@free.fr>
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-5-john@phrozen.org>
 <20180628185149.gcmdyiiwxzk7vzox@pburton-laptop>
From:   John Crispin <john@phrozen.org>
Message-ID: <589ad46e-b646-e71f-be0c-72d8cc40077c@phrozen.org>
Date:   Thu, 28 Jun 2018 22:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628185149.gcmdyiiwxzk7vzox@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64493
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



On 28/06/18 20:51, Paul Burton wrote:
> Hi John,
>
> On Mon, Jun 25, 2018 at 07:15:28PM +0200, John Crispin wrote:
>> From: Felix Fietkau <nbd@nbd.name>
>>
>> ath79_ddr_wb_flush_base has the type void __iomem *, so register offsets
>> need to be a multiple of 4.
>>
>> Cc: Alban Bedel <albeu@free.fr>
>> Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   arch/mips/ath79/common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> This one looks like a pretty clear regression so would be good to go in
> mips-fixes, but could use your SoB like many others in the series.
>
> Thanks,
>      Paul
correct, its a regression, that has been there since the code was merged 
and if i am not mistaken made PCI defunct.
I'll add my SoB to the whole series when sending V2 and also Cc: stable 
on this one
     John
