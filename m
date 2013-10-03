Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 22:16:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53182 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6868696Ab3JCUQqyi8bs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Oct 2013 22:16:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r93KGhm1026656;
        Thu, 3 Oct 2013 22:16:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r93KGfpw026655;
        Thu, 3 Oct 2013 22:16:41 +0200
Date:   Thu, 3 Oct 2013 22:16:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Prem Mallappa <prem.mallappa@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: KDUMP: Fix to access non-sectioned memory
Message-ID: <20131003201641.GC15556@linux-mips.org>
References: <1380786415-24956-1-git-send-email-pmallappa@caviumnetworks.com>
 <1380786415-24956-2-git-send-email-pmallappa@caviumnetworks.com>
 <20131003182915.GA15556@linux-mips.org>
 <524DBC02.6020009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524DBC02.6020009@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38190
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

On Thu, Oct 03, 2013 at 11:48:34AM -0700, David Daney wrote:

> I wonder, how does /dev/mem handle it?  We should probably do what
> the mem driver does for this.

/dev/mem is converting physical address to virtual addresses using
xlate_dev_mem_ptr() which is defined as:

#define xlate_dev_mem_ptr(p)	__va(p)

which obviously is suffering from similar problems as Prem's suggested
patch.

Fortunately /dev/(k)mem have pretty much gotten out of fashion ;-)

The x86 implementation of xlate_dev_mem_ptr() is based on ioremap_cache()
which may be x86-specific - but very handy in situations like this and
there might also be devices which want to be mapped cached.

I'm considering to implement it since ages.  I just don't want a whole
flood of new cache modes like ioremap_uncached_accelerated() or maybe
ioremap_writeback_on_sunday_afternoons_only()  ;-)

  Ralf
