Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 15:20:33 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:58827 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008018AbaLCOUbwBcFm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Dec 2014 15:20:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 3C3161808D;
        Wed,  3 Dec 2014 15:20:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id kS-+n2emvUjK; Wed,  3 Dec 2014 15:20:17 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 561E318097;
        Wed,  3 Dec 2014 15:20:17 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 3C5BDE1C;
        Wed,  3 Dec 2014 15:20:17 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 2B60AA60;
        Wed,  3 Dec 2014 15:20:17 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id 274873E236;
        Wed,  3 Dec 2014 15:20:17 +0100 (CET)
Received: from [10.88.41.1] (10.88.41.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Wed, 3 Dec 2014 15:20:16 +0100
Message-ID: <1417616416.10198.12.camel@lnxlarper.se.axis.com>
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
Date:   Wed, 3 Dec 2014 15:20:16 +0100
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
X-archive-position: 44558
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

Ralf

I remember now that we have applied to our tree the proposed patch
titled "MIPS HIGHMEM fixes for cache aliasing and non-DMA I/O".

This patch changes the semantics of flush_dcache_page() by using
page_mapped() instead of mapping_mapped() to decide if the flush should
be lazy. Is it this change that makes us get lazy flushes for code
mappings and therefore exposing the problem ? The ARM port which has
made a similar change to set_pte_at() also uses page_mapped() to decide
if lazy flushing is possible.

If this is true, then upstream might not need my patch. 

- Lars



On ons, 2014-12-03 at 14:42 +0100, Ralf Baechle wrote:
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
