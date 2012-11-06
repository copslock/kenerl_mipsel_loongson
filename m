Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 23:38:41 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826037Ab2KFWi0fh4nw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2012 23:38:26 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 24D6E26D;
        Tue,  6 Nov 2012 22:38:20 +0000 (UTC)
Date:   Tue, 6 Nov 2012 14:38:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 07/16] mm: fix cache coloring on x86_64 architecture
Message-Id: <20121106143819.4309031c.akpm@linux-foundation.org>
In-Reply-To: <1352155633-8648-8-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
        <1352155633-8648-8-git-send-email-walken@google.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon,  5 Nov 2012 14:47:04 -0800
Michel Lespinasse <walken@google.com> wrote:

> Fix the x86-64 cache alignment code to take pgoff into account.
> Use the x86 and MIPS cache alignment code as the basis for a generic
> cache alignment function.
> 
> The old x86 code will always align the mmap to aliasing boundaries,
> even if the program mmaps the file with a non-zero pgoff.
> 
> If program A mmaps the file with pgoff 0, and program B mmaps the
> file with pgoff 1. The old code would align the mmaps, resulting in
> misaligned pages:
> 
> A:  0123
> B:  123
> 
> After this patch, they are aligned so the pages line up:
> 
> A: 0123
> B:  123

We have a bit of a history of fiddling with coloring and finding that
the changes made at best no improvement.  Or at least, that's my
perhaps faulty memory of it.

This one needs pretty careful testing, please.
