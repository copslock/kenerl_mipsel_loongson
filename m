Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 13:31:53 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:41906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993871AbdCTMbpx0U3M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Mar 2017 13:31:45 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F9D80D;
        Mon, 20 Mar 2017 05:31:39 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F1363F581;
        Mon, 20 Mar 2017 05:31:38 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9B8121AE1365; Mon, 20 Mar 2017 12:31:50 +0000 (GMT)
Date:   Mon, 20 Mar 2017 12:31:50 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: mainline build: 208 builds: 0 failed, 208 passed, 422 warnings
 (v4.11-rc2-164-gdefc7d752265)
Message-ID: <20170320123150.GJ17263@arm.com>
References: <58c97f8f.c4b5190a.8c4e4.300d@mx.google.com>
 <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1jHhM=80Zo59JoDNd2RKwTfdR_i61_=ASqqUeJ1oecxg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Wed, Mar 15, 2017 at 09:02:06PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 15, 2017 at 6:53 PM, kernelci.org bot <bot@kernelci.org> wrote:
> >
> > mainline build: 208 builds: 0 failed, 208 passed, 422 warnings (v4.11-rc2-164-gdefc7d752265)
> 
> The last build failure in mainline is gone now, though I don't know
> what fixed it.
> Let's hope this doesn't come back as the cause was apparently a race condition
> in Kbuild that might have stopped triggering.
> 
> > Warnings summary:
> > 409 :1325:2: warning: #warning syscall statx not implemented [-Wcpp]
> 
> The warning triggers for arm, arm64 and mips on every build. I saw a patch
> was posted for asm-generic, which takes care of arm64.
> 
> Catalin and Will: can you take this through the arm64 tree? I don't have
> anything else for asm-generic at the moment.

Yes, I'll pick that up.

Will
