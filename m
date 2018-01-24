Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 07:15:05 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:45983 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeAXGO5bmB10 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 07:14:57 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 24 Jan 2018 06:13:12 +0000
Received: from [192.168.159.158] (192.168.159.158) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 23 Jan
 2018 22:13:10 -0800
Subject: Re: [PATCH 07/14] MIPS: memblock: Mark present sparsemem sections
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>,
        <goran.ferenc@mips.com>, <david.daney@cavium.com>,
        <paul.gortmaker@windriver.com>, <paul.burton@mips.com>,
        <alex.belits@cavium.com>, <Steven.Hill@cavium.com>
CC:     <alexander.sverdlin@nokia.com>, <matt.redfearn@mips.com>,
        <kumba@gentoo.org>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-8-fancer.lancer@gmail.com>
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
Message-ID: <7246ebaa-0ffa-f012-c18e-269b1e0130e6@mips.com>
Date:   Wed, 24 Jan 2018 07:13:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180117222312.14763-8-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.158]
X-BESS-ID: 1516774390-298555-16351-38487-9
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189299
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.20 BSF_SC7_SA298e         META: Custom Rule SA298e 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC7_SA298e, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62301
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

On 17.01.2018 23:23, Serge Semin wrote:
> If sparsemem is activated all sections with present pages must
> be accordingly marked after memblock is fully initialized.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   arch/mips/kernel/setup.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index b121fa702..6df1eaf38 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -778,7 +778,7 @@ static void __init request_crashkernel(struct resource *res)
>   
>   static void __init arch_mem_init(char **cmdline_p)
>   {
> -	struct memblock_region *reg;
> +	struct memblock_region *reg __maybe_unused;

nit: reg is used here. It becomes __maybe_unused in patch 8.


Marcin
