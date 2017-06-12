Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 10:27:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34636 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990522AbdFLI1o2nVAL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Jun 2017 10:27:44 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5C8RgXM006558;
        Mon, 12 Jun 2017 10:27:43 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5C8Rg3f006557;
        Mon, 12 Jun 2017 10:27:42 +0200
Date:   Mon, 12 Jun 2017 10:27:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 00/11] MIPS: cmpxchg(), xchg() fixes & queued locks
Message-ID: <20170612082742.GA5642@linux-mips.org>
References: <20170610002644.8434-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170610002644.8434-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58409
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

On Fri, Jun 09, 2017 at 05:26:32PM -0700, Paul Burton wrote:

> This series makes a bunch of cleanups & improvements to the cmpxchg() &
> xchg() macros & functions, allowing them to be used on values smaller
> than 4 bytes, then switches MIPS over to use generic queued spinlocks &
> queued read/write locks.

A number of nice cleanups there!

I'm wondering, have you tested the kernel size with and without this
series applied?  GCC claims since 25 years or so that inlines are as
efficient as macros but in reality macros have always been superior
which mattered for things that are expanded very often.

More recent GCCs have claimed improvments so it'd be interested to see
actual numbers - and possibly get rid of many more unmaintainable macros.

  Ralf
