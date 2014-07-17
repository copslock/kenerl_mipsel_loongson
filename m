Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 15:52:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32917 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861326AbaGQNwymXP2v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 15:52:54 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A7683309230B;
        Thu, 17 Jul 2014 14:52:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 14:52:47 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 14:52:46 +0100
Message-ID: <53C7D52E.5020205@imgtec.com>
Date:   Thu, 17 Jul 2014 14:52:46 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Andrey Utkin <andrey.krieger.utkin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     <dborkman@redhat.com>, <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] arch/mips/net/bpf_jit.c: fix failure check
References: <1405603655-12571-1-git-send-email-andrey.krieger.utkin@gmail.com>
In-Reply-To: <1405603655-12571-1-git-send-email-andrey.krieger.utkin@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 07/17/2014 02:27 PM, Andrey Utkin wrote:
> static int pkt_type_offset(void) returned -1 in case of failure, and
> actual (positive) offset value in case of success. In the only instance
> of its usage, the result was saved to local "unsigned int off" variable,
>    which is used in a lot of places in the same (large) function, so
>    changing its type could cause many warnings.
> There was no signed int variable which could be just used for this case.
> There are two possibilities to resolve that: to declare temporary signed
> int variable to get the return value from pkt_type_offset(), or to
> separate return status from returned offset value. The latter approach
> was chosen, however, I am not sure which would be practically optimal.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=80371
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
> ---
>  arch/mips/net/bpf_jit.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> index b87390a..47f65d5 100644
> --- a/arch/mips/net/bpf_jit.c
> +++ b/arch/mips/net/bpf_jit.c
> @@ -770,7 +770,7 @@ static u64 jit_get_skb_w(struct sk_buff *skb, unsigned offset)
>  #else
>  #define PKT_TYPE_MAX	7
>  #endif
> -static int pkt_type_offset(void)
> +static int pkt_type_offset(unsigned int *off_arg)
>  {
>  	struct sk_buff skb_probe = {
>  		.pkt_type = ~0,
> @@ -779,8 +779,10 @@ static int pkt_type_offset(void)
>  	unsigned int off;
>  
>  	for (off = 0; off < sizeof(struct sk_buff); off++) {
> -		if (ct[off] == PKT_TYPE_MAX)
> -			return off;
> +		if (ct[off] == PKT_TYPE_MAX) {
> +			*off_arg = off;
> +			return 0;
> +		}
>  	}
>  	pr_err_once("Please fix pkt_type_offset(), as pkt_type couldn't be found\n");
>  	return -1;
> @@ -1332,9 +1334,7 @@ jmp_cmp:
>  		case BPF_ANC | SKF_AD_PKTTYPE:
>  			ctx->flags |= SEEN_SKB;
>  
> -			off = pkt_type_offset();
> -
> -			if (off < 0)
> +			if (pkt_type_offset(&off))
>  				return -1;
>  			emit_load_byte(r_tmp, r_skb, off, ctx);
>  			/* Keep only the last 3 bits */
> 
Hi,

Thanks for the patch. I would personally prefer to use a new signed int
variable, but I am fine either way.

-- 
markos
