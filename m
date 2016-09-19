Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 16:21:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32892 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992250AbcISOU4EOytO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Sep 2016 16:20:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8JEKsgO016156;
        Mon, 19 Sep 2016 16:20:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8JEKrFf016155;
        Mon, 19 Sep 2016 16:20:53 +0200
Date:   Mon, 19 Sep 2016 16:20:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] mips/pci: Reduce stack frame usage
Message-ID: <20160919142053.GB14137@linux-mips.org>
References: <1473780107-4375-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473780107-4375-1-git-send-email-keith.busch@intel.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55169
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

On Tue, Sep 13, 2016 at 09:21:47AM -0600, Keith Busch wrote:

> This patch removes creating a fake pci device in MIPS early config
> access and instead just uses the pci bus to get the same functionality.
> The struct pci_dev is too large to allocate on the stack, and was relying
> on compiler optimizations to remove its usage.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> 
> While I don't have any hardware to test this, the change should be
> exactly the same as before, taking the direct route to the config read
> instead of letting the compiler optimize this.
> 
> This patch is preparing to add surprise removed device handling to the
> pci_read_config_*, which makes the compiler optimization that currently
> removes the excessive stack usage impossible.

Looks ok so I've applied it.  Atsushi?

  Ralf
