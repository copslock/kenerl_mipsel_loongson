Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 21:09:57 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:39391 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993459AbdEZTJtaBeaZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2017 21:09:49 +0200
Received: from [85.5.174.220] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1dEKcE-0000MH-2G; Fri, 26 May 2017 21:09:38 +0200
Message-ID: <59287D71.6000307@iogearbox.net>
Date:   Fri, 26 May 2017 21:09:37 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 5/5] MIPS: Add support for eBPF JIT.
References: <20170526003826.10834-1-david.daney@cavium.com> <20170526003826.10834-6-david.daney@cavium.com> <5928463C.5000204@iogearbox.net> <e9c9348f-aa61-4384-e065-ba6bafc0bc13@caviumnetworks.com>
In-Reply-To: <e9c9348f-aa61-4384-e065-ba6bafc0bc13@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23420/Fri May 26 18:58:47 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58024
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

On 05/26/2017 05:39 PM, David Daney wrote:
> On 05/26/2017 08:14 AM, Daniel Borkmann wrote:
>> On 05/26/2017 02:38 AM, David Daney wrote:
>>> Since the eBPF machine has 64-bit registers, we only support this in
>>> 64-bit kernels.  As of the writing of this commit log test-bpf is showing:
>>>
>>>    test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
>>>
>>> All current test cases are successfully compiled.
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>
>> Awesome work!
>>
>> Did you also manage to run tools/testing/selftests/bpf/ fine with
>> the JIT enabled?
>
> I haven't done that yet, I will before the next revision.
>
>> [...]
>>> +struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>> +{
>>> +    struct jit_ctx ctx;
>>> +    unsigned int alloc_size;
>>> +
>>> +    /* Only 64-bit kernel supports eBPF */
>>> +    if (!IS_ENABLED(CONFIG_64BIT) || !bpf_jit_enable)
>>
>> Isn't this already reflected by the following?
>>
>>    select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
>
> Not exactly.  The eBPF JIT is in the same file as the classic-BPF JIT, so when HAVE_EBPF_JIT is false this will indeed never be called.  But the kernel would otherwise contain all the JIT code.
>
> By putting in !IS_ENABLED(CONFIG_64BIT) we allow gcc to eliminate all the dead code when compiling the JITs.

Side-effect would still be that for cBPF you go through the cBPF
JIT instead of letting the kernel convert all cBPF to eBPF and
later on go through your eBPF JIT. If you still prefer to have
everything in one single file and let gcc eliminate dead code
then you can just do single line change ...

void bpf_jit_compile(struct bpf_prog *fp)
{
         struct jit_ctx ctx;
         unsigned int alloc_size, tmp_idx;

         if (IS_ENABLED(CONFIG_HAVE_EBPF_JIT) || !bpf_jit_enable)
                 return;
         [...]
}

... and bpf_prog_ebpf_jited() et al wouldn't need to be changed
in the core, which are used in kallsyms, and kernel will then
also be able to automatically JIT all of seccomp-BPF and the
missing cBPF extensions we have through the eBPF JIT w/o extra
work.
