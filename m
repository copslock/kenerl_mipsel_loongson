Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 03:35:34 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:52947 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011113AbbAJCfc0S4Sr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2015 03:35:32 +0100
Received: by mail-ob0-f169.google.com with SMTP id vb8so15941703obc.0;
        Fri, 09 Jan 2015 18:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qOsN8s9fAyyFhXt7x69hyLwd0krqpO9CDCeM+gmeLg0=;
        b=gBF2oyPPA4EqfvrQevFQP9Otbe7/owzl2zSrx8fZQjCrQVyw/FOppKp7c5wCCzBWUq
         vSYCsxybz3MTqy5hEHuOzl/BGlUha4/UykRxU9IyA7/IVFwWWUrreoj1PSMXErpIvvmF
         yZUrOauwVZabUWsZoQwxbXo5cJvcHsrb9MJunnXJsi56kO3zYL11LMp4cXRXn4yEd2PD
         l2mY2oIKNSLdyoHTTfTeGTZz/GAiNkWR0GmZRH905XxkK5y5WssNm0aHBC3s3zquq140
         yhCE9Y21y0HYmHvnM9EaiLbUQ4/EGPaarqd7n0i4uHTkubQVUGXjEPfEJ6wa8Mfi6Ami
         uJCA==
X-Received: by 10.182.18.66 with SMTP id u2mr11123144obd.33.1420857326295;
        Fri, 09 Jan 2015 18:35:26 -0800 (PST)
Received: from rob-laptop.herring.priv (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by mx.google.com with ESMTPSA id b192sm5326257oih.4.2015.01.09.18.35.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jan 2015 18:35:24 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        cbe-oss-dev@lists.ozlabs.org, linux-am33-list@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 00/16] PCI generic configuration space accessors
Date:   Fri,  9 Jan 2015 20:34:34 -0600
Message-Id: <1420857290-8373-1-git-send-email-robh@kernel.org>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

This series adds common accessor functions for PCI configuration space
accesses. This supports most PCI hosts with memory mapped configuration
space like ECAM or hosts with memory mapped address/data registers. ECAM
is not generically supported by this series, but could be added on top
of this. While some hosts have standard address decoding which could be 
common as well, the various checks on bus numbers and device numbers are 
quite varied. It is unclear how much of that is really necessary or 
could be common. 

The first 4 patches are preparatory cleanup. Patch 5 introduces the
common accessors. The remaining patches convert several PCI host
controllers. This is in no way a complete list of host controllers. The
conversion of more hosts should be possible. The Designware controller
in particular should be able to be converted, but its config space
accessors are a mess of override-able functions that I've not gotten my
head around.

This series is available here [1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-config-access

Rob Herring (16):
  frv: add struct pci_ops member names to initialization
  mips: add struct pci_ops member names to initialization
  mn10300: add struct pci_ops member names to initialization
  powerpc: add struct pci_ops member names to initialization
  pci: introduce common pci config space accessors
  ARM: cns3xxx: convert PCI to use generic config accesses
  ARM: integrator: convert PCI to use generic config accesses
  ARM: sa1100: convert PCI to use generic config accesses
  ARM: ks8695: convert PCI to use generic config accesses
  powerpc: fsl_pci: convert PCI to use generic config accesses
  powerpc: powermac: convert PCI to use generic config accesses
  pci/host: generic: convert to use generic config accesses
  pci/host: rcar-gen2: convert to use generic config accesses
  pci/host: tegra: convert to use generic config accesses
  pci/host: xgene: convert to use generic config accesses
  pci/host: xilinx: convert to use generic config accesses

 arch/arm/mach-cns3xxx/pcie.c                   |  52 ++----
 arch/arm/mach-integrator/pci_v3.c              |  61 +-------
 arch/arm/mach-ks8695/pci.c                     |  77 +--------
 arch/arm/mach-sa1100/pci-nanoengine.c          |  94 +----------
 arch/frv/mb93090-mb00/pci-vdk.c                |   4 +-
 arch/mips/pci/pci-bcm1480.c                    |   4 +-
 arch/mips/pci/pci-octeon.c                     |   4 +-
 arch/mips/pci/pcie-octeon.c                    |  12 +-
 arch/mn10300/unit-asb2305/pci.c                |   4 +-
 arch/powerpc/platforms/cell/celleb_scc_pciex.c |   4 +-
 arch/powerpc/platforms/powermac/pci.c          | 209 +++++--------------------
 arch/powerpc/sysdev/fsl_pci.c                  |  46 +-----
 drivers/pci/access.c                           |  87 ++++++++++
 drivers/pci/host/pci-host-generic.c            |  51 +-----
 drivers/pci/host/pci-rcar-gen2.c               |  51 +-----
 drivers/pci/host/pci-tegra.c                   |  55 +------
 drivers/pci/host/pci-xgene.c                   | 150 ++----------------
 drivers/pci/host/pcie-xilinx.c                 |  88 ++---------
 include/linux/pci.h                            |  11 ++
 19 files changed, 212 insertions(+), 852 deletions(-)

-- 
2.1.0
