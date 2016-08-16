Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 12:12:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45662 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992938AbcHPKMAgbu-S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 12:12:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u7GABwDx031305;
        Tue, 16 Aug 2016 12:11:58 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u7GABvpg031303;
        Tue, 16 Aug 2016 12:11:57 +0200
Date:   Tue, 16 Aug 2016 12:11:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alex Belits <alex.belits@cavium.com>
Cc:     David Saney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] mips: 48bit: 48-bit virtual address support in 3.10
Message-ID: <20160816101157.GC3894@linux-mips.org>
References: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54565
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

On Mon, Aug 15, 2016 at 11:22:53PM -0700, Alex Belits wrote:

> This is a set of patches to add 48-bit virtual address space support on 
> MIPS to the kernel 3.10. It includes a port of existing patch for page 
> size 16k and 64k, plus support for 4-level page table for the rest of 
> the supported page sizes.

Kudos for posting a backport of a feature to an old kernel, it may still
be useful to somebody.  But as I'm not applying new features to old
kernels, I'm going to drop this patchset from patchwork.

  Ralf
