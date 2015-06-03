Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 09:37:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36106 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007140AbbFCHhpmVnrx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jun 2015 09:37:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t537bjYr011680;
        Wed, 3 Jun 2015 09:37:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t537bimC011679;
        Wed, 3 Jun 2015 09:37:44 +0200
Date:   Wed, 3 Jun 2015 09:37:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: get rid of 'kgdb_early_setup' cruft
Message-ID: <20150603073744.GA9839@linux-mips.org>
References: <3490915.phQRzDMC3E@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3490915.phQRzDMC3E@wasted.cogentembedded.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47821
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

On Mon, Jun 01, 2015 at 12:40:32AM +0300, Sergei Shtylyov wrote:

> Commit 854700115ecf ([MIPS] kgdb: add arch support for the kernel's kgdb core)
> added the 'kgdb_early_setup' flag to avoid  calling trap_init() and init_IRQ()
> the second time, however the code that called these functions earlier,  from
> kgdb_arch_init(), had been already removed by that  time,  so the flag never
> served any useful purpose. Remove the related code along with ugly #ifdef'ery
> at last.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the recent Linus' repo.  Tell me if you want it to be
> rebased against some MIPS repo...

There's been a minor conflict which was trivial to reslve.

Thanks,

  Ralf
