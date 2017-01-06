Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 10:44:25 +0100 (CET)
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:44746 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdAFJoSYdSc5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 10:44:18 +0100
Received: from elsass.dev.6wind.com (unknown [10.16.0.149])
        by proxy.6wind.com (Postfix) with ESMTPS id 7A7D2254DC;
        Fri,  6 Jan 2017 10:44:06 +0100 (CET)
Received: from root by elsass.dev.6wind.com with local (Exim 4.84_2)
        (envelope-from <root@elsass.dev.6wind.com>)
        id 1cPR49-0004sP-2T; Fri, 06 Jan 2017 10:44:05 +0100
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     arnd@arndb.de
Cc:     mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net
Subject: [PATCH v2 0/7] uapi: export all headers under uapi directories
Date:   Fri,  6 Jan 2017 10:43:52 +0100
Message-Id: <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
Return-Path: <root@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.dichtel@6wind.com
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


Here is the v2 of this series. The first 5 patches are just cleanup: some
exported headers were still under a non-uapi directory.
The patch 6 was spotted by code review: there is no in-tree user of this
functionality.
The last patch remove the use of header-y. Now all files under an uapi
directory are exported.

asm is a bit special, most of architectures export asm/<arch>/include/uapi/asm
only, but there is two exceptions:
 - cris which exports arch/cris/include/uapi/arch-v[10|32];
 - tile which exports arch/tile/include/uapi/arch.
Because I don't know if the output of 'make headers_install_all' can be changed,
I introduce subdir-y in Kbuild file. The headers_install_all target copies all
asm/<arch>/include/uapi/asm to usr/include/asm-<arch> but
arch/cris/include/uapi/arch-v[10|32] and arch/tile/include/uapi/arch are not
prefixed (they are put asis in usr/include/). If it's acceptable to modify the
output of 'make headers_install_all' to export asm headers in
usr/include/asm-<arch>/asm, then I could remove this new subdir-y and exports
everything under arch/<arch>/include/uapi/.

Note also that exported files for asm are a mix of files listed by:
 - include/uapi/asm-generic/Kbuild.asm;
 - arch/x86/include/uapi/asm/Kbuild;
 - arch/x86/include/asm/Kbuild.
This complicates a lot the processing (arch/x86/include/asm/Kbuild is also
used by scripts/Makefile.asm-generic).

This series has been tested with a 'make headers_install' on x86 and a
'make headers_install_all'. I've checked the result of both commands.

This patch is built against linus tree. I don't know if it should be
made against antoher tree.

Comments are welcomed,
Nicolas
