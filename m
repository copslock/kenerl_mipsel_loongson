Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 14:05:23 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993060AbdKMND6Qzt6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 14:03:58 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5C8BAAE;
        Mon, 13 Nov 2017 13:03:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.13 19/33] MIPS: BMIPS: Fix missing cbr address
Date:   Mon, 13 Nov 2017 13:56:40 +0100
Message-Id: <20171113125612.963391013@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171113125611.096767733@linuxfoundation.org>
References: <20171113125611.096767733@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60867
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

4.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaedon Shin <jaedon.shin@gmail.com>

commit ea4b3afe1eac8f88bb453798a084fba47a1f155a upstream.

Fix NULL pointer access in BMIPS3300 RAC flush.

Fixes: 738a3f79027b ("MIPS: BMIPS: Add early CPU initialization code")
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16423/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp-bmips.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -589,11 +589,11 @@ void __init bmips_cpu_setup(void)
 
 		/* Flush and enable RAC */
 		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-		__raw_writel(cfg | 0x100, BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0x100, cbr + BMIPS_RAC_CONFIG);
 		__raw_readl(cbr + BMIPS_RAC_CONFIG);
 
 		cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
-		__raw_writel(cfg | 0xf, BMIPS_RAC_CONFIG);
+		__raw_writel(cfg | 0xf, cbr + BMIPS_RAC_CONFIG);
 		__raw_readl(cbr + BMIPS_RAC_CONFIG);
 
 		cfg = __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
