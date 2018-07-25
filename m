Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 18:33:06 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:40852 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991947AbeGYQc7zHITJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 18:32:59 +0200
Subject: Re: [PATCH 4/4] net: dsa: Add Lantiq / Intel DSA driver for vrx200
To:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-5-hauke@hauke-m.de>
From:   John Crispin <john@phrozen.org>
Message-ID: <0dd1ff0b-92eb-5c8f-f7b8-266cb79475da@phrozen.org>
Date:   Wed, 25 Jul 2018 18:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721191358.13952-5-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65144
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



On 21/07/18 21:13, Hauke Mehrtens wrote:
> +#define MC_ENTRY(val, msk, ns, out, len, type, flags, ipv4_len) \
> +	{ val, msk, (ns << 10 | out << 4 | len >> 1),\
> +		(len & 1) << 15 | type << 13 | flags << 9 | ipv4_len << 8 }
> +static const struct gswip_pce_microcode gswip_pce_microcode[] = {
> +	/*      value    mask    ns  fields      L  type     flags       ipv4_len */
> +	MC_ENTRY(0x88c3, 0xFFFF,  1, OUT_ITAG0,  4, INSTR,   FLAG_ITAG,  0),
> +	MC_ENTRY(0x8100, 0xFFFF,  2, OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
> +	MC_ENTRY(0x88A8, 0xFFFF,  1, OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
> +	MC_ENTRY(0x8100, 0xFFFF,  1, OUT_VTAG0,  2, INSTR,   FLAG_VLAN,  0),
> +	MC_ENTRY(0x8864, 0xFFFF, 17, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0800, 0xFFFF, 21, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x86DD, 0xFFFF, 22, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x8863, 0xFFFF, 16, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0xF800, 10, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 40, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0600, 0x0600, 40, OUT_ETHTYP, 1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 12, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0xAAAA, 0xFFFF, 14, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0300, 0xFF00, 41, OUT_NONE,   0, INSTR,   FLAG_SNAP,  0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_DIP7,   3, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 18, OUT_DIP7,   3, INSTR,   FLAG_PPPOE, 0),
> +	MC_ENTRY(0x0021, 0xFFFF, 21, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0057, 0xFFFF, 22, OUT_NONE,   1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 40, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x4000, 0xF000, 24, OUT_IP0,    4, INSTR,   FLAG_IPV4,  1),
> +	MC_ENTRY(0x6000, 0xF000, 27, OUT_IP0,    3, INSTR,   FLAG_IPV6,  0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 25, OUT_IP3,    2, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 26, OUT_SIP0,   4, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 40, OUT_NONE,   0, LENACCU, FLAG_NO,    0),
> +	MC_ENTRY(0x1100, 0xFF00, 39, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0600, 0xFF00, 39, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0xFF00, 33, OUT_IP3,   17, INSTR,   FLAG_HOP,   0),
> +	MC_ENTRY(0x2B00, 0xFF00, 33, OUT_IP3,   17, INSTR,   FLAG_NN1,   0),
> +	MC_ENTRY(0x3C00, 0xFF00, 33, OUT_IP3,   17, INSTR,   FLAG_NN2,   0),
> +	MC_ENTRY(0x0000, 0x0000, 39, OUT_PROT,   1, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x00E0, 35, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 40, OUT_NONE,   0, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0xFF00, 33, OUT_NONE,   0, IPV6,    FLAG_HOP,   0),
> +	MC_ENTRY(0x2B00, 0xFF00, 33, OUT_NONE,   0, IPV6,    FLAG_NN1,   0),
> +	MC_ENTRY(0x3C00, 0xFF00, 33, OUT_NONE,   0, IPV6,    FLAG_NN2,   0),
> +	MC_ENTRY(0x0000, 0x0000, 40, OUT_PROT,   1, IPV6,    FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 40, OUT_SIP0,  16, INSTR,   FLAG_NO,    0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_APP0,   4, INSTR,   FLAG_IGMP,  0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +	MC_ENTRY(0x0000, 0x0000, 41, OUT_NONE,   0, INSTR,   FLAG_END,   0),
> +};

i extracted this struct/blob/voodoo from UGW3/4 7 years ago and was 
puzzled by it. for those of us that have worked with this table in the 
past, its semi understandable, yet its almost like a blackbox FW blob. 
can we try to make it a little more readable by adding a comment on each 
line explaining why its there and what it does ?
     John
