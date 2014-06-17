Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 13:58:28 +0200 (CEST)
Received: from mail.active-venture.com ([67.228.131.205]:53907 "EHLO
        mail.active-venture.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860758AbaFQKj4bgNWF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 12:39:56 +0200
Received: (qmail 64748 invoked by uid 399); 17 Jun 2014 10:39:49 -0000
Received: from unknown (HELO server.roeck-us.net) (linux@roeck-us.net@108.223.40.66)
  by mail.active-venture.com with ESMTPAM; 17 Jun 2014 10:39:49 -0000
X-Originating-IP: 108.223.40.66
X-Sender: linux@roeck-us.net
Message-ID: <53A01AED.4010008@roeck-us.net>
Date:   Tue, 17 Jun 2014 03:39:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Daniel Borkmann <dborkman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: mips:allmodconfig build failure in 3.16-rc1 due to bpf_jit code
References: <539FA6CB.5050703@roeck-us.net> <539FFA6B.9030004@redhat.com> <53A01572.5090603@redhat.com>
In-Reply-To: <53A01572.5090603@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 06/17/2014 03:16 AM, Daniel Borkmann wrote:
> On 06/17/2014 10:20 AM, Daniel Borkmann wrote:
>> On 06/17/2014 04:24 AM, Guenter Roeck wrote:
>>> mips:allmodconfig fails in 3.16-rc1 with lots of undefined symbols.
>>>
>>> arch/mips/net/bpf_jit.c: In function 'is_load_to_a':
>>> arch/mips/net/bpf_jit.c:559:7: error: 'BPF_S_LD_W_LEN' undeclared (first use in this function)
>>> arch/mips/net/bpf_jit.c:559:7: note: each undeclared identifier is reported only once for each function it appears in
>>> arch/mips/net/bpf_jit.c:560:7: error: 'BPF_S_LD_W_ABS' undeclared (first use in this function)
>>> arch/mips/net/bpf_jit.c:561:7: error: 'BPF_S_LD_H_ABS' undeclared (first use in this function)
>>> arch/mips/net/bpf_jit.c:562:7: error: 'BPF_S_LD_B_ABS' undeclared (first use in this function)
>>> arch/mips/net/bpf_jit.c:563:7: error: 'BPF_S_ANC_CPU' undeclared (first use in this function)
>>> arch/mips/net/bpf_jit.c:564:7: error: 'BPF_S_ANC_IFINDEX' undeclared (first use in this function)
>>> arch/mips/net/bpf_jit.c:565:7: error: 'BPF_S_ANC_MARK' undeclared (first use in this function)
>>>
>>> and so on.
>>>
>>> Those symbols are not defined anywhere.
>>>
>>> The problem is due to a conflict with commit 348059313 (net: filter: get rid of BPF_S_*
>>> enum), which removed those definitions.
>>
>> Yep, it seems both got in this merge window from different trees. Don't have mips, but
>> I'll have a look, and send you a patch.
>
> Could you give the attached patch a try?
>

Yes, this fixes the build problem. Obviously I have no idea if it works ;-)

Guenter
