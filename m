Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 14:11:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44568 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992178AbcIVMLt0As7C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Sep 2016 14:11:49 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8MCBgVK014024;
        Thu, 22 Sep 2016 14:11:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8MCBbFZ014023;
        Thu, 22 Sep 2016 14:11:37 +0200
Date:   Thu, 22 Sep 2016 14:11:37 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-remoteproc@vger.kernel.org,
        lisa.parratt@imgtec.com, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Huacai Chen <chenhc@lemote.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/6] MIPS: tlb-r4k: If there are wired entries, don't
 use TLBINVF
Message-ID: <20160922121136.GA12981@linux-mips.org>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
 <1474361249-31064-3-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474361249-31064-3-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55231
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

On Tue, Sep 20, 2016 at 09:47:25AM +0100, Matt Redfearn wrote:

> When adding a wired entry to the TLB via add_wired_entry, the tlb is
> flushed with local_flush_tlb_all, which on CPUs with TLBINV results in
> the new wired entry being flushed again.
> 
> Behavior of the TLBINV instruction applies to all applicable TLB entries
> and is unaffected by the setting of the Wired register. Therefore if
> the TLB has any wired entries, fall back to iterating over the entries
> rather than blasting them all using TLBINVF.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

Queued for 4.9..

  Ralf
