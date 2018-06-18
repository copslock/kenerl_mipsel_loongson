Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 10:29:20 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52128 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeFRI3MtiqQl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 10:29:12 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE435BBE;
        Mon, 18 Jun 2018 08:29:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 012/189] MIPS: dts: Boston: Fix PCI bus dtc warnings:
Date:   Mon, 18 Jun 2018 10:11:48 +0200
Message-Id: <20180618081209.724660998@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

[ Upstream commit 2c2bf522ed8cbfaac666f7dc65cfd38de2b89f0f ]

dtc recently (v1.4.4-8-g756ffc4f52f6) added PCI bus checks. Fix the
warnings now emitted:

arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@10000000: missing bus-range for PCI bridge
arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@12000000: missing bus-range for PCI bridge
arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@14000000: missing bus-range for PCI bridge

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19070/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/dts/img/boston.dts |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -51,6 +51,8 @@
 		ranges = <0x02000000 0 0x40000000
 			  0x40000000 0 0x40000000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci0_intc 1>,
 				<0 0 0 2 &pci0_intc 2>,
@@ -79,6 +81,8 @@
 		ranges = <0x02000000 0 0x20000000
 			  0x20000000 0 0x20000000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci1_intc 1>,
 				<0 0 0 2 &pci1_intc 2>,
@@ -107,6 +111,8 @@
 		ranges = <0x02000000 0 0x16000000
 			  0x16000000 0 0x100000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci2_intc 1>,
 				<0 0 0 2 &pci2_intc 2>,
