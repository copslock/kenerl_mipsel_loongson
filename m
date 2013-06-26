Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 19:50:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49208 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823098Ab3FZRuS3RO3N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 19:50:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QHoGYd019518;
        Wed, 26 Jun 2013 19:50:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QHoFBx019517;
        Wed, 26 Jun 2013 19:50:15 +0200
Date:   Wed, 26 Jun 2013 19:50:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
Message-ID: <20130626175015.GH7171@linux-mips.org>
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com>
 <20130626145234.GB7171@linux-mips.org>
 <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com>
 <20130626162302.GE7171@linux-mips.org>
 <nh7ue18fnbn1tbs2wsphlis9.1372265400519@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nh7ue18fnbn1tbs2wsphlis9.1372265400519@email.android.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37146
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

On Wed, Jun 26, 2013 at 04:50:03PM +0000, Leonid Yegoshin wrote:

> EVA has actually INCREASE in user address space - I right now run system with 2GB phys memory and 3GB of user virtual memory address space. Work in progress is to verify that GLIBC accepts addresses above 2GB.

I took the 0x40000000 for a KSEG0-equivalent because you previously
mentioned the value of 0x80000000.

> Yes, it is all about increasing phys and user memory and avoiding 64bits. Many solutions dont justify 64bit chip (chip space increase, performance degradation and increase in DMA addresses for devices).

Fair enough - but in the end the increasing size of metadata and pagetables
which has to reside in lowmem will become the next bottleneck and highmem
I/O performance has never been great, is on most kernel developers shit list
and performance optimizations for highmem are getting killed whenever they
are getting into the way.

So I'd say EVA gives you something like 1.5GB of memory at most with good
performance and a 2GB userspace and something like 0.5GB, maybe 0.75GB
with a 3GB userspace.  Beyond that you need highmem and that's where things,
especially kernel programming get more complicated and slower.

  Ralf
