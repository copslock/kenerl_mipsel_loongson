Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2017 03:18:59 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:33657 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994945AbdHSBSxGrfXu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Aug 2017 03:18:53 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1disPP-0007P1-GK; Sat, 19 Aug 2017 03:18:39 +0200
Message-ID: <599791EE.7010701@iogearbox.net>
Date:   Sat, 19 Aug 2017 03:18:38 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS,bpf: Improvements for MIPS eBPF JIT
References: <20170818234033.5990-1-david.daney@cavium.com>
In-Reply-To: <20170818234033.5990-1-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23681/Fri Aug 18 22:40:47 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59698
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

On 08/19/2017 01:40 AM, David Daney wrote:
> Here are several improvements and bug fixes for the MIPS eBPF JIT.
>
> The main change is the addition of support for JLT, JLE, JSLT and JSLE
> ops, that were recently added.
>
> Also fix WARN output when used with preemptable kernel, and a small
> cleanup/optimization in the use of BPF_OP(insn->code).
>
> I suggest that the whole thing go via the BPF/net-next path as there
> are dependencies on code that is not yet merged to Linus' tree.

Yes, this would be via net-next.

> Still pending are changes to reduce stack usage when the verifier can
> determine the maximum stack size.

Awesome, thanks a lot!
