Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 05:06:30 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:41052 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdHUDGYAEa-c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2017 05:06:24 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 849F91212E6AE;
        Sun, 20 Aug 2017 20:06:20 -0700 (PDT)
Date:   Sun, 20 Aug 2017 20:06:19 -0700 (PDT)
Message-Id: <20170820.200619.821714603187353951.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS,bpf: Improvements for MIPS eBPF JIT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20170818234033.5990-1-david.daney@cavium.com>
References: <20170818234033.5990-1-david.daney@cavium.com>
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 20 Aug 2017 20:06:20 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59719
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

From: David Daney <david.daney@cavium.com>
Date: Fri, 18 Aug 2017 16:40:30 -0700

> I suggest that the whole thing go via the BPF/net-next path as there
> are dependencies on code that is not yet merged to Linus' tree.

What kind of dependency?  On networking or MIPS changes?

If the dependency is on MIPS changes, then if I cannot apply this as
it will break the net-next build on MIPS.  You should merge this
via the MIPS tree, where the dependencies are, in that case.

Please clarify what is specifically happening here.

Thanks.
