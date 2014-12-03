Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 14:42:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49923 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008015AbaLCNmcS6SQl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Dec 2014 14:42:32 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sB3DgUPI016992;
        Wed, 3 Dec 2014 14:42:30 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sB3DgQMY016991;
        Wed, 3 Dec 2014 14:42:26 +0100
Date:   Wed, 3 Dec 2014 14:42:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars Persson <lars.persson@axis.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "paul.burton@imgtec.com" <paul.burton@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "markos.chandras@imgtec.com" <markos.chandras@imgtec.com>
Subject: Re: [PATCH] Revert "MIPS: Remove race window in page fault handling"
Message-ID: <20141203134226.GC16063@linux-mips.org>
References: <20141203032542.15388.17340.stgit@linux-yegoshin>
 <1417599104.10996.16.camel@lnxlarper.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1417599104.10996.16.camel@lnxlarper.se.axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44556
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

Lars,

normally set_pte_at() is invoked in a 

  cache_flush_*()
  set_pte_at()
  tlb_flush_*()

sequence.  So I'm wondering if you're trying to fix something in set_pte_at
that actually ought to be fixed in the cache_flush_*() function.

I'm wondering, have you identified which cache flush function in particular
was used in the sequence in your particular bug's case?

  Ralf
