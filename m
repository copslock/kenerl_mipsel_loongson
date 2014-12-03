Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 15:03:32 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:55799 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008018AbaLCODaF7RGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Dec 2014 15:03:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 973B32E226;
        Wed,  3 Dec 2014 15:03:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id EqJZAv-Vy1YJ; Wed,  3 Dec 2014 15:03:19 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id ACD1A2E352;
        Wed,  3 Dec 2014 15:03:18 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 925CEE1C;
        Wed,  3 Dec 2014 15:03:18 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 8562AA24;
        Wed,  3 Dec 2014 15:03:18 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 8113F3E23E;
        Wed,  3 Dec 2014 15:03:18 +0100 (CET)
Received: from [10.88.41.1] (10.88.41.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Wed, 3 Dec 2014 15:03:18 +0100
Message-ID: <1417615394.10198.3.camel@lnxlarper.se.axis.com>
Subject: Re: [PATCH] Revert "MIPS: Remove race window in page fault handling"
From:   Lars Persson <lars.persson@axis.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
Date:   Wed, 3 Dec 2014 15:03:14 +0100
In-Reply-To: <20141203134226.GC16063@linux-mips.org>
References: <20141203032542.15388.17340.stgit@linux-yegoshin>
         <1417599104.10996.16.camel@lnxlarper.se.axis.com>
         <20141203134226.GC16063@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

It is the flush_dcache_page() that was called from the file-system
reading the page contents into memory.

- Lars

On Wed, 2014-12-03 at 14:42 +0100, Ralf Baechle wrote:
> Lars,
> 
> normally set_pte_at() is invoked in a 
> 
>   cache_flush_*()
>   set_pte_at()
>   tlb_flush_*()
> 
> sequence.  So I'm wondering if you're trying to fix something in set_pte_at
> that actually ought to be fixed in the cache_flush_*() function.
> 
> I'm wondering, have you identified which cache flush function in particular
> was used in the sequence in your particular bug's case?
> 
>   Ralf
