Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 16:52:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48410 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827823Ab3FZOwhyhQS9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 16:52:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QEqaXb009341;
        Wed, 26 Jun 2013 16:52:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QEqYIY009340;
        Wed, 26 Jun 2013 16:52:34 +0200
Date:   Wed, 26 Jun 2013 16:52:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
Message-ID: <20130626145234.GB7171@linux-mips.org>
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37134
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

On Thu, Jun 20, 2013 at 10:36:30AM -0500, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> This reverts commit 3f4579252aa166641861a64f1c2883365ca126c2. It is
> invalid because the macros CAC_ADDR and UNCAC_ADDR have a kernel
> virtual address as an argument and also returns a kernel virtual
> address. Using and physical address PHYS_OFFSET is blatantly wrong
> for a macro common to multiple platforms.

While the patch itself is looking sane at a glance, I'm wondering if this
is fixing any actual bug or is just the result of a code review?

  Ralf
