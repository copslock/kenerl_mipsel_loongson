Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 23:25:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58434 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835271Ab3FMVZ1OBX9M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jun 2013 23:25:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5DL1sHN011220;
        Thu, 13 Jun 2013 23:01:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5DL1pro011219;
        Thu, 13 Jun 2013 23:01:51 +0200
Date:   Thu, 13 Jun 2013 23:01:50 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] MIPS: loongson: fix random early boot hang
Message-ID: <20130613210150.GA11137@linux-mips.org>
References: <1371155364-725-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371155364-725-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36865
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

On Thu, Jun 13, 2013 at 11:29:24PM +0300, Aaro Koskinen wrote:

> Some Loongson boards (e.g. Lemote FuLoong mini-PC) use ISA/southbridge
> device (CS5536 general purpose timer) for the timer interrupt. It starts
> running early and is already enabled during the PCI configuration,
> during which there is a small window in pci_read_base() when the register
> access is temporarily disabled. If the timer interrupts at this point,
> the system will hang. Fix this by adding a fixup that keeps the register
> access always enabled.

Sorry, I had already applied your patch but then accidentally dropped it
from my patch queue.  Will send it upstream for 3.10.

Thanks!

  Ralf
