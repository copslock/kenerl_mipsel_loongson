Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 20:24:30 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:57550 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995095AbdHDSYWJ0ebm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 20:24:22 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6C49812125303;
        Fri,  4 Aug 2017 11:24:15 -0700 (PDT)
Date:   Fri, 04 Aug 2017 11:24:15 -0700 (PDT)
Message-Id: <20170804.112415.2219726575381919877.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     david.daney@cavium.com, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James.Cowgill@imgtec.com,
        markos.chandras@imgtec.com
Subject: Re: [PATCH] MIPS: Add missing file for eBPF JIT.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5984710F.4010301@iogearbox.net>
References: <20170804001012.24901-1-david.daney@cavium.com>
        <5984710F.4010301@iogearbox.net>
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Aug 2017 11:24:15 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 04 Aug 2017 15:05:19 +0200

> On 08/04/2017 02:10 AM, David Daney wrote:
>> Inexplicably, commit f381bf6d82f0 ("MIPS: Add support for eBPF JIT.")
>> lost a file somewhere on its path to Linus' tree.  Add back the
>> missing ebpf_jit.c so that we can build with CONFIG_BPF_JIT selected.
>>
>> This version of ebpf_jit.c is identical to the original except for two
>> minor change need to resolve conflicts with changes merged from the
>> BPF branch:
>>
>> A) Set prog->jited_len = image_size;
>> B) Use BPF_TAIL_CALL instead of BPF_CALL | BPF_X
>>
>> Fixes: f381bf6d82f0 ("MIPS: Add support for eBPF JIT.")
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>
>> It might be best to merge this along the path of BPF fixes rather than
>> MIPS, as the MIPS maintainer (Ralf) seems to be inactive recently.
> 
> Looks like situation is that multiple people including myself tried
> to contact Ralf due to 'half/mis-applied' MIPS BPF JIT in [1,2] that
> sits currently in Linus tree, but never got a reply back since mid
> June.
> 
> Given the work was accepted long ago but incorrectly merged, would be
> great if this could still be fixed up with this patch. Given Ralf
> seems
> unfortunately unresponsive, is there a chance, if people are fine with
> it, that we could try route this fix e.g. via -net instead before a
> final v4.13?
> 
> Anyway, the generic pieces interacting with core BPF look good to me:
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Ok, I've applied this to the net GIT tree.

Thanks.
