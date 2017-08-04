Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 15:05:41 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:54289 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995071AbdHDNFc6SBYT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 15:05:32 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ddcI4-0003dT-9s; Fri, 04 Aug 2017 15:05:20 +0200
Message-ID: <5984710F.4010301@iogearbox.net>
Date:   Fri, 04 Aug 2017 15:05:19 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "David S. Miller" <davem@davemloft.net>
CC:     David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James.Cowgill@imgtec.com,
        markos.chandras@imgtec.com
Subject: Re: [PATCH] MIPS: Add missing file for eBPF JIT.
References: <20170804001012.24901-1-david.daney@cavium.com>
In-Reply-To: <20170804001012.24901-1-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23628/Fri Aug  4 10:29:26 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59358
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

On 08/04/2017 02:10 AM, David Daney wrote:
> Inexplicably, commit f381bf6d82f0 ("MIPS: Add support for eBPF JIT.")
> lost a file somewhere on its path to Linus' tree.  Add back the
> missing ebpf_jit.c so that we can build with CONFIG_BPF_JIT selected.
>
> This version of ebpf_jit.c is identical to the original except for two
> minor change need to resolve conflicts with changes merged from the
> BPF branch:
>
> A) Set prog->jited_len = image_size;
> B) Use BPF_TAIL_CALL instead of BPF_CALL | BPF_X
>
> Fixes: f381bf6d82f0 ("MIPS: Add support for eBPF JIT.")
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>
> It might be best to merge this along the path of BPF fixes rather than
> MIPS, as the MIPS maintainer (Ralf) seems to be inactive recently.

Looks like situation is that multiple people including myself tried
to contact Ralf due to 'half/mis-applied' MIPS BPF JIT in [1,2] that
sits currently in Linus tree, but never got a reply back since mid June.

Given the work was accepted long ago but incorrectly merged, would be
great if this could still be fixed up with this patch. Given Ralf seems
unfortunately unresponsive, is there a chance, if people are fine with
it, that we could try route this fix e.g. via -net instead before a
final v4.13?

Anyway, the generic pieces interacting with core BPF look good to me:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks,
Daniel

   [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f381bf6d82f032b7410185b35d000ea370ac706b
   [2] https://patchwork.linux-mips.org/patch/16369/
