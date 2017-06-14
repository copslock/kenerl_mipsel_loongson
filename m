Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 21:04:11 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:54236 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994765AbdFNTEEuPie5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2017 21:04:04 +0200
Received: from localhost (unknown [38.140.131.194])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7848B13429CA8;
        Wed, 14 Jun 2017 11:22:17 -0700 (PDT)
Date:   Wed, 14 Jun 2017 15:03:57 -0400 (EDT)
Message-Id: <20170614.150357.632035401955794047.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     daniel@iogearbox.net, david.daney@cavium.com, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 0/4] bpf: Changes needed (or desired) for MIPS support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <e17ffbca-f11f-5617-3188-a7eb82b03ed3@caviumnetworks.com>
References: <20170613234938.4823-1-david.daney@cavium.com>
        <594081CA.3060801@iogearbox.net>
        <e17ffbca-f11f-5617-3188-a7eb82b03ed3@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 14 Jun 2017 11:22:18 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58455
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

From: David Daney <ddaney@caviumnetworks.com>
Date: Wed, 14 Jun 2017 08:54:03 -0700

> On 06/13/2017 05:22 PM, Daniel Borkmann wrote:
>> On 06/14/2017 01:49 AM, David Daney wrote:
>>> This is a grab bag of changes to the bpf testing infrastructure I
>>> developed working on MIPS eBPF JIT support.  The change to
>>> bpf_jit_disasm is probably universally beneficial, the others are more
>>> MIPS specific.
>> I think these could go independently through net-next tree?
> 
> Yes, if davem is happy with them, I think that makes sense that he
> take them via net-next.

Series applied to net-next, thanks!
