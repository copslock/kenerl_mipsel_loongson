Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 11:42:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41588 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835073AbaEUJmK4ia10 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 11:42:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BE1A793CBD46D;
        Wed, 21 May 2014 10:42:01 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 21 May
 2014 10:42:03 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 10:42:03 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 10:42:02 +0100
Message-ID: <537C741F.60104@imgtec.com>
Date:   Wed, 21 May 2014 10:38:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/15] MIPS: Don't build fast TLB refill handler with
 32-bit kernels.
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-6-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1400597236-11352-6-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40209
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
> The fast handler only supports 64-bit kernels.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/mm/tlbex.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index ee88367..781e183 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1250,13 +1250,17 @@ static void build_r4000_tlb_refill_handler(void)
>  	unsigned int final_len;
>  	struct mips_huge_tlb_info htlb_info __maybe_unused;
>  	enum vmalloc64_mode vmalloc_mode __maybe_unused;
> -
> +#ifdef CONFIG_64BIT
> +	bool is64bit = true;
> +#else
> +	bool is64bit = false;
> +#endif
>  	memset(tlb_handler, 0, sizeof(tlb_handler));
>  	memset(labels, 0, sizeof(labels));
>  	memset(relocs, 0, sizeof(relocs));
>  	memset(final_handler, 0, sizeof(final_handler));
>  
> -	if ((scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
> +	if (is64bit && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
>  		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
>  							  scratch_reg);
>  		vmalloc_mode = refill_scratch;
> 

This looks like a good place to use IS_ENABLED(CONFIG_64BIT) to reduce
ifdefery.

Cheers
James
