Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 17:37:37 +0100 (CET)
Received: from www62.your-server.de ([213.133.104.62]:45993 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006757AbcAEQhetg6-a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 17:37:34 +0100
Received: from [178.194.100.72] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.80.1)
        (envelope-from <daniel@iogearbox.net>)
        id 1aGUbI-00073q-Vh; Tue, 05 Jan 2016 17:36:49 +0100
Message-ID: <568BF11F.1060507@iogearbox.net>
Date:   Tue, 05 Jan 2016 17:36:47 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Rabin Vincent <rabin@rab.in>, davem@davemloft.net
CC:     netdev@vger.kernel.org, ast@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
References: <1452007387-626-1-git-send-email-rabin@rab.in>
In-Reply-To: <1452007387-626-1-git-send-email-rabin@rab.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.98.7/21228/Tue Jan  5 10:35:21 2016)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50926
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

On 01/05/2016 04:23 PM, Rabin Vincent wrote:
> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
> instructions since it XORs A with X while all the others replace A with
> some loaded value.  All the BPF JITs fail to clear A if this is used as
> the first instruction in a filter.  This was found using american fuzzy
> lop.
>
> Add a helper to determine if A needs to be cleared given the first
> instruction in a filter, and use this in the JITs.  Except for ARM, the
> rest have only been compile-tested.
>
> Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Excellent catch, thanks a lot! The fix looks good to me and should
go to -net tree.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

If you're interested, feel free to add a small test case for the
SKF_AD_ALU_XOR_X issue to lib/test_bpf.c for -net-next tree. Thanks!
