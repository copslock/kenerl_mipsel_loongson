Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 23:03:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56662 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27039217AbcE2VDnsWFmS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 May 2016 23:03:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4TL3g2L025633;
        Sun, 29 May 2016 23:03:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4TL3ffU025632;
        Sun, 29 May 2016 23:03:42 +0200
Date:   Sun, 29 May 2016 23:03:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "# 4 . 2 . x-" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: lib: Mark intrinsics notrace
Message-ID: <20160529210340.GA25587@linux-mips.org>
References: <20160525100635.22541-1-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160525100635.22541-1-harvey.hunt@imgtec.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53699
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

On Wed, May 25, 2016 at 11:06:35AM +0100, Harvey Hunt wrote:

> On certain MIPS32 devices, the ftrace tracer "function_graph" uses
> __lshrdi3() during the capturing of trace data. ftrace then attempts to
> trace __lshrdi3() which leads to infinite recursion and a stack overflow.
> Fix this by marking __lshrdi3() as notrace. Mark the other compiler
> intrinsics as notrace in case the compiler decides to use them in the
> ftrace path.

Makes perfect sense - but I'm wondering how you triggered it.  Was this
a build with the GCC option -Os that is CONFIG_CC_OPTIMIZE_FOR_SIZE?
Usually people build with CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE that is -O2
which results in intrinsics being inlined.

  Ralf
