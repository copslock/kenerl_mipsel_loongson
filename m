Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 18:59:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50973 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010827AbbGHQ7tPKmr- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 18:59:49 +0200
Received: from localhost (c-67-161-9-76.hsd1.ca.comcast.net [67.161.9.76])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61C5CABA;
        Wed,  8 Jul 2015 16:59:42 +0000 (UTC)
Date:   Wed, 8 Jul 2015 10:00:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V3 0/5] Allow user to request memory to be locked on
 page fault
Message-Id: <20150708100008.e8a000ec.akpm@linux-foundation.org>
In-Reply-To: <20150708132302.GB4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
        <20150707141613.f945c98279dcb71c9743d5f2@linux-foundation.org>
        <20150708132302.GB4669@akamai.com>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.9; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48125
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

On Wed, 8 Jul 2015 09:23:02 -0400 Eric B Munson <emunson@akamai.com> wrote:

> > I don't know whether these syscalls should be documented via new
> > manpages, or if we should instead add them to the existing
> > mlock/munlock/mlockall manpages.  Michael, could you please advise?
> > 
> 
> Thanks for adding the series.  I owe you several updates (getting the
> new syscall right for all architectures and a set of tests for the new
> syscalls).  Would you prefer a new pair of patches or I update this set?

It doesn't matter much.  I guess a full update will be more convenient
at your end.
