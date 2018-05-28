Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 13:04:29 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994840AbeE1LEWTDuR0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 13:04:22 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6E72075C;
        Mon, 28 May 2018 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527505456;
        bh=TDPgzZWbRnSsWuK7Tkvz3+AAHYO8LbWAKrSED7tmDuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxQMCJCo5mKtGzO+BJugtzbReZC2IiGguSBBEBcvFV15MuINNaB8cfddPgEsyUtsS
         Rs/d55vmUX3Hh4hCayn/fTNPT5ksOAS6eXvLBhObnfR98RqZ7Ne2A7k+p4wbrLNgtK
         gdYCXHFD23YfCU8H2tLXoanphI7hFPm/qBXLk/vA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.16 001/272] MIPS: xilfpga: Stop generating useless dtb.o
Date:   Mon, 28 May 2018 12:00:34 +0200
Message-Id: <20180528100240.332168472@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64109
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

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit a5a92abbce56c41ff121db41a33b9c0a0ff39365 upstream.

A dtb.o is generated from nexys4ddr.dts but this is never used since it
has been moved to mips/generic with commit b35565bb16a5 ("MIPS: generic:
Add support for MIPSfpga").

Fixes: b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15+
Patchwork: https://patchwork.linux-mips.org/patch/19244/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/dts/xilfpga/Makefile |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= nexys4ddr.dtb
-
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
