Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 22:48:10 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:45619 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822956AbaCDVsHj2CkN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 22:48:07 +0100
Received: from localhost (nat-pool-rdu-t.redhat.com [66.187.233.202])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BA61E5847BF;
        Tue,  4 Mar 2014 13:48:01 -0800 (PST)
Date:   Tue, 04 Mar 2014 16:47:59 -0500 (EST)
Message-Id: <20140304.164759.2230363367739786819.davem@davemloft.net>
To:     bhelgaas@google.com
Cc:     peterz@infradead.org, mingo@redhat.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] sched: Remove unused mc_capable() and smt_capable()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
        <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.7 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Mar 2014 13:48:03 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39411
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

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Mar 2014 14:07:37 -0700

> Remove mc_capable() and smt_capable().  Neither is used.
> 
> Both were added by 5c45bf279d37 ("sched: mc/smt power savings sched
> policy").  Uses of both were removed by 8e7fbcbc22c1 ("sched: Remove stale
> power aware scheduling remnants and dysfunctional knobs").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
