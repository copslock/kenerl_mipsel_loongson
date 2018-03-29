Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 23:46:18 +0200 (CEST)
Received: from ms.lwn.net ([45.79.88.28]:52750 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990422AbeC2VqLokAgz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Mar 2018 23:46:11 +0200
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 107BFAAB;
        Thu, 29 Mar 2018 21:46:08 +0000 (UTC)
Date:   Thu, 29 Mar 2018 15:46:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 00/32] docs/vm: convert to ReST format
Message-ID: <20180329154607.3d8bda75@lwn.net>
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-Path: <corbet@lwn.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: corbet@lwn.net
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

On Wed, 21 Mar 2018 21:22:16 +0200
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> These patches convert files in Documentation/vm to ReST format, add an
> initial index and link it to the top level documentation.
> 
> There are no contents changes in the documentation, except few spelling
> fixes. The relatively large diffstat stems from the indentation and
> paragraph wrapping changes.
> 
> I've tried to keep the formatting as consistent as possible, but I could
> miss some places that needed markup and add some markup where it was not
> necessary.

So I've been pondering on these for a bit.  It looks like a reasonable and
straightforward RST conversion, no real complaints there.  But I do have a
couple of concerns...

One is that, as we move documentation into RST, I'm really trying to
organize it a bit so that it is better tuned to the various audiences we
have.  For example, ksm.txt is going to be of interest to sysadmin types,
who might want to tune it.  mmu_notifier.txt is of interest to ...
somebody, but probably nobody who is thinking in user space.  And so on.

So I would really like to see this material split up and put into the
appropriate places in the RST hierarchy - admin-guide for administrative
stuff, core-api for kernel development topics, etc.  That, of course,
could be done separately from the RST conversion, but I suspect I know
what will (or will not) happen if we agree to defer that for now :)

The other is the inevitable merge conflicts that changing that many doc
files will create.  Sending the patches through Andrew could minimize
that, I guess, or at least make it his problem.  Alternatively, we could
try to do it as an end-of-merge-window sort of thing.  I can try to manage
that, but an ack or two from the mm crowd would be nice to have.

Thanks,

jon
