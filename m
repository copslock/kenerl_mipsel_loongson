Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 18:23:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48820 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827823Ab3FZQXF6OLc3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 18:23:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QGN4q2013847;
        Wed, 26 Jun 2013 18:23:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QGN2CA013846;
        Wed, 26 Jun 2013 18:23:02 +0200
Date:   Wed, 26 Jun 2013 18:23:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
Message-ID: <20130626162302.GE7171@linux-mips.org>
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com>
 <20130626145234.GB7171@linux-mips.org>
 <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37141
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

On Wed, Jun 26, 2013 at 03:43:35PM +0000, Leonid Yegoshin wrote:

> This is a precursor for EVA specs implementation on Aptiv cores.
> 
> EVA has different virtual address sets for kernel and user space and it can use memory on different physical address location. For exam, on Malta it can use a natural 0x80000000, one our customer put memory into 0x40000000 etc.

Hmm...  Any significant reduction below 2GB sounds like opening a can of
worms with address space layout assumption in some application code.

I guess they were desperately looking to increase kernel memory, highmem
didn't fit the bill nor going 64 bit so this was the solution?

  Ralf
