Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 10:23:22 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:34618 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009691AbaJDIXUJRYLM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 10:23:20 +0200
Received: from 178-85-85-44.dynamic.upc.nl ([178.85.85.44] helo=worktop)
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1XaKcO-000494-DW; Sat, 04 Oct 2014 08:23:08 +0000
Received: by worktop (Postfix, from userid 1000)
        id 633626E0B71; Sat,  4 Oct 2014 10:23:07 +0200 (CEST)
Date:   Sat, 4 Oct 2014 10:23:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org, Zubair.Kakakhel@imgtec.com,
        david.daney@cavium.com, paul.gortmaker@windriver.com,
        davidlohr@hp.com, macro@linux-mips.org, chenhc@lemote.com,
        zajec5@gmail.com, james.hogan@imgtec.com, keescook@chromium.org,
        alex@alex-smith.me.uk, tglx@linutronix.de, blogic@openwrt.org,
        jchandra@broadcom.com, paul.burton@imgtec.com,
        qais.yousef@imgtec.com, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, markos.chandras@imgtec.com,
        manuel.lauss@gmail.com, akpm@linux-foundation.org,
        lars.persson@axis.com
Subject: Re: [PATCH 0/3] MIPS executable stack protection
Message-ID: <20141004082307.GS10583@worktop.programming.kicks-ass.net>
References: <20141004030438.28569.85536.stgit@linux-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141004030438.28569.85536.stgit@linux-yegoshin>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Fri, Oct 03, 2014 at 08:17:14PM -0700, Leonid Yegoshin wrote:
> The following series implements an executable stack protection in MIPS.
> 
> It sets up a per-thread 'VDSO' page and appropriate TLB support.

So traditionally we've always avoided per-thread pages like that. What
makes it worth it on MIPS?
