Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 12:07:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37507 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817074AbaEUKHcps2HQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 12:07:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EBE4B69ACDD1E;
        Wed, 21 May 2014 11:07:23 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 21 May
 2014 11:07:26 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 11:07:25 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 11:07:25 +0100
Message-ID: <537C7A12.7020606@imgtec.com>
Date:   Wed, 21 May 2014 11:04:02 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 06/15] MIPS: Add minimal support for OCTEON3 to c-r4k.c
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-7-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1400597236-11352-7-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 20/05/14 15:47, Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> These are needed to boot a generic mips64r2 kernel on OCTEONIII.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/include/asm/r4kcache.h |    2 ++
>  arch/mips/mm/c-r4k.c             |   32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 1c74a6a..789ede9 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c

> @@ -1094,6 +1110,21 @@ static void probe_pcache(void)
>  		c->dcache.waybit = 0;
>  		break;
>  
> +	case CPU_CAVIUM_OCTEON3:
> +		/* For now lie about the number of ways. */

Is this to work around the finite length of way_string[]?

Can we fix that to be more dynamic instead? (admittedly special casing
"direct mapped" looks like a bit of a pain).

Cheers
James

> +		c->icache.linesz = 128;
> +		c->icache.sets = 16;
> +		c->icache.ways = 8;
> +		c->icache.flags |= MIPS_CACHE_VTAG;
> +		icache_size = c->icache.sets * c->icache.ways * c->icache.linesz;
> +
> +		c->dcache.linesz = 128;
> +		c->dcache.ways = 8;
> +		c->dcache.sets = 8;
> +		dcache_size = c->dcache.sets * c->dcache.ways * c->dcache.linesz;
> +		c->options |= MIPS_CPU_PREFETCH;
> +		break;
> +
