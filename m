Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 10:24:48 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:50012 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990644AbdHUIYiVKVCZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2017 10:24:38 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1dji0X-0001T3-JJ; Mon, 21 Aug 2017 10:24:25 +0200
Message-ID: <599A98B7.6070909@iogearbox.net>
Date:   Mon, 21 Aug 2017 10:24:23 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>, david.daney@cavium.com
CC:     ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS,bpf: Improvements for MIPS eBPF JIT
References: <20170818234033.5990-1-david.daney@cavium.com> <20170820.200619.821714603187353951.davem@davemloft.net>
In-Reply-To: <20170820.200619.821714603187353951.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23690/Mon Aug 21 06:39:02 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59720
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

On 08/21/2017 05:06 AM, David Miller wrote:
> From: David Daney <david.daney@cavium.com>
> Date: Fri, 18 Aug 2017 16:40:30 -0700
>
>> I suggest that the whole thing go via the BPF/net-next path as there
>> are dependencies on code that is not yet merged to Linus' tree.
>
> What kind of dependency?  On networking or MIPS changes?

On networking, David implemented the JLT, JLE, JSLT and JSLE
ops for the JIT in the patch set. Back then the MIPS JIT wasn't
in net-next tree, thus this is basically just a follow-up, so
that we have all covered with JIT support for net-next.

Thanks,
Daniel
