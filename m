Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 17:42:08 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:59796 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995092AbdHDPmCYrRM1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 17:42:02 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E48D721DBE; Fri,  4 Aug 2017 17:41:50 +0200 (CEST)
Received: from windsurf.lan (LStLambert-657-1-97-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id BCEF0208B5;
        Fri,  4 Aug 2017 17:41:50 +0200 (CEST)
Date:   Fri, 4 Aug 2017 17:41:51 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170804174151.2eea9af3@windsurf.lan>
In-Reply-To: <20170804151920.GA11317@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
        <20170804000556.GC30597@linux-mips.org>
        <20170804151920.GA11317@linux-mips.org>
Organization: Free Electrons
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Hello,

On Fri, 4 Aug 2017 17:19:20 +0200, Ralf Baechle wrote:

> > > The bug can be reproduced by building with the toolchain available at
> > > http://toolchains.free-electrons.com/downloads/2017.08-rc1-fix-binutils/toolchains/mips64r6el-n32/tarballs/mips64r6el-n32--glibc--bleeding-edge-2017.05-1453-ga703fdd-1.tar.bz2
> > > and building with the attached kernel configuration file.
> > > 
> > > It is not clear to me if this is a kernel issue (lack of __multi3 in
> > > arch/mips/lib/), or a gcc bug in that it shouldn't emit a call to this
> > > function.
> > > 
> > > FWIW, sparc64 had a similar issue, and they added __multi3 in their
> > > libgcc replacement, see commit
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/sparc/lib?id=1b4af13ff2cc6897557bb0b8d9e2fad4fa4d67aa.  
> > 
> > I think these days we've given up the stuborn resistance of the old days
> > against adding new libgcc1 functions to the kernel, so we should probably
> > just add it.
> > 
> > I'm looking into this but a small wrench into the gear is that I'm still
> > on GCC 6 so I'm off to building myself a cross-gcc first ...  
> 
> I now can reproduce the issue with vanilla FSF binutils 2.28 and GCC 7.1.0.

Great! However, looking at the functions that end up calling __multi3,
I'm wondering why suddenly gcc 7.x needs to call such a function, while
the same code was compiling without __multi3 in libgcc with gcc 6.x.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
