Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Sep 2010 01:51:52 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491001Ab0ISXvp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Sep 2010 01:51:45 +0200
Date:   Mon, 20 Sep 2010 00:51:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bernhard Walle <walle@corscience.de>
Cc:     linux-mips@linux-mips.org, ddaney@caviumnetworks.com,
        akpm@linux-foundation.org, ebiederm@xmission.com, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: N32: Fix getdents64 syscall for n32
Message-ID: <20100919235131.GA29977@linux-mips.org>
References: <1283501734-6532-1-git-send-email-walle@corscience.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1283501734-6532-1-git-send-email-walle@corscience.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14968

On Fri, Sep 03, 2010 at 10:15:34AM +0200, Bernhard Walle wrote:

> Commit 31c984a5acabea5d8c7224dc226453022be46f33 introduced a new syscall
> getdents64. However, in the syscall table, the new syscall still refers
> to the old getdents which doesn't work.
> 
> The problem appeared with a system that uses the eglibc 2.12-r11187
> (that utilizes that new syscall) is very confused. The fix has been
> tested with that eglibc version.

Thanks Bernhard!

  Ralf
