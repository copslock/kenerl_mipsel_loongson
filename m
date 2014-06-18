Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 10:28:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36708 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818452AbaFRI2eDzdDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 10:28:34 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 51A3689DF10AF;
        Wed, 18 Jun 2014 09:28:25 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 18 Jun 2014 09:28:26 +0100
Received: from [192.168.154.28] (192.168.154.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 18 Jun
 2014 09:28:26 +0100
Message-ID: <53A14DAA.3070207@imgtec.com>
Date:   Wed, 18 Jun 2014 09:28:26 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Network Development" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: mips:allmodconfig build failure in 3.16-rc1 due to bpf_jit code
References: <CAMEtUuz=us+=ejHaOf+Mq19hZoNJ=-faB9y4f4NC90=9E6Ck7g@mail.gmail.com>
In-Reply-To: <CAMEtUuz=us+=ejHaOf+Mq19hZoNJ=-faB9y4f4NC90=9E6Ck7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40622
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

On 06/17/2014 08:38 PM, Alexei Starovoitov wrote:
> On Tue, Jun 17, 2014 at 4:21 AM, Daniel Borkmann <dborkman@redhat.com> wrote:
>> On 06/17/2014 01:09 PM, Markos Chandras wrote:
>> ...
>>>
>>> Thanks for these instructions. I will try them myself once I find some
>>>
>>> time since I don't think bpf_jit for MIPS has ever been tested with all
>>> the opcodes.
>>
>>
>> Sounds great! If you find some tests are missing, please feel free to
>> submit them as well via netdev.
>>
>> Best,
>>
>> Daniel
> 
> Daniel,
> 
> thank you for taking care of it so quickly :)
> from the BPF perspective the fix looks good:
> Acked-by: Alexei Starovoitov <ast@plumgrid.com>
> 
> Markos,
> 
> please do run the testsuite.
> Doing quick code review of mips jit, it looks like:
> 
> - your version of pkt_type_offset() will work for little endian only.
>   (we've recently fixed it in net/core/filter.c)
> 
> - vlan tag handling is incorrect, since it's missing shifts.
>   classic BPF standard for vlan_tag_present has to return 1 or 0
>   and not just emit_and(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
> 
> - pr_warn("%s: Unhandled opcode: 0x%02x\n", __FILE__,
>   is way too heavy, since when jit is on, unprivileged user can spam log.
> 
> - /* sa is 5-bits long */
>   BUG_ON(sa >= BIT(5));
> is wrong too. Malicious user can cause kernel crash…
> Also shift A>>=33 was always allowed by classic BPF checker, so
> JITs have to silently do C-equivalent version of such shift.
> 
> - /* Determine if immediate is within the 16-bit signed range */
> static inline bool is_range16(s32 imm)
> {
>         if (imm >= SBIT(15) || imm < -SBIT(15))
>                 return true;
> the function name and comment are doing the opposite of
> actual code, which makes harder to follow.
> 
> - the rest looks pretty good!
> 
> Also you'll get a lot more mileage out of mips jit if you use eBPF
> instruction set as a base for JITing. You wouldn't need to worry
> about vlan, pkt_type and other classic extensions. You'll get all
> extensions for free, plus seccomp, tracing, etc.
> 
> Thanks
> Alexei
> 
Hi Alexei,

Thanks a lot for the feedback. I have already identified a few problems
which I have already fixed. I would like to move to eBPF but I can't
promise I can do it soon, so i think it's best to make sure that classic
BPF works fine for 3.16 and then I will make my plans for eBPF.

-- 
markos
