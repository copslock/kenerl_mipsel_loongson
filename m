Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 13:42:20 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:48088 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991672AbdAKMmMwviNe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 13:42:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E4843180B0;
        Wed, 11 Jan 2017 13:42:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9vriD579acaL; Wed, 11 Jan 2017 13:42:05 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id C44FF18158;
        Wed, 11 Jan 2017 13:42:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC231E08E;
        Wed, 11 Jan 2017 13:42:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89F4A1E092;
        Wed, 11 Jan 2017 13:42:02 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 11 Jan 2017 13:42:02 +0100 (CET)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by seth.se.axis.com (Postfix) with ESMTP id 76718DAE;
        Wed, 11 Jan 2017 13:42:02 +0100 (CET)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id 72B55800EE; Wed, 11 Jan 2017 13:42:02 +0100 (CET)
Date:   Wed, 11 Jan 2017 13:42:02 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        airlied@linux.ie, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        linux-c6x-dev@linux-c6x.org, linux-rdma@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
        coreteam@netfilter.org, fcoe-devel@open-fcoe.org,
        xen-devel@lists.xenproject.org, linux-snps-arc@lists.infradead.org,
        linux-media@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        mmarek@suse.com, netfilter-devel@vger.kernel.org,
        linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        davem@davemloft.net
Subject: Re: [PATCH v2 0/7] uapi: export all headers under uapi directories
Message-ID: <20170111124202.GD7275@axis.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3131144.4Ej3KFWRbz@wuerfel>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
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

On Mon, Jan 09, 2017 at 12:33:58PM +0100, Arnd Bergmann wrote:
> On Friday, January 6, 2017 10:43:52 AM CET Nicolas Dichtel wrote:
> > Here is the v2 of this series. The first 5 patches are just cleanup: some
> > exported headers were still under a non-uapi directory.
> 
> Since this is meant as a cleanup, I commented on this to point out a cleaner
> way to do the same.
> 
> > The patch 6 was spotted by code review: there is no in-tree user of this
> > functionality.
> > The last patch remove the use of header-y. Now all files under an uapi
> > directory are exported.
> 
> Very nice!
> 
> > asm is a bit special, most of architectures export asm/<arch>/include/uapi/asm
> > only, but there is two exceptions:
> >  - cris which exports arch/cris/include/uapi/arch-v[10|32];
> 
> This is interesting, though not your problem. Maybe someone who understands
> cris better can comment on this: How is the decision made about which of
> the arch/user.h headers gets used? I couldn't find that in the sources,
> but it appears to be based on kernel compile-time settings, which is
> wrong for user space header files that should be independent of the kernel
> config.

I believe it's since the CRISv10 and CRISv32 are very different beasts,
and that is selected via kernel config...

This part of the CRIS port has been transformed a couple of times from
the original layout without uapi, and there's still some legacy silliness,
where some files might have been exported but never used from userspace
except for some corner cases.

> >  - tile which exports arch/tile/include/uapi/arch.
> > Because I don't know if the output of 'make headers_install_all' can be changed,
> > I introduce subdir-y in Kbuild file. The headers_install_all target copies all
> > asm/<arch>/include/uapi/asm to usr/include/asm-<arch> but
> > arch/cris/include/uapi/arch-v[10|32] and arch/tile/include/uapi/arch are not
> > prefixed (they are put asis in usr/include/). If it's acceptable to modify the
> > output of 'make headers_install_all' to export asm headers in
> > usr/include/asm-<arch>/asm, then I could remove this new subdir-y and exports
> > everything under arch/<arch>/include/uapi/.
> 
> I don't know if anyone still uses "make headers_install_all", I suspect
> distros these days all use "make headers_install", so it probably
> doesn't matter much.
> 
> In case of cris, it should be easy enough to move all the contents of the
> uapi/arch-*/*.h headers into the respective uapi/asm/*.h headers, they
> only seem to be referenced from there.

This would seem to be a reasonable change.

> For tile, I suspect that would not work as the arch/*.h headers are
> apparently defined as interfaces for both user space and kernel.
> 
> > Note also that exported files for asm are a mix of files listed by:
> >  - include/uapi/asm-generic/Kbuild.asm;
> >  - arch/x86/include/uapi/asm/Kbuild;
> >  - arch/x86/include/asm/Kbuild.
> > This complicates a lot the processing (arch/x86/include/asm/Kbuild is also
> > used by scripts/Makefile.asm-generic).
> > 
> > This series has been tested with a 'make headers_install' on x86 and a
> > 'make headers_install_all'. I've checked the result of both commands.
> > 
> > This patch is built against linus tree. I don't know if it should be
> > made against antoher tree.
> 
> The series should probably get merged through the kbuild tree, but testing
> it on mainline is fine here.
> 
> 	Arnd

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
