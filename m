Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 16:23:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47328 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009658AbbJFOXOL-fya (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Oct 2015 16:23:14 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t96ENDC4029181;
        Tue, 6 Oct 2015 16:23:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t96ENCBg029180;
        Tue, 6 Oct 2015 16:23:12 +0200
Date:   Tue, 6 Oct 2015 16:23:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] mips: bigsur_defconfig: convert to use libata PATA
 drivers
Message-ID: <20151006142312.GA28984@linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49452
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

On Mon, Sep 14, 2015 at 05:51:42PM +0200, Bartlomiej Zolnierkiewicz wrote:

> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts bigsur_defconfig to use libata PATA
> drivers (tc86c001 IDE host driver has no corresponding libata
> driver yet so it is not converted).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Build tested only.
> If you have affected hardware please test.  Thank you.

Nobody replied so I applied all 17 patches.

I've only too often updated the config I'm actually using to use libata
so thanks to doing this for all configs!

  Ralf
