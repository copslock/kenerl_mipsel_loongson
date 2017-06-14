Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 02:05:07 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:47452 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994624AbdFNAFAJpARW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2017 02:05:00 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1dKvnn-00009W-Nv; Wed, 14 Jun 2017 02:04:51 +0200
Message-ID: <59407DA3.8050206@iogearbox.net>
Date:   Wed, 14 Jun 2017 02:04:51 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH v2 4/5] MIPS: Add support for eBPF JIT.
References: <20170613222847.7122-1-david.daney@cavium.com> <20170613222847.7122-5-david.daney@cavium.com>
In-Reply-To: <20170613222847.7122-5-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23471/Tue Jun 13 22:11:53 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58437
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

On 06/14/2017 12:28 AM, David Daney wrote:
> Since the eBPF machine has 64-bit registers, we only support this in
> 64-bit kernels.  As of the writing of this commit log test-bpf is showing:
>
>    test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
>
> All current test cases are successfully compiled.
>
> Many examples in samples/bpf are usable, specifically tracex5 which
> uses tail calls works.
>
> Signed-off-by: David Daney <david.daney@cavium.com>

Awesome work, David! The bits interacting with core BPF look
good to me.

Fyi, when Ralf merges this and it goes later on to Linus, there
will be two minor (silent) merge conflicts with net-next tree
(depending which one gets there first):

1) In bpf_int_jit_compile(), below the jited = 1 assignment, there
    needs to come a prog->jited_len = image_size.

2) The internal tail call opcode changed from BPF_JMP | BPF_CALL | BPF_X
    into BPF_JMP | BPF_TAIL_CALL.

Cheers,
Daniel
