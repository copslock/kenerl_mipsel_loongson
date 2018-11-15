Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 20:06:08 +0100 (CET)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:37168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992792AbeKOTFz24U2D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 20:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sZicvAmlKgdc03OsCN7gz6yMVDfvncSORhgFSsVwRek=; b=ry0XhBp6Y0sljg1jFwl4loEN1
        Qe9fWz4F/QICLajeJMfz/HhQh+w8ukZUcYzJ8HqmOXKOSHju0wFi2i+8ALZ1Vuj1SaX8Q5VKnz8yx
        SPnZkddVWbtolP1dM7A6KTpgGPHUy9/GJVVMlAsZGFbHbqM7sWIGO/1x0XHjMVW7Cipk2kkxyr1hJ
        Vd5bIejxSwTsmmDB95R2rpDhoyUr9w4yCKdF7xuBBEdPTTeTFSW6xJfMh/KBdohbKyhY3AkBxqQGC
        H5IvcJwh8NTU+1ghQp/1H5RtHhOf3FxF6CLFYRwyDvyXAhVAw0U4zIq+8VbLyRgksWINKSUQdJQvZ
        e+hZo7xmw==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNMxR-0005sZ-Lf; Thu, 15 Nov 2018 19:05:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
Subject: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
Date:   Thu, 15 Nov 2018 20:05:28 +0100
Message-Id: <20181115190538.17016-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+27e6d985fe6cd73880c0+5562+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

Hi all,

currently every architecture that wants to provide on of the common
periphal busses needs to add some boilerplate code and include the
right Kconfig files.   This series instead just selects the presence
(when needed) and then handles everything in the bus-specific
Kconfig file under drivers/.

Changes since v3:
 - drop the patches already merged
 - fix a typo in the PCI help text
 - split the always enable PCI on alpha change into a separate patch
 - remove the mips HT_PCI symbol
 - add a new FORCE_PCI symbol to easily allow selecting PCI support
 - new patch to consolidate PCI_DOMAINS
 - new patch to consolidate PCI_SYSCALL

Changes since v2:
 - depend on HAVE_PCI for PCIe endpoint code
 - fix some commit message typos
 - remove CONFIG_PCI from xtensa iss defconfig
 - drop EISA support from arm
 - clean up EISA selection for alpha

Changes since v1:
 - rename all HAS_* Kconfig symbols to HAVE_*
 - drop the CONFIG_PCI_QSPAN option entirely
 - drop duplicate select from powerpc
 - restore missing selection of PCI_MSI for riscv
 - update x86 and riscv defconfigs to include PCI
 - actually inclue drivers/eisa/Kconfig
 - adjust some captilizations
