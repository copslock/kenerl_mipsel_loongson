Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 14:08:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13158 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860786AbaFQKydZE7RJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 12:54:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E4CB2B2278E54;
        Tue, 17 Jun 2014 11:54:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 17 Jun 2014 11:54:26 +0100
Received: from [192.168.154.28] (192.168.154.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 17 Jun
 2014 11:54:25 +0100
Message-ID: <53A01E61.3090600@imgtec.com>
Date:   Tue, 17 Jun 2014 11:54:25 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Daniel Borkmann <dborkman@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux MIPS Mailing List" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Subject: Re: mips:allmodconfig build failure in 3.16-rc1 due to bpf_jit code
References: <539FA6CB.5050703@roeck-us.net> <539FFA6B.9030004@redhat.com> <53A01572.5090603@redhat.com>
In-Reply-To: <53A01572.5090603@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40562
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

On 06/17/2014 11:16 AM, Daniel Borkmann wrote:
> On 06/17/2014 10:20 AM, Daniel Borkmann wrote:
>> On 06/17/2014 04:24 AM, Guenter Roeck wrote:
>>> mips:allmodconfig fails in 3.16-rc1 with lots of undefined symbols.
>>>
>>> arch/mips/net/bpf_jit.c: In function 'is_load_to_a':
>>> arch/mips/net/bpf_jit.c:559:7: error: 'BPF_S_LD_W_LEN' undeclared
>>> (first use in this function)
>>> arch/mips/net/bpf_jit.c:559:7: note: each undeclared identifier is
>>> reported only once for each function it appears in
>>> arch/mips/net/bpf_jit.c:560:7: error: 'BPF_S_LD_W_ABS' undeclared
>>> (first use in this function)
>>> arch/mips/net/bpf_jit.c:561:7: error: 'BPF_S_LD_H_ABS' undeclared
>>> (first use in this function)
>>> arch/mips/net/bpf_jit.c:562:7: error: 'BPF_S_LD_B_ABS' undeclared
>>> (first use in this function)
>>> arch/mips/net/bpf_jit.c:563:7: error: 'BPF_S_ANC_CPU' undeclared
>>> (first use in this function)
>>> arch/mips/net/bpf_jit.c:564:7: error: 'BPF_S_ANC_IFINDEX' undeclared
>>> (first use in this function)
>>> arch/mips/net/bpf_jit.c:565:7: error: 'BPF_S_ANC_MARK' undeclared
>>> (first use in this function)
>>>
>>> and so on.
>>>
>>> Those symbols are not defined anywhere.
>>>
>>> The problem is due to a conflict with commit 348059313 (net: filter:
>>> get rid of BPF_S_*
>>> enum), which removed those definitions.
>>
>> Yep, it seems both got in this merge window from different trees.
>> Don't have mips, but
>> I'll have a look, and send you a patch.
> 
> Could you give the attached patch a try?
> 
> Thanks,
> 
> Daniel

Hi Daniel,

This fixes the build and seems to work ok (tried with dhcp and tcpdump).
Thanks for fixing it.

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Tested-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
