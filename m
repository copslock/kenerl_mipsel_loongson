Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 12:28:14 +0100 (CET)
Received: from www62.your-server.de ([213.133.104.62]:33642 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990434AbeKSL0xZXQmB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 12:26:53 +0100
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gOhhX-0008DQ-7g; Mon, 19 Nov 2018 12:26:47 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gOhhX-0005qG-1e; Mon, 19 Nov 2018 12:26:47 +0100
Subject: Re: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling
 from VLAN_TCI
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
Date:   Mon, 19 Nov 2018 12:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25134/Mon Nov 19 07:16:12 2018)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@iogearbox.net
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

On 11/10/2018 07:58 PM, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Why you have empty commit messages for non-trivial changes like this in
4 out of 6 of your patches ...

How was it tested on the JITs you were changing? Did you test on both,
big and little endian machines?

> ---
>  net/core/filter.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e521c5ebc7d1..c151b906df53 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -296,22 +296,21 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
>  		break;
>  
>  	case SKF_AD_VLAN_TAG:
> -	case SKF_AD_VLAN_TAG_PRESENT:
>  		BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
> -		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
>  
>  		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
>  		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
>  				      offsetof(struct sk_buff, vlan_tci));
> -		if (skb_field == SKF_AD_VLAN_TAG) {
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg,
> -						~VLAN_TAG_PRESENT);
> -		} else {
> -			/* dst_reg >>= 12 */
> -			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, 12);
> -			/* dst_reg &= 1 */
> +#ifdef VLAN_TAG_PRESENT
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, ~VLAN_TAG_PRESENT);
> +#endif
> +		break;
> +	case SKF_AD_VLAN_TAG_PRESENT:
> +		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
> +		if (PKT_VLAN_PRESENT_BIT)
> +			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, PKT_VLAN_PRESENT_BIT);
> +		if (PKT_VLAN_PRESENT_BIT < 7)
>  			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, 1);
> -		}
>  		break;
>  	}
>  
> @@ -6140,19 +6139,22 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  		break;
>  
>  	case offsetof(struct __sk_buff, vlan_present):
> +		*target_size = 1;
> +		*insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
> +				      PKT_VLAN_PRESENT_OFFSET());
> +		if (PKT_VLAN_PRESENT_BIT)
> +			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, PKT_VLAN_PRESENT_BIT);
> +		if (PKT_VLAN_PRESENT_BIT < 7)
> +			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
> +		break;
> +
>  	case offsetof(struct __sk_buff, vlan_tci):
> -		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
> -
>  		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
>  				      bpf_target_off(struct sk_buff, vlan_tci, 2,
>  						     target_size));
> -		if (si->off == offsetof(struct __sk_buff, vlan_tci)) {
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg,
> -						~VLAN_TAG_PRESENT);
> -		} else {
> -			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, 12);
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
> -		}
> +#ifdef VLAN_TAG_PRESENT
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, ~VLAN_TAG_PRESENT);
> +#endif
>  		break;
>  
>  	case offsetof(struct __sk_buff, cb[0]) ...
> 
