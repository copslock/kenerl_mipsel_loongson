Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 23:26:31 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:53478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994806AbeAaWZmSRFGC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Jan 2018 23:25:42 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED4521748;
        Wed, 31 Jan 2018 22:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED4521748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-usb@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 0/2] usb: Move USB_UHCI_BIG_ENDIAN_* and select from SPARC_LEON
Date:   Wed, 31 Jan 2018 22:24:44 +0000
Message-Id: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

This series moves USB_UHCI_BIG_ENDIAN_MMIO and USB_UHCI_BIG_ENDIAN_DESC
to a place where they can be easily selected from architecture code,
like USB_EHCI_BIG_ENDIAN_* are.

Patch 1 is primarily to fix MIPS generic platform warnings when this
patch ("MIPS: fix typo BIG_ENDIAN to CPU_BIG_ENDIAN") is applied:

https://patchwork.linux-mips.org/patch/18495/

It'd be awesome if this could get included in 4.16 so that the MIPS
patch can also be included without introducing warnings.

Patch 2 allows SPARC_LEON to do the same thing as MIPS_GENERIC does,
which seemed like a natural progression.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: sparclinux@vger.kernel.org

James Hogan (2):
  usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
  sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}

 arch/sparc/Kconfig       | 2 ++
 drivers/usb/Kconfig      | 6 ++++++
 drivers/usb/host/Kconfig | 8 --------
 3 files changed, 8 insertions(+), 8 deletions(-)

base-commit: 6045f241b48f07b2fb80905bf49671f457a8c037
-- 
git-series 0.9.1
