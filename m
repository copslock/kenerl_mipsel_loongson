Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 18:14:49 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:33528 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994811AbdFPQOlwbbWV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 18:14:41 +0200
Received: from localhost (unknown [38.140.131.194])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E17E613C154A3;
        Fri, 16 Jun 2017 08:32:53 -0700 (PDT)
Date:   Fri, 16 Jun 2017 12:14:34 -0400 (EDT)
Message-Id: <20170616.121434.859810061597099237.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     david.daney@cavium.com, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 2/3] samples/bpf: Add define __EMITTING_BPF__ when
 building BPF
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5943B1C6.7040809@iogearbox.net>
References: <20170615223543.22867-1-david.daney@cavium.com>
        <20170615223543.22867-3-david.daney@cavium.com>
        <5943B1C6.7040809@iogearbox.net>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Jun 2017 08:32:54 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58527
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
Date: Fri, 16 Jun 2017 12:24:06 +0200

> On 06/16/2017 12:35 AM, David Daney wrote:
>> ... this allows gating of inline assembly code that causes llvm to
>> fail when emitting BPF.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
> 
> I don't have a better idea at the moment, perhaps there could be
> a clang rewrite plugin that would ignore all inline assembly code
> since this is never used from BPF progs. Hmm. Really ugly that
> we have to add this __EMITTING_BPF__ into arch asm files, but I
> don't have a better idea for an immediate workaround right now ...
> I would really prefer if we could avoid just for the sake of the
> kernel samples going down the road of adding a
> !defined(__EMITTING_BPF__)
> into a uapi asm header for mips, though. Is this coming from
> networking sample code or rather tracing?

The problem is that we include the arch include/asm files at all.

When we build bpf stuff, we should have a set of asm/ files
specifically for builds targetting BPF.

Let's just fix this right and stop putting all of these hacks in.

Thank you.
