Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 02:21:52 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:49148 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994071AbdFNAVpU1lhW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2017 02:21:45 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1dKw40-0002Gu-Nh; Wed, 14 Jun 2017 02:21:36 +0200
Message-ID: <59408190.6030206@iogearbox.net>
Date:   Wed, 14 Jun 2017 02:21:36 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 4/4] samples/bpf: Fix tracex5 to work with MIPS syscalls.
References: <20170613234938.4823-1-david.daney@cavium.com> <20170613234938.4823-5-david.daney@cavium.com>
In-Reply-To: <20170613234938.4823-5-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23471/Tue Jun 13 22:11:53 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58441
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
> There are two problems:
>
> 1) In MIPS the __NR_* macros expand to an expression, this causes the
>     sections of the object file to be named like:
>
>    .
>    .
>    .
>    [ 5] kprobe/(5000 + 1) PROGBITS        0000000000000000 000160 ...
>    [ 6] kprobe/(5000 + 0) PROGBITS        0000000000000000 000258 ...
>    [ 7] kprobe/(5000 + 9) PROGBITS        0000000000000000 000348 ...
>    .
>    .
>    .
>
> The fix here is to use the "asm_offsets" trick to evaluate the macros
> in the C compiler and generate a header file with a usable form of the
> macros.
>
> 2) MIPS syscall numbers start at 5000, so we need a bigger map to hold
> the sub-programs.
>
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
