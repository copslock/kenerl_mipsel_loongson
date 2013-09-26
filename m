Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 16:16:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53941 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822345Ab3IZOQBEt3Z9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 16:16:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8QEFxo5024728;
        Thu, 26 Sep 2013 16:15:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8QEFwjG024727;
        Thu, 26 Sep 2013 16:15:58 +0200
Date:   Thu, 26 Sep 2013 16:15:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Jayachandran C." <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: mm: Move some checks out of 'for' loop in DMA
 operations
Message-ID: <20130926141558.GK32055@linux-mips.org>
References: <1380114065-9761-1-git-send-email-jchandra@broadcom.com>
 <20130926103651.GL24359@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130926103651.GL24359@jayachandranc.netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37994
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

On Thu, Sep 26, 2013 at 04:06:52PM +0530, Jayachandran C. wrote:

> The patch was missing the required Signed-off-by, added below.

Thanks, the patch is now in the tree.

(Further sifting through patches is currently being hampered by X crashing
ever faster so I'm back to text console for now ...)

  Ralf
