Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 12:37:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51214 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013596AbaKMLg7r35zj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 12:36:59 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sADBax52019052;
        Thu, 13 Nov 2014 12:36:59 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sADBawXS019051;
        Thu, 13 Nov 2014 12:36:58 +0100
Date:   Thu, 13 Nov 2014 12:36:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 04/11] MIPS: Removal of execute bit in page tables for
 HEAP/BSS.
Message-ID: <20141113113658.GD13753@linux-mips.org>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
 <1415858743-24492-5-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415858743-24492-5-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44113
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

On Thu, Nov 13, 2014 at 12:05:36AM -0600, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> Patch removes eXecute bit in the page tables for HEAP/BSS. It
> boosts performance because page marked X is flushed each time
> after COW/swap from cache even for cache coherent systems in
> Harvard architectures (!cpu_has_ic_fills_f_dc). This patch also
> sets eXecute Inhibit (XI) protection of HEAP/BSS on CPUs which
> support it, like proAptiv cores.

While I generally like the idea to limited execute permission to just
what really needs it all approaches to do so have ran into compatibility
issue.  This patch only modifies the brk space which is a bit of a
special case for which I don't know the impact on existing software.

  Ralf
