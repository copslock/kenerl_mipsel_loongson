Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 10:18:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11447 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819433AbaFYISzu0rb6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 10:18:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 09664EFD6814;
        Wed, 25 Jun 2014 09:18:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 25 Jun 2014 09:18:48 +0100
Received: from [192.168.154.28] (192.168.154.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 25 Jun
 2014 09:18:48 +0100
Message-ID: <53AA85E8.5090403@imgtec.com>
Date:   Wed, 25 Jun 2014 09:18:48 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Alexei Starovoitov <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 16/17] MIPS: bpf: Use 32 or 64-bit load instruction to
 load an address to register
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com> <1403516340-22997-17-git-send-email-markos.chandras@imgtec.com> <20140623202437.GD2200@pburton-laptop>
In-Reply-To: <20140623202437.GD2200@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40792
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

On 06/23/2014 09:24 PM, Paul Burton wrote:
> On Mon, Jun 23, 2014 at 10:38:59AM +0100, Markos Chandras wrote:
>> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
>> index 4920e0fd05ee..d8dba7b523a5 100644
>> --- a/arch/mips/net/bpf_jit.c
>> +++ b/arch/mips/net/bpf_jit.c
>> @@ -447,6 +447,17 @@ static inline void emit_wsbh(unsigned int dst, unsigned int src,
>>  	emit_instr(ctx, wsbh, dst, src);
>>  }
>>  
>> +/* load address to register */
>> +static inline void emit_load_addr(unsigned int dst, unsigned int src,
>> +				     int imm, struct jit_ctx *ctx)
> 
> (I originally sent this in reply to your internal posting, but assume you
> missed it or it got eaten somewhere along the way.)
> 
> The name emit_load_addr & comment "load address to register" makes this
> sound like an equivalent of the "la" pseudo instruction, but it appears
> to really emit a pointer sized load? How about emit_load_ptr or something
> instead, and similarly s/address/pointer/ in the comment?
> 
Hi Paul,

I suppose I could do that. I will send a v2

>> +{
>> +	/* src contains the base addr of the 32/64-pointer */
>> +	if (config_enabled(CONFIG_64BIT))
>> +		emit_instr(ctx, ld, dst, imm, src);
>> +	else
>> +		emit_instr(ctx, lw, dst, imm, src);
> 
> Is there some way you could make use of the UASM_i_LW macro (note the
> capitalisation) instead of the if statement here?
> 

Not right now. I use config_enabled(CONFIG_64BIT) everywhere in that
file to emit 32-bit or 64-bit instructions. So I will look into
switching to the USAM_i_* macros when i submit the remaining fixes
probably for 3.17.

-- 
markos
