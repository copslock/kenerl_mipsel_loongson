Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 23:53:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39681 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026747AbbEOVxojwHCl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 23:53:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FLrSAl011098;
        Fri, 15 May 2015 23:53:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FLrLJ6011097;
        Fri, 15 May 2015 23:53:21 +0200
Date:   Fri, 15 May 2015 23:53:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     aleksey.makarov@auriga.com, james.hogan@imgtec.com,
        paul.burton@imgtec.com, david.daney@cavium.com,
        peterz@infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, davidlohr@hp.com,
        kirill@shutemov.name, akpm@linux-foundation.org, mingo@kernel.org
Subject: Re: [PATCH v2] MIPS64: Support of at least 48 bits of SEGBITS
Message-ID: <20150515215320.GI2322@linux-mips.org>
References: <20150515013351.7450.12130.stgit@ubuntu-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150515013351.7450.12130.stgit@ubuntu-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47424
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

On Thu, May 14, 2015 at 06:34:43PM -0700, Leonid Yegoshin wrote:

The order 1 allocation for the PGD are concerning me a little.  On a
system under even moderate memory pressure that might become a bit of
a reliability or performance issue.

With 4kB pages we already need order 1 or even 2 allocations for the
allocation of the stack and some folks have reported that to be an issue
so we may have to start using the PUD for very large VA spaces.

  Ralf
