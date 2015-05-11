Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:56:38 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027463AbbEKRzoj-hbt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:44 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0A0FBB3;
        Mon, 11 May 2015 17:55:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 13/72] MIPS: OCTEON: fix PCI interrupt mapping for D-Link DSR-1000N
Date:   Mon, 11 May 2015 10:54:19 -0700
Message-Id: <20150511175437.505049767@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47314
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Aaro Koskinen <aaro.koskinen@iki.fi>

Commit b083518c52ab75a345d668ca7fa41e530df08d51 upstream.

Fix PCI interrupt mapping for DSR1000N. This will get the PCI slot
interrupts working. The mapping is based on D-Link GPL tarball.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9593/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/pci/pci-octeon.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -214,6 +214,8 @@ const char *octeon_get_pci_interrupts(vo
 		return "AAABAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
 	case CVMX_BOARD_TYPE_BBGW_REF:
 		return "AABCD";
+	case CVMX_BOARD_TYPE_CUST_DSR1000N:
+		return "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC";
 	case CVMX_BOARD_TYPE_THUNDER:
 	case CVMX_BOARD_TYPE_EBH3000:
 	default:
