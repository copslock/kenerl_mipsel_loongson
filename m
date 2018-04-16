Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 22:35:50 +0200 (CEST)
Received: from ms.lwn.net ([45.79.88.28]:57838 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994621AbeDPUfnnyfea (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Apr 2018 22:35:43 +0200
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DC1262EF;
        Mon, 16 Apr 2018 20:35:39 +0000 (UTC)
Date:   Mon, 16 Apr 2018 14:35:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
Message-ID: <20180416143538.40a40457@lwn.net>
In-Reply-To: <20180415173655.GB31176@rapoport-lnx>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
        <20180329154607.3d8bda75@lwn.net>
        <20180401063857.GA3357@rapoport-lnx>
        <20180413135551.0e6d1b12@lwn.net>
        <20180415173655.GB31176@rapoport-lnx>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-Path: <corbet@lwn.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63570
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

On Sun, 15 Apr 2018 20:36:56 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> I didn't mean we should keep it as unorganized jumble of stuff and I agree
> that splitting the documentation by audience is better because developers
> are already know how to find it :)
> 
> I just thought that putting the doc into the place should not be done
> immediately after mechanical ReST conversion but rather after improving the
> contents.

OK, this is fine.  I'll go ahead and apply the set, but then I'll be
watching to see that the other improvements come :)

In applying the set, there was a significant set of conflicts with
vm/hmm.rst; hopefully I've sorted those out properly.

Thanks,

jon
