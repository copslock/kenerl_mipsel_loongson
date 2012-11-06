Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 23:11:48 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51322 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826032Ab2KFWLrAge5w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2012 23:11:47 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BA95326;
        Tue,  6 Nov 2012 22:11:38 +0000 (UTC)
Date:   Tue, 6 Nov 2012 14:11:37 -0800
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
Subject: Re: [PATCH 00/16] mm: use augmented rbtrees for finding unmapped
 areas
Message-Id: <20121106141137.68bbd4ea.akpm@linux-foundation.org>
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34907
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

On Mon,  5 Nov 2012 14:46:57 -0800
Michel Lespinasse <walken@google.com> wrote:

> Earlier this year, Rik proposed using augmented rbtrees to optimize
> our search for a suitable unmapped area during mmap(). This prompted
> my work on improving the augmented rbtree code. Rik doesn't seem to
> have time to follow up on his idea at this time, so I'm sending this
> series to revive the idea.

Well, the key word here is "optimize".  Some quantitative testing
results would be nice, please!

People do occasionally see nasty meltdowns in the get_unmapped_area()
vicinity.  There was one case 2-3 years ago which was just ghastly, but
I can't find the email (it's on linux-mm somewhere).  This one might be
another case:
http://lkml.indiana.edu/hypermail/linux/kernel/1101.1/00896.html

If you can demonstrate that this patchset fixes some of all of the bad
search complexity scenarios then that's quite a win?

> These changes are against v3.7-rc4. I have not converted all applicable
> architectuers yet, but we don't necessarily need to get them all onboard
> at once - the series is fully bisectable and additional architectures
> can be added later on. I am confident enough in my tests for patches 1-8;
> however the second half of the series basically didn't get tested as
> I don't have access to all the relevant architectures.

Yes, I'll try to get these into -next so that the thousand monkeys at
least give us some compilation coverage testing.  Hopefully the
relevant arch maintainers will find time to perform a runtime test.

> Patch 1 is the validate_mm() fix from Bob Liu (+ fixed-the-fix from me :)

I grabbed this one separately, as a post-3.6 fix.
