Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 17:38:31 +0100 (CET)
Received: from www62.your-server.de ([213.133.104.62]:46097 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006757AbcAEQi3lWbha (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 17:38:29 +0100
Received: from [178.194.100.72] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.80.1)
        (envelope-from <daniel@iogearbox.net>)
        id 1aGUcP-00076t-5e; Tue, 05 Jan 2016 17:37:57 +0100
Message-ID: <568BF162.7030008@iogearbox.net>
Date:   Tue, 05 Jan 2016 17:37:54 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Rabin Vincent <rabin@rab.in>, Eric Dumazet <eric.dumazet@gmail.com>
CC:     davem@davemloft.net, netdev@vger.kernel.org, ast@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
References: <1452007387-626-1-git-send-email-rabin@rab.in> <1452009645.8255.96.camel@edumazet-glaptop2.roam.corp.google.com> <20160105160345.GA3951@debian>
In-Reply-To: <20160105160345.GA3951@debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.98.7/21228/Tue Jan  5 10:35:21 2016)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50927
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

On 01/05/2016 05:03 PM, Rabin Vincent wrote:
> On Tue, Jan 05, 2016 at 08:00:45AM -0800, Eric Dumazet wrote:
>> On Tue, 2016-01-05 at 16:23 +0100, Rabin Vincent wrote:
>>> The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
>>> instructions since it XORs A with X while all the others replace A with
>>> some loaded value.  All the BPF JITs fail to clear A if this is used as
>>> the first instruction in a filter.
>>
>> Is x86_64 part of this 'All' subset ? ;)
>
> No, because it's an eBPF JIT.

Correct, filter conversion to eBPF clears it already.
