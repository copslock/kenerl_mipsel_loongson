Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 23:29:36 +0100 (CET)
Received: from www62.your-server.de ([213.133.104.62]:57411 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991232AbdCNW33zID9u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 23:29:29 +0100
Received: from [188.62.51.164] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1cnuwW-00014s-CU; Tue, 14 Mar 2017 23:29:24 +0100
Message-ID: <58C86EC3.9010406@iogearbox.net>
Date:   Tue, 14 Mar 2017 23:29:23 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
CC:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: Re: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
References: <20170314212144.29988-1-david.daney@cavium.com>
In-Reply-To: <20170314212144.29988-1-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23204/Tue Mar 14 21:16:16 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57268
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

On 03/14/2017 10:21 PM, David Daney wrote:
> Changes from v1:
>
>    - Use unsigned access for SKF_AD_HATYPE
>
>    - Added three more patches for other problems found.
>
>
> Testing the BPF JIT on Cavium OCTEON (mips64) with the test-bpf module
> identified some failures and unimplemented features.

Nice, thanks for working on this! If you see specific test
cases for the JIT missing, please also feel free to extend
the test_bpf suite, so this gets exposed further to other
JITs, too.

> With this patch set we get:
>
>       test_bpf: Summary: 305 PASSED, 0 FAILED, [85/297 JIT'ed]
>
> Both big and little endian tested.
>
> We still lack eBPF support, but this is better than nothing.

Any future plans on this one?

Thanks,
Daniel
