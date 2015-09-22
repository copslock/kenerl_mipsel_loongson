Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 17:43:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38358 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008688AbbIVPnznvOi0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Sep 2015 17:43:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8MFhqvD016440;
        Tue, 22 Sep 2015 17:43:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8MFhphE016439;
        Tue, 22 Sep 2015 17:43:51 +0200
Date:   Tue, 22 Sep 2015 17:43:51 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Chris Dearman <chris.dearman@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 36/38] MIPS: remove invalid check
Message-ID: <20150922154350.GA16339@linux-mips.org>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
 <1442842450-29769-37-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442842450-29769-37-git-send-email-a.hajda@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49272
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

On Mon, Sep 21, 2015 at 03:34:08PM +0200, Andrzej Hajda wrote:

> Unsigned values cannot be lesser than zero.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Chris Dearman's original commit 9318c51acd9689505850152cc98277a6d6f2d752
([MIPS] MIPS32/MIPS64 secondary cache management) introduced these less
than zero checks in 2.6.18.  They're fortunately entirely harmless.

Patch queued for 4.4.  Thanks!

  Ralf
