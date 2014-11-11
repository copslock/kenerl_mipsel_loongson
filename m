Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 11:05:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56469 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013354AbaKKKFXJswdV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 11:05:23 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABA5L4o028253;
        Tue, 11 Nov 2014 11:05:21 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABA5Jet028252;
        Tue, 11 Nov 2014 11:05:19 +0100
Date:   Tue, 11 Nov 2014 11:05:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: Re: [PATCH V2 04/12] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
Message-ID: <20141111100518.GC27259@linux-mips.org>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
 <1415081610-25639-5-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415081610-25639-5-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43981
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

On Tue, Nov 04, 2014 at 02:13:25PM +0800, Huacai Chen wrote:

> Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
> feature named cpu_has_coherent_cache and use it to modify MIPS's cache
> flushing functions.

You've modified all the local_* functions which means the r4k_on_each_cpu()
in r4k___flush_cache_all(), r4k_flush_cache_sigtramp() otc. will still be
executed.

Your change is correct - but I think it can be optimized if we can assume
that all CPUs have a coherent cache by moving the check into the caller.

smp_call_function() can be fairly expensive in particular on big systems!

  Ralf
