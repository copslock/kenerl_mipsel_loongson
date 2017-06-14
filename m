Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 02:22:53 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:49433 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994625AbdFNAWoYezSW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2017 02:22:44 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1dKw4x-0002Iw-CT; Wed, 14 Jun 2017 02:22:35 +0200
Message-ID: <594081CA.3060801@iogearbox.net>
Date:   Wed, 14 Jun 2017 02:22:34 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 0/4] bpf: Changes needed (or desired) for MIPS support
References: <20170613234938.4823-1-david.daney@cavium.com>
In-Reply-To: <20170613234938.4823-1-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23471/Tue Jun 13 22:11:53 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58442
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

On 06/14/2017 01:49 AM, David Daney wrote:
> This is a grab bag of changes to the bpf testing infrastructure I
> developed working on MIPS eBPF JIT support.  The change to
> bpf_jit_disasm is probably universally beneficial, the others are more
> MIPS specific.

I think these could go independently through net-next tree?

Thanks,
Daniel

> David Daney (4):
>    tools: bpf_jit_disasm:  Handle large images.
>    test_bpf: Add test to make conditional jump cross a large number of
>      insns.
>    bpf: Add MIPS support to samples/bpf.
>    samples/bpf: Fix tracex5 to work with MIPS syscalls.
>
>   lib/test_bpf.c             | 32 ++++++++++++++++++++++++++++++++
>   samples/bpf/Makefile       | 13 +++++++++++++
>   samples/bpf/bpf_helpers.h  | 13 +++++++++++++
>   samples/bpf/syscall_nrs.c  | 12 ++++++++++++
>   samples/bpf/tracex5_kern.c | 11 ++++++++---
>   tools/net/bpf_jit_disasm.c | 37 ++++++++++++++++++++++++++-----------
>   6 files changed, 104 insertions(+), 14 deletions(-)
>   create mode 100644 samples/bpf/syscall_nrs.c
>
