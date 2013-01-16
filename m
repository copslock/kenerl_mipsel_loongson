Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 18:57:11 +0100 (CET)
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:38944
        "EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832231Ab3APR5KCYuq3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 18:57:10 +0100
Received: from mail143-co9-R.bigfish.com (10.236.132.246) by
 CO9EHSOBE025.bigfish.com (10.236.130.88) with Microsoft SMTP Server id
 14.1.225.23; Wed, 16 Jan 2013 17:57:01 +0000
Received: from mail143-co9 (localhost [127.0.0.1])      by
 mail143-co9-R.bigfish.com (Postfix) with ESMTP id 3498B1E01DB; Wed, 16 Jan
 2013 17:57:00 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.1.197;KIP:(null);UIP:(null);IPV:NLI;H:BLUPRD0712HT002.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1ee6h1de0h1202h1e76h1d1ah1d2ahzz8275dhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h1155h)
Received: from mail143-co9 (localhost.localdomain [127.0.0.1]) by mail143-co9
 (MessageSwitch) id 1358358976557001_31265; Wed, 16 Jan 2013 17:56:16 +0000
 (UTC)
Received: from CO9EHSMHS026.bigfish.com (unknown [10.236.132.245])      by
 mail143-co9.bigfish.com (Postfix) with ESMTP id F3A7E400B4;    Wed, 16 Jan 2013
 17:56:09 +0000 (UTC)
Received: from BLUPRD0712HT002.namprd07.prod.outlook.com (132.245.1.197) by
 CO9EHSMHS026.bigfish.com (10.236.130.36) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Wed, 16 Jan 2013 17:56:09 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.218.163) with Microsoft SMTP Server (TLS) id 14.16.257.4; Wed, 16 Jan
 2013 17:56:05 +0000
Message-ID: <50F6E9B3.5010202@caviumnetworks.com>
Date:   Wed, 16 Jan 2013 09:56:03 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Cong Ding <dinggnu@gmail.com>, Jim Quinlan <jim2101024@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mpis: cavium-octeon/executive/cvmx-l2c.c: fix uninitialized
 variable
References: <1358200025-15994-1-git-send-email-dinggnu@gmail.com> <20130116105757.GB26569@linux-mips.org>
In-Reply-To: <20130116105757.GB26569@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 35470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/16/2013 02:57 AM, Ralf Baechle wrote:
> On Mon, Jan 14, 2013 at 10:47:03PM +0100, Cong Ding wrote:
>
>> the variable dummy is used without initialization.
>
> Interesting - I wonder how you found this one.  My compiler (gcc 4.7)
> doesn't warn about this one.
>

I get no warnings either.  So I wonder what the point of churning up the 
code is.

David Daney

> Nor does gcc notice that the whole summing up business is wasted efford.
>
> So here's my counter proposal.  It works because ptr is a volatile pointer
> so the compiler will always dereference it even if the returned value is
> not being used.  The resulting code is a bit smaller.
>
>    Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
>   arch/mips/cavium-octeon/executive/cvmx-l2c.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
> index 9f883bf..ec3e059 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-l2c.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
> @@ -286,7 +286,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
>   static void fault_in(uint64_t addr, int len)
>   {
>   	volatile char *ptr;
> -	volatile char dummy;
> +
>   	/*
>   	 * Adjust addr and length so we get all cache lines even for
>   	 * small ranges spanning two cache lines.
> @@ -300,7 +300,7 @@ static void fault_in(uint64_t addr, int len)
>   	 */
>   	CVMX_DCACHE_INVALIDATE;
>   	while (len > 0) {
> -		dummy += *ptr;
> +		*ptr;
>   		len -= CVMX_CACHE_LINE_SIZE;
>   		ptr += CVMX_CACHE_LINE_SIZE;
>   	}
>
>
>
