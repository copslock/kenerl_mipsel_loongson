Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2006 00:44:55 +0100 (BST)
Received: from smtp2.pp.htv.fi ([213.243.153.35]:7557 "EHLO smtp2.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S3686519AbWF2Xoq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2006 00:44:46 +0100
Received: from vermeer (cs181021247.pp.htv.fi [82.181.21.247])
	by smtp2.pp.htv.fi (Postfix) with ESMTP id D381C296B4C;
	Fri, 30 Jun 2006 02:44:45 +0300 (EEST)
Received: from samuel by vermeer with local (Exim 4.62)
	(envelope-from <samuel@sortiz.org>)
	id 1FwCv9-0003jU-SV; Fri, 30 Jun 2006 09:56:07 +0300
Date:	Fri, 30 Jun 2006 09:56:07 +0300
From:	Samuel Ortiz <samuel@sortiz.org>
To:	Adrian Bunk <bunk@stusta.de>,
	"David S. Miller" <davem@davemloft.net>
Cc:	Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
	irda-users@lists.sourceforge.net
Subject: [PATCH 2/2] [IrDA] Fix the AU1000 FIR dependencies
Message-ID: <20060630065607.GB4729@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <20060629154148.GA19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629154148.GA19712@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <samuel@sortiz.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: samuel@sortiz.org
Precedence: bulk
X-list: linux-mips

Hi Dave,

AU1000 FIR is broken, it should depend on SOC_AU1000.

Spotted by Jean-Luc Leger.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Samuel Ortiz <samuel@sortiz.org>
---
 drivers/net/irda/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index d2ce489..e9e6d99 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -350,7 +350,7 @@ config TOSHIBA_FIR
 
 config AU1000_FIR
 	tristate "Alchemy Au1000 SIR/FIR"
-	depends on MIPS_AU1000 && IRDA
+	depends on SOC_AU1000 && IRDA
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
-- 
1.4.0
