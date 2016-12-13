Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 02:22:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53514 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993068AbcLMBWMmZ9Sg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Dec 2016 02:22:12 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBD1MBTL007032;
        Tue, 13 Dec 2016 02:22:12 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBD1MBgC007031;
        Tue, 13 Dec 2016 02:22:11 +0100
Date:   Tue, 13 Dec 2016 02:22:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     netdev@vger.kernel.org,
        "open list:MIPS" <linux-mips@linux-mips.org>
Subject: Re: [PATCH net-next 20/27] net/bpf_jit: MIPS: split VLAN_PRESENT bit
 handling from VLAN_TCI
Message-ID: <20161213012211.GF5107@linux-mips.org>
References: <cover.1481586602.git.mirq-linux@rere.qmqm.pl>
 <06129d2e359239a2df5c7a29c2d5e6dee32aa638.1481586602.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06129d2e359239a2df5c7a29c2d5e6dee32aa638.1481586602.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

I assume you want to merge this together with the rest of you series, so

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Cheers,

  Ralf

On Tue, Dec 13, 2016 at 01:12:39AM +0100, Michał Mirosław wrote:
> Date:   Tue, 13 Dec 2016 01:12:39 +0100 (CET)
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> To: netdev@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>, "open list:MIPS"
>  <linux-mips@linux-mips.org>
> Subject: [PATCH net-next 20/27] net/bpf_jit: MIPS: split VLAN_PRESENT bit
>  handling from VLAN_TCI
> Content-Type: text/plain; charset=UTF-8
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  arch/mips/net/bpf_jit.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> index 49a2e22..4b12b5d 100644
> --- a/arch/mips/net/bpf_jit.c
> +++ b/arch/mips/net/bpf_jit.c
> @@ -1138,19 +1138,23 @@ static int build_body(struct jit_ctx *ctx)
>  			emit_load(r_A, r_skb, off, ctx);
>  			break;
>  		case BPF_ANC | SKF_AD_VLAN_TAG:
> -		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
>  			ctx->flags |= SEEN_SKB | SEEN_A;
>  			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
>  						  vlan_tci) != 2);
>  			off = offsetof(struct sk_buff, vlan_tci);
>  			emit_half_load(r_s0, r_skb, off, ctx);
> -			if (code == (BPF_ANC | SKF_AD_VLAN_TAG)) {
> -				emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
> -			} else {
> -				emit_andi(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
> -				/* return 1 if present */
> -				emit_sltu(r_A, r_zero, r_A, ctx);
> -			}
> +#ifdef VLAN_TAG_PRESENT
> +			emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
> +#endif
> +			break;
> +		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
> +			ctx->flags |= SEEN_SKB | SEEN_A;
> +			emit_load_byte(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET(), ctx);
> +			if (PKT_VLAN_PRESENT_BIT)
> +				emit_srl(r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
> +			emit_andi(r_A, r_s0, 1, ctx);
> +			/* return 1 if present */
> +			emit_sltu(r_A, r_zero, r_A, ctx);
>  			break;
>  		case BPF_ANC | SKF_AD_PKTTYPE:
>  			ctx->flags |= SEEN_SKB;
> -- 
> 2.10.2
