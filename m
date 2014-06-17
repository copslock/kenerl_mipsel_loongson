Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 14:19:18 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:23671 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860425AbaFQK43OlgGP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jun 2014 12:56:29 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5HAuEbw009456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jun 2014 06:56:14 -0400
Received: from [10.36.5.8] (vpn1-5-8.ams2.redhat.com [10.36.5.8])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5HAuAPE022797
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Tue, 17 Jun 2014 06:56:12 -0400
Message-ID: <53A01ECA.6090504@redhat.com>
Date:   Tue, 17 Jun 2014 12:56:10 +0200
From:   Daniel Borkmann <dborkman@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: mips:allmodconfig build failure in 3.16-rc1 due to bpf_jit code
References: <539FA6CB.5050703@roeck-us.net> <539FFA6B.9030004@redhat.com> <53A01572.5090603@redhat.com> <53A01AED.4010008@roeck-us.net>
In-Reply-To: <53A01AED.4010008@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <dborkman@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dborkman@redhat.com
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

On 06/17/2014 12:39 PM, Guenter Roeck wrote:
> On 06/17/2014 03:16 AM, Daniel Borkmann wrote:
>> On 06/17/2014 10:20 AM, Daniel Borkmann wrote:
>>> On 06/17/2014 04:24 AM, Guenter Roeck wrote:
>>>> mips:allmodconfig fails in 3.16-rc1 with lots of undefined symbols.
>>>>
>>>> arch/mips/net/bpf_jit.c: In function 'is_load_to_a':
>>>> arch/mips/net/bpf_jit.c:559:7: error: 'BPF_S_LD_W_LEN' undeclared (first use in this function)
>>>> arch/mips/net/bpf_jit.c:559:7: note: each undeclared identifier is reported only once for each function it appears in
>>>> arch/mips/net/bpf_jit.c:560:7: error: 'BPF_S_LD_W_ABS' undeclared (first use in this function)
>>>> arch/mips/net/bpf_jit.c:561:7: error: 'BPF_S_LD_H_ABS' undeclared (first use in this function)
>>>> arch/mips/net/bpf_jit.c:562:7: error: 'BPF_S_LD_B_ABS' undeclared (first use in this function)
>>>> arch/mips/net/bpf_jit.c:563:7: error: 'BPF_S_ANC_CPU' undeclared (first use in this function)
>>>> arch/mips/net/bpf_jit.c:564:7: error: 'BPF_S_ANC_IFINDEX' undeclared (first use in this function)
>>>> arch/mips/net/bpf_jit.c:565:7: error: 'BPF_S_ANC_MARK' undeclared (first use in this function)
>>>>
>>>> and so on.
>>>>
>>>> Those symbols are not defined anywhere.
>>>>
>>>> The problem is due to a conflict with commit 348059313 (net: filter: get rid of BPF_S_*
>>>> enum), which removed those definitions.
>>>
>>> Yep, it seems both got in this merge window from different trees. Don't have mips, but
>>> I'll have a look, and send you a patch.
>>
>> Could you give the attached patch a try?
>
> Yes, this fixes the build problem. Obviously I have no idea if it works ;-)

Thanks Guenter!

We have a test suite for BPF under lib/test_bpf.c that was designed for the
interpreter and for BPF JIT developers in mind and pretty much covers most
cases. E.g. one possibility to run it would be:

   0) compile module test_bpf (Kernel Hacking -> Test BPF filter functionality)
   1) echo 1 > /proc/sys/net/core/bpf_jit_enable           [<- enables BPF JIT]
   2) modprobe test_bpf                                    [<- runs test suite]

The results will be visible in the klog via dmesg (if at least one test fails,
the module init handler will return an error).

Best,

Daniel
