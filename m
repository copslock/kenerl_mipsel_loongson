Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 18:47:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47129 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824786Ab3FRQrrXv7Z8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 18:47:47 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5IGliM6025803;
        Tue, 18 Jun 2013 18:47:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5IGliuE025802;
        Tue, 18 Jun 2013 18:47:44 +0200
Date:   Tue, 18 Jun 2013 18:47:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix get_user_page_fast() for mips with cache alias
Message-ID: <20130618164744.GA21210@linux-mips.org>
References: <1371233403-30153-1-git-send-email-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371233403-30153-1-git-send-email-kdasu.kdev@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36978
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

On Fri, Jun 14, 2013 at 02:10:03PM -0400, Kamal Dasu wrote:

> get_user_pages_fast() is missing cache flushes for MIPS platforms
> with cache alias. Filesystem failures observed with DirectIO
> operations due to missing flush_anon_page() that use page coloring
> logic to work with cache aliases. This fix falls through to take
> slow_irqon path that calls get_user_pages() that has required
> logic for platforms where cpu_has_dc_aliases is true.

A bit unsatisfying to always fall back to the slow variant yet I like
the patch because of it's simplicity but I wonder if there's not a
better solution.

  Ralf
