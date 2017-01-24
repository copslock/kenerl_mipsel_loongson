Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 19:16:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40072 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993938AbdAXSQZT2eJw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jan 2017 19:16:25 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0OIGOE7029567;
        Tue, 24 Jan 2017 19:16:24 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0OIGOXH029566;
        Tue, 24 Jan 2017 19:16:24 +0100
Date:   Tue, 24 Jan 2017 19:16:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, john@phrozen.org
Subject: Re: [PATCH] MIPS: lantiq: lock DMA register accesses for SMP
Message-ID: <20170124181624.GA29473@linux-mips.org>
References: <1483096707-21711-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483096707-21711-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Dec 30, 2016 at 12:18:27PM +0100, Hauke Mehrtens wrote:

> The DMA controller channel and port configuration is changed by
> selecting the port or channel in one register and then update the
> configuration in other registers. This has to be done in an atomic
> operation. Previously only the local interrupts were deactivated which
> works for single CPU systems. If the system supports SMP a better
> locking is needed, use spinlocks instead.
> On more recent SoCs (at least xrx200 and later) there are two memory
> regions to change the configuration, there we could use one area for
> each CPU and do not have to synchronize between the CPUs and more.

You should always use proper locking, not interrupt fiddlery for proper
serialization.  On UP kernels the spinlocks will expand to call just
the local_irq_* so no overhead.

Applied,

  Ralf
