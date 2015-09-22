Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:04:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42119 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008792AbbIVSEbLF-ZU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Sep 2015 20:04:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8MI4SHo019128;
        Tue, 22 Sep 2015 20:04:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8MI4R78019127;
        Tue, 22 Sep 2015 20:04:27 +0200
Date:   Tue, 22 Sep 2015 20:04:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Chris Dearman <chris.dearman@imgtec.com>
Subject: Re: [PATCH] MIPS: allow 24Hz timer frequency
Message-ID: <20150922180427.GC16339@linux-mips.org>
References: <1442942199-32523-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442942199-32523-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49300
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

On Tue, Sep 22, 2015 at 10:16:39AM -0700, Paul Burton wrote:

> A boundary exists beyond which the timer frequency becomes high enough
> that timer interrupts saturate the system and either cause it to slow to
> a crawl or stop functioning entirely. Where that boundary lies depends
> upon a number of factors such as the overhead of each interrupt and the
> overall speed of the CPU, but correlates strongly with the clock
> frequency at which the CPU runs. When running on emulators during
> bringup or debug of a CPU that clock frequency is very low, which
> results in the boundary at which the timer frequency becomes
> unsustainable being very low. The current minimum of 48Hz pushes against
> boundary in certain situations in current systems. Allow the kernel to
> be configured for a 24Hz timer frequency in order to avoid problems on
> such slow running systems.

The current minimum of 48Hz in the MIPS kconfig files predates the
rewrites to use clocksource/clockevent device in 2.6.27 or so.  The
value of 48Hz is the lowest value at which the old time code was still
working properly.  Afair the change was submitted by Kevin Kissel or
Chris Dearman to improve performance on with emulated CPUs which by that
time were running at like 500kHz (I think it was an IKOS) clock rate.
Presumably below 48Hz the math in the kernel's time code was falling
apart but anyway, afaics the value was derived experimentally.

  Ralf
