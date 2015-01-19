Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 10:19:32 +0100 (CET)
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:39098 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011771AbbASJTb0ZWfU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 10:19:31 +0100
Received: from resomta-po-01v.sys.comcast.net ([96.114.154.225])
        by resqmta-po-02v.sys.comcast.net with comcast
        id hlKP1p0024s37d401lKPAw; Mon, 19 Jan 2015 09:19:23 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-po-01v.sys.comcast.net with comcast
        id hlKN1p0060uk1nt01lKNPJ; Mon, 19 Jan 2015 09:19:23 +0000
Message-ID: <54BCCC18.8020706@gentoo.org>
Date:   Mon, 19 Jan 2015 04:19:20 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: PCI: Add a hook for IORESOURCE_BUS in pci_controller/bridge_controller
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421659163;
        bh=MjJ2rf6W2vR6OmyumTXbzo5KDUoQ9bGvUJu0tjICcOM=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=tHkaDZjwBXST/PYF5Ra/XRAD0bEy0cNLOgmd4KnEqIv4peWkjkMTpJ5XQ334tLlIV
         llub1t3lVmipGKvs8eeptY9nf/sAeqxZhUymndEgy8OXBmqfTjTLk4x0X1RiG7pgG9
         FOIk8mT+ikfaIJ/ppHTLUNpaW9Ijw34Gl9K8HDhPC4wxsW7wYwMDXEDnmjqeDb0JiY
         XIQqaqLcCESUBYgyAIj6EH3vBVmlmefJvqWuYfaYegohp78PKD4CohRg33X4/t/bMn
         w7IkqEvxR4emVFRZYrNCCd/SPuAhiYOm1xOAzNtSZhe/rHqXFEI3FxRvRxBzBEVufr
         jpj2fqJ/wMnVA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

On SGI Origin 2k/Onyx2 and SGI Octane systems, there can exist multiple PCI
buses attached to the Xtalk bus.  The current code will stop counting PCI buses
after it finds the first one.  If one installs the optional PCI cardcage
("shoebox") into these systems, because of the order of the Xtalk widgets, the
current PCI code will find the cardcage first, and fail to detect the BaseIO
PCI devices, which are on a higher Xtalk widget ID.

This patch adds the hooks needed for resolving this issue in the IP27 PCI code
(in a later patch).

Verified on both an SGI Onyx2 and an SGI Octane.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/pci.h        |    2 ++
 arch/mips/include/asm/pci/bridge.h |    1 +
 arch/mips/pci/pci.c                |    5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

Ralf,

  I have the needed IP27 changes, but I tied them up with some cleanups to the
Xtalk code to make it more centralized so I could remove duplicate code from
the Octane's patches.  I've still gotta fiddle with that code some more and
remove the debug bits, but this change should be safe to go in by itself, as
it's a prerequisite.  I'll probably send the IP27 bits in along with the IOC3
stuff, because IP27 seems to be very flakey (at least my Onyx2 was) with the
in-tree IOC3 bits.  Most common was requiring several reboots to properly
detect the MAC address.  Under the metadriver, it detects things fine.


linux-mips-pci-busn.patch
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 6952962..4610c9f 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -35,6 +35,8 @@ struct pci_controller {
 	struct resource *io_resource;
 	unsigned long io_offset;
 	unsigned long io_map_base;
+	struct resource *busn_resource;
+	unsigned long busn_offset;
 
 	unsigned int index;
 	/* For compatibility with current (as of July 2003) pciutils
diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index af2c8a3..8d7a63b 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -835,6 +835,7 @@ struct bridge_controller {
 	struct pci_controller	pc;
 	struct resource		mem;
 	struct resource		io;
+	struct resource		busn;
 	bridge_t		*base;
 	nasid_t			nasid;
 	unsigned int		widget_id;
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 1bf60b1..0e3f437 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -91,7 +91,10 @@ static void pcibios_scanbus(struct pci_controller *hose)
 
 	pci_add_resource_offset(&resources,
 				hose->mem_resource, hose->mem_offset);
-	pci_add_resource_offset(&resources, hose->io_resource, hose->io_offset);
+	pci_add_resource_offset(&resources,
+				hose->io_resource, hose->io_offset);
+	pci_add_resource_offset(&resources,
+				hose->busn_resource, hose->busn_offset);
 	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
 				&resources);
 	if (!bus)
