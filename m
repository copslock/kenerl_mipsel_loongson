Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 17:19:29 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#1000 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23995087AbdHDPTVNIxyX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Aug 2017 17:19:21 +0200
Date:   Fri, 4 Aug 2017 17:19:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170804151920.GA11317@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
 <20170804000556.GC30597@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804000556.GC30597@linux-mips.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Aug 04, 2017 at 02:05:57AM +0200, Ralf Baechle wrote:

> > 
> > When trying to build the current Linux master with a gcc 7.x toolchain
> > for mips64r6-n32, I'm getting the following build failure:
> > 
> > crypto/scompress.o: In function `.L31':
> > scompress.c:(.text+0x2a0): undefined reference to `__multi3'
> > drivers/base/component.o: In function `.L97':
> > component.c:(.text+0x4a4): undefined reference to `__multi3'
> > drivers/base/component.o: In function `component_master_add_with_match':
> > component.c:(.text+0x8c4): undefined reference to `__multi3'
> > net/core/ethtool.o: In function `ethtool_set_per_queue_coalesce':
> > ethtool.c:(.text+0x1ab0): undefined reference to `__multi3'
> > Makefile:1000: recipe for target 'vmlinux' failed
> > make[2]: *** [vmlinux] Error 1
> > 
> > Taking the example from net/core/ethtool.o, objdump says:
> > 
> >     1aac:       00408025        move    s0,v0
> >     1ab0:       e8000000        balc    1ab4 <ethtool_set_per_queue_coalesce+0x7c>
> >     1ab4:       14600000        bnez    v1,1ab8 <ethtool_set_per_queue_coalesce+0x80>
> > 
> > And readelf tells us:
> > 
> > Relocation section '.rela.text' at offset 0xaa00 contains 1189 entries:
> >   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> > [...]
> > 000000001ab0  023a0000003d R_MIPS_PC26_S2    0000000000000000 __multi3 - 4
> >                     Type2: R_MIPS_NONE      
> >                     Type3: R_MIPS_NONE      
> > [...]
> > Symbol table '.symtab' contains 586 entries:
> > [...]
> >    570: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  UND __multi3
> > 
> > __multi3() is normally provided by libgcc, but of course the kernel
> > doesn't link with libgcc.
> > 
> > The bug can be reproduced by building with the toolchain available at
> > http://toolchains.free-electrons.com/downloads/2017.08-rc1-fix-binutils/toolchains/mips64r6el-n32/tarballs/mips64r6el-n32--glibc--bleeding-edge-2017.05-1453-ga703fdd-1.tar.bz2
> > and building with the attached kernel configuration file.
> > 
> > It is not clear to me if this is a kernel issue (lack of __multi3 in
> > arch/mips/lib/), or a gcc bug in that it shouldn't emit a call to this
> > function.
> > 
> > FWIW, sparc64 had a similar issue, and they added __multi3 in their
> > libgcc replacement, see commit
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/sparc/lib?id=1b4af13ff2cc6897557bb0b8d9e2fad4fa4d67aa.
> 
> I think these days we've given up the stuborn resistance of the old days
> against adding new libgcc1 functions to the kernel, so we should probably
> just add it.
> 
> I'm looking into this but a small wrench into the gear is that I'm still
> on GCC 6 so I'm off to building myself a cross-gcc first ...

I now can reproduce the issue with vanilla FSF binutils 2.28 and GCC 7.1.0.

  Ralf
