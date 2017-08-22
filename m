Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 00:33:36 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:44710 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993916AbdHVWdZdM0sO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 00:33:25 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1dkHja-0001CF-17; Wed, 23 Aug 2017 00:33:18 +0200
Message-ID: <599CB12D.8090301@iogearbox.net>
Date:   Wed, 23 Aug 2017 00:33:17 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>,
        Colin King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "David S . Miller" <davem@davemloft.net>, linux-mips@linux-mips.org
CC:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] MIPS,bpf: fix missing break in switch statement
References: <20170822220349.5648-1-colin.king@canonical.com> <93479b06-c3a2-a08a-fe5c-d8f155efeacc@caviumnetworks.com>
In-Reply-To: <93479b06-c3a2-a08a-fe5c-d8f155efeacc@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23698/Tue Aug 22 22:36:31 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59762
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

On 08/23/2017 12:29 AM, David Daney wrote:
> On 08/22/2017 03:03 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a missing break causing a fall-through and setting
>> ctx.use_bbit_insns to the wrong value. Fix this by adding the
>> missing break.
>>
>> Detected with cppcheck:
>> "Variable 'ctx.use_bbit_insns' is reassigned a value before the old
>> one has been used. 'break;' missing?"
>>
>> Fixes: 8d8d18c3283f ("MIPS,bpf: Fix using smp_processor_id() in preemptible splat.")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Crap!  That slipped through.  Thanks for fixing it.
>
> Tested and ...
>
> Acked-by: David Daney <david.daney@cavium.com>

Colin, can you send this with David's ACK to netdev in Cc
so it lands in patchwork? It's for net-next tree. Thanks!
