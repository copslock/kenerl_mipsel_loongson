Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2012 01:05:20 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903384Ab2IMXFQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2012 01:05:16 +0200
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8D9D9E3;
        Thu, 13 Sep 2012 23:05:07 +0000 (UTC)
Date:   Thu, 13 Sep 2012 16:05:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic
 page
Message-Id: <20120913160506.d394392a.akpm@linux-foundation.org>
In-Reply-To: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34496
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

On Mon, 20 Aug 2012 16:52:29 +0300
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Clearing a 2MB huge page will typically blow away several levels of CPU
> caches.  To avoid this only cache clear the 4K area around the fault
> address and use a cache avoiding clears for the rest of the 2MB area.
> 
> This patchset implements cache avoiding version of clear_page only for
> x86. If an architecture wants to provide cache avoiding version of
> clear_page it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
> clear_page_nocache() and clear_user_highpage_nocache().

Patchset looks nice to me, but the changelogs are terribly short of
performance measurements.  For this sort of change I do think it is
important that pretty exhaustive testing be performed, and that the
results (or a readable summary of them) be shown.  And that testing
should be designed to probe for slowdowns, not just the speedups!
