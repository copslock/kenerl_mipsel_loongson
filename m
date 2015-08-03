Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 18:18:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36176 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012135AbbHCQSy60Qd4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 18:18:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t73GIoOu009154;
        Mon, 3 Aug 2015 18:18:50 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t73GIjut009153;
        Mon, 3 Aug 2015 18:18:45 +0200
Date:   Mon, 3 Aug 2015 18:18:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Rusty Russell <rusty@rustcorp.com.au>,
        Joshua Kinard <kumba@gentoo.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>
Subject: Re: [PATCH] MIPS: c-r4k: remove cpu_foreign_map
Message-ID: <20150803161845.GG2843@linux-mips.org>
References: <1438617288-25261-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438617288-25261-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48551
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

On Mon, Aug 03, 2015 at 08:54:47AM -0700, Paul Burton wrote:

> Commit cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores") did
> 2 things:
> 
>   - Introduced cpu_foreign_map to call cache maintenance functions on
>     only a single CPU within each core in the system.
> 
>   - Stopped calling cache maintenance functions on non-local CPUs for
>     systems which include a MIPS Coherence Manager.
> 
> Thus the introduction of cpu_foreign_map has no effect on any systems
> with a CM, since the IPIs will be avoided entirely. Thus it can only
> possibly affect other systems which have multiple logical CPUs per core,
> which appears to only be netlogic. I'm pretty certain this wasn't the
> intent, am unsure whether avoiding such cache maintenance calls is
> correct for netlogic systems and believe the overhead of calculating
> cpu_foreign_map is thus unnecessary & this code is almost certainly
> untested.
> 
> This mostly reverts commit cccf34e9411c ("MIPS: c-r4k: Fix cache
> flushing for MT cores"), leaving only the change for systems with a CM.

BMIPS is another "hyperthreading-like" core.  Maybe Kevin or Florian
can comment if this patch is good for them?

  Ralf
