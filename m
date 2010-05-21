Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 20:06:08 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59931 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491183Ab0EUSGE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 May 2010 20:06:04 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4LI60GS023540;
        Fri, 21 May 2010 19:06:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4LI5xEB023536;
        Fri, 21 May 2010 19:05:59 +0100
Date:   Fri, 21 May 2010 19:05:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Use GCC __builtin_prefetch() to implement
 prefetch().
Message-ID: <20100521180558.GA20815@linux-mips.org>
References: <1273866258-2223-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1273866258-2223-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 14, 2010 at 12:44:18PM -0700, David Daney wrote:

> GCC's __builtin_prefetch() was introduced a long time ago, all
> supported GCC versions have it.  Lets do what the big boys up in
> linux/prefetch.h do, except we use '1' as the third parameter to
> provoke 'PREF 0,...'  and 'PREF 1,...' instead of other prefetch
> hints.
> 
> This allows for better code generation.  In theory the existing
> embedded asm could be optimized, but the compiler has these builtins,
> so there is really no point.

Applied, thanks.

  Ralf
